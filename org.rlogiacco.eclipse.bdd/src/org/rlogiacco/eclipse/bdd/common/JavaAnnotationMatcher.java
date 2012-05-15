package org.rlogiacco.eclipse.bdd.common;

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

public class JavaAnnotationMatcher {

	@Inject
	private AbstractAnnotationDescriptor descriptor;
	
	public void findMatches(final String description, final Command command) {
		long time = System.currentTimeMillis();
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
		System.out.println("Search took" + (System.currentTimeMillis() - time) + "ms");
	}
	
	public static interface Command {
		void match(String annotationValue, IMethod method);
	}
}
