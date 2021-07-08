package org.agileware.natural.stepmatcher.ui;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

import org.agileware.natural.stepmatcher.AnnotationMacthEntry;
import org.agileware.natural.stepmatcher.IStepMatcher;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.jdt.core.IAnnotation;
import org.eclipse.jdt.core.ICompilationUnit;
import org.eclipse.jdt.core.IJavaElement;
import org.eclipse.jdt.core.IMethod;
import org.eclipse.jdt.core.JavaModelException;
import org.eclipse.jdt.core.search.IJavaSearchConstants;
import org.eclipse.jdt.core.search.IJavaSearchScope;
import org.eclipse.jdt.core.search.SearchEngine;
import org.eclipse.jdt.core.search.SearchMatch;
import org.eclipse.jdt.core.search.SearchParticipant;
import org.eclipse.jdt.core.search.SearchPattern;
import org.eclipse.jdt.core.search.SearchRequestor;

import com.google.inject.Inject;
import com.google.inject.Singleton;

@Singleton
public class JavaAnnotationMatcher implements IStepMatcher {

	private static boolean isMatchingAnnotationValue(final String annotationValue, final String description) {
		try {
			return description.matches(Pattern.quote(annotationValue));
		} catch (final PatternSyntaxException e) {
			e.printStackTrace();
		}

		return false;
	}

	@Inject
	private AbstractAnnotationDescriptor descriptor;

	private final Map<ICompilationUnit, List<Entry>> cache = new HashMap<ICompilationUnit, List<Entry>>();

	@Override
	public boolean isActivated() {
		return true;
	}

	@Override
	public Collection<AnnotationMacthEntry> findMatches(final String keyword, final String description) {
		final MatchCollector command = new MatchCollector(keyword, description);
		findMatches(description, command);

		return command.get();
	}

	protected IJavaSearchScope getScope(final String filter) {
		if (filter == null)
			return SearchEngine.createWorkspaceScope();

		final String[] names = filter.split(",");
		final List<IJavaElement> packages = new ArrayList<IJavaElement>();

		SearchPattern pattern = null;
		for (final String name : names) {
			final SearchPattern current = SearchPattern.createPattern(name.trim(), IJavaSearchConstants.PACKAGE,
					IJavaSearchConstants.ALL_OCCURRENCES, SearchPattern.R_EXACT_MATCH | SearchPattern.R_CASE_SENSITIVE);
			if (pattern == null) {
				pattern = current;
			} else {
				pattern = SearchPattern.createOrPattern(pattern, current);
			}
		}
		try {
			new SearchEngine().search(pattern, new SearchParticipant[] { SearchEngine.getDefaultSearchParticipant() },
					SearchEngine.createWorkspaceScope(), new SearchRequestor() {
						@Override
						public void acceptSearchMatch(final SearchMatch match) throws CoreException {
							packages.add((IJavaElement) match.getElement());
						}
					}, null);
		} catch (final CoreException e) {
			e.printStackTrace();
		}
		return SearchEngine.createJavaSearchScope(packages.toArray(new IJavaElement[0]));
	}

	public void findMatches(final String description, final Command command) {
		final long time = System.currentTimeMillis();
		if (!cache.isEmpty()) {
			for (final List<Entry> entries : cache.values()) {
				for (final Entry entry : entries) {
					if (isMatchingAnnotationValue(entry.annotationValue, description)) {
						command.match(entry.annotationValue, entry.method);
					}
				}
			}
			return;
		}

		// combine search patterns
		SearchPattern pattern = null;
		for (final String annotationName : descriptor.getNames()) {
			final SearchPattern current = SearchPattern.createPattern(annotationName,
					IJavaSearchConstants.ANNOTATION_TYPE, IJavaSearchConstants.ANNOTATION_TYPE_REFERENCE,
					SearchPattern.R_EXACT_MATCH | SearchPattern.R_CASE_SENSITIVE);
			if (pattern == null) {
				pattern = current;
			} else {
				pattern = SearchPattern.createOrPattern(pattern, current);
			}
		}
		// execute search
		try {
			new SearchEngine().search(pattern, new SearchParticipant[] { SearchEngine.getDefaultSearchParticipant() },
					this.getScope(null), new SearchRequestor() {
						@Override
						public void acceptSearchMatch(final SearchMatch match) throws CoreException {
							if (match.getElement() instanceof IMethod) {
								final IMethod method = (IMethod) match.getElement();
								final IAnnotation[] annotations = method.getAnnotations();
								for (final IAnnotation type : annotations) {
									// check annotation package
									if (AbstractAnnotationDescriptor.checkPackage(type, descriptor.getPackage())) {
										// verify pattern
										final String annotationValue = (String) type.getMemberValuePairs()[0]
												.getValue();
										List<Entry> entries = cache.get(method.getCompilationUnit());
										if (entries == null) {
											entries = new ArrayList<Entry>();
											cache.put(method.getCompilationUnit(), entries);
										}
										entries.add(new Entry(annotationValue, method));
										if (isMatchingAnnotationValue(annotationValue, description)) {
											command.match(annotationValue, method);
										}
									}
								}
							}
						}
					}, null);
		} catch (final CoreException e) {
			e.printStackTrace();
		}
		System.out.println("stepdef match lookup completed in " + (System.currentTimeMillis() - time) + "ms");
	}

	public Collection<String> findProposals() {
		if (cache.isEmpty()) {
			findMatches("", (annotationValue, method) -> {
			});
		}

		final Collection<String> proposals = new TreeSet<String>();
		for (final List<Entry> entries : cache.values()) {
			for (final Entry entry : entries) {
				proposals.add(entry.getAnnotationValue());
			}
		}
		return proposals;
	}

	public void evict(final ICompilationUnit element) {
		cache.clear();
		System.out.println(">>> cache cleared");
	}

	public static interface Command {
		void match(String annotationValue, IMethod method);
	}

	private final static class MatchCollector implements JavaAnnotationMatcher.Command {
		private final String keyword;
		private final String description;

		private final List<AnnotationMacthEntry> entries = new ArrayList<AnnotationMacthEntry>();

		public MatchCollector(final String keyword, final String description) {
			super();
			this.keyword = keyword;
			this.description = description;
		}

		public List<AnnotationMacthEntry> get() {
			return Collections.unmodifiableList(entries);
		}

		@Override
		public void match(final String annotationValue, final IMethod method) {
			try {
				entries.add(new AnnotationMacthEntry(keyword, description, method.getClass().getCanonicalName(),
						method.getSignature()));
			} catch (final JavaModelException e) {
				e.printStackTrace();
			}
		}
	}

	public static class Entry {
		private final String annotationValue;
		private final IMethod method;

		private Entry(final String annotationValue, final IMethod method) {
			this.annotationValue = annotationValue;
			this.method = method;
		}

		public String getAnnotationValue() {
			return annotationValue;
		}
	}
}
