package org.agileware.natural.common;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.jdt.core.IAnnotation;
import org.eclipse.jdt.core.ICompilationUnit;
import org.eclipse.jdt.core.IMethod;
import org.eclipse.jdt.core.search.IJavaSearchConstants;
import org.eclipse.jdt.core.search.SearchEngine;
import org.eclipse.jdt.core.search.SearchMatch;
import org.eclipse.jdt.core.search.SearchParticipant;
import org.eclipse.jdt.core.search.SearchPattern;
import org.eclipse.jdt.core.search.SearchRequestor;

import com.google.inject.Inject;
import com.google.inject.Singleton;

@Singleton
public class JavaAnnotationMatcher {

	@Inject
	private AbstractAnnotationDescriptor descriptor;
	
	private Map<ICompilationUnit, List<Entry>> cache = new HashMap<ICompilationUnit, List<Entry>>();
	
	public void findMatches(final String description, final Command command) {
		long time = System.currentTimeMillis();
		if (!cache.isEmpty()) {
			for (List<Entry> entries : cache.values()) {
				for (Entry entry : entries) {
					if (description.matches(entry.annotationValue)) {
						command.match(entry.annotationValue, entry.method);
					}
				}
			}
			return;
		}
		for (final String annotationName : descriptor.getNames()) {
			SearchPattern pattern = SearchPattern.createPattern(annotationName, IJavaSearchConstants.ANNOTATION_TYPE,
					IJavaSearchConstants.ANNOTATION_TYPE_REFERENCE, SearchPattern.R_EXACT_MATCH | SearchPattern.R_CASE_SENSITIVE);
			SearchRequestor requestor = new SearchRequestor() {
				public void acceptSearchMatch(SearchMatch match) throws CoreException {
					if (match.getElement() instanceof IMethod) {
						String des = description;
						IMethod method = (IMethod) match.getElement();
						IAnnotation type = method.getAnnotation(annotationName);
						// Check annotation package
						if (AbstractAnnotationDescriptor.checkPackage(type, descriptor.getPackage())) {
							// verify pattern
							String annotationValue = (String) type.getMemberValuePairs()[0].getValue();
							List<Entry> entries = cache.get(method.getCompilationUnit());
							if (entries == null) {
								entries = new ArrayList<Entry>();
								cache.put(method.getCompilationUnit(), entries);
							}
							entries.add(new Entry(annotationValue, method));
							if (des.matches(annotationValue)) {
								command.match(annotationValue, method);
							}
						}		
					}
				}
			};
			try {
				new SearchEngine().search(pattern, new SearchParticipant[] { SearchEngine.getDefaultSearchParticipant() }, SearchEngine.createWorkspaceScope(),
						requestor, null);
			} catch (CoreException e) {
				e.printStackTrace();
			}
		}
		System.out.println("Search took: " + (System.currentTimeMillis() - time) + "ms");
	}
	
	public Collection<String> findProposals() {
		if (cache.isEmpty()) {
			findMatches("", new Command() {
				@Override
				public void match(String annotationValue, IMethod method) {}});
		}
		
		Collection<String> proposals = new TreeSet<String>();
		for (List<Entry> entries : cache.values()) {
			for (Entry entry : entries) {
				proposals.add(entry.getAnnotationValue());
			}
		}
		return proposals;
	}	
	
	public void evict(ICompilationUnit element) {
		//TODO evict only those that match
//		if (element != null) {
//			cache.remove(element);
//			System.out.println(">>> Removed " + element.toString());
//		} else {
			cache.clear();
			System.out.println(">>> Invalidated");
//		}
	}
	
	public static interface Command {
		void match(String annotationValue, IMethod method);
	}
	
	public static class Entry {
		private String annotationValue;
		private IMethod method;

		private Entry(String annotationValue, IMethod method) {
			this.annotationValue = annotationValue;
			this.method = method;
		}
		
		public String getAnnotationValue() {
			return annotationValue;
		}
	}
}
