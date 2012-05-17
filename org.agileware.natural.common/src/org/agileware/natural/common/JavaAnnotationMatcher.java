package org.agileware.natural.common;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.jdt.core.IAnnotation;
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
	
	private List<Entry> cache = new ArrayList<Entry>();
	
	public void findMatches(final String description, final Command command) {
		long time = System.currentTimeMillis();
		if (!cache.isEmpty()) {
			for (Entry entry : cache) {
				if (description.matches(entry.annotationValue)) {
					command.match(entry.annotationValue, entry.method);
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
							cache.add(new Entry(annotationValue, method));
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
	
	public void invalidateCache() {
		System.out.println("invalidated");
		cache.clear();
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
	}
}
