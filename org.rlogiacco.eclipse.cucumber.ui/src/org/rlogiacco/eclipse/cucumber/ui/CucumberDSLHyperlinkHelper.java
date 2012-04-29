package org.rlogiacco.eclipse.cucumber.ui;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.jdt.core.IAnnotation;
import org.eclipse.jdt.core.IMethod;
import org.eclipse.jdt.core.search.IJavaSearchConstants;
import org.eclipse.jdt.core.search.SearchEngine;
import org.eclipse.jdt.core.search.SearchMatch;
import org.eclipse.jdt.core.search.SearchParticipant;
import org.eclipse.jdt.core.search.SearchPattern;
import org.eclipse.jdt.core.search.SearchRequestor;
import org.eclipse.jface.text.Region;
import org.eclipse.jface.text.hyperlink.IHyperlink;
import org.eclipse.xtext.nodemodel.INode;
import org.eclipse.xtext.nodemodel.impl.CompositeNode;
import org.eclipse.xtext.nodemodel.util.NodeModelUtils;
import org.eclipse.xtext.parser.IParseResult;
import org.eclipse.xtext.resource.EObjectAtOffsetHelper;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.ui.editor.hyperlinking.HyperlinkHelper;
import org.rlogiacco.eclipse.cucumber.cucumberDSL.Line;
import org.rlogiacco.eclipse.cucumber.cucumberDSL.Step;

import com.google.common.collect.Iterables;
import com.google.inject.Inject;

public class CucumberDSLHyperlinkHelper extends HyperlinkHelper {

	private static final String[] STEPS = { "Given", "When", "Then", "And", "But" };

	@Inject
	private EObjectAtOffsetHelper helper;

	@Override
	public IHyperlink[] createHyperlinksByOffset(XtextResource resource, int offset, boolean createMultipleHyperlinks) {

		IHyperlink[] defaults = super.createHyperlinksByOffset(resource, offset, createMultipleHyperlinks);
		List<IHyperlink> hyperlinks = (defaults == null ? new ArrayList<IHyperlink>() : Arrays.asList(defaults));

		EObject eObject = helper.resolveElementAt(resource, offset);
		if (eObject instanceof Line && eObject.eContainer() instanceof Step) {
			eObject = eObject.eContainer();
		}
		if (eObject instanceof Step) {
			IParseResult parseResult = resource.getParseResult();
			INode node = NodeModelUtils.findLeafNodeAtOffset(parseResult.getRootNode(), offset);
			while (!(node instanceof CompositeNode && node.getSemanticElement() instanceof Step)) {
				node = node.getParent();
			}
			hyperlinks.addAll(findLinkTargets(((Step) eObject).getDescription().getContent(), new Region(node.getOffset(), node.getLength()), STEPS));
		}
		return hyperlinks.isEmpty() ? null : Iterables.toArray(hyperlinks, IHyperlink.class);
	}

	public static Collection<IHyperlink> findLinkTargets(final String step, final Region region, String[] annotationNames) {
		final List<IHyperlink> results = new ArrayList<IHyperlink>();
		for (final String annotationName : annotationNames) {
			SearchPattern pattern = SearchPattern.createPattern(annotationName, IJavaSearchConstants.ANNOTATION_TYPE,
					IJavaSearchConstants.ANNOTATION_TYPE_REFERENCE, SearchPattern.R_EXACT_MATCH | SearchPattern.R_CASE_SENSITIVE);
			SearchRequestor requestor = new SearchRequestor() {
				public void acceptSearchMatch(SearchMatch match) throws CoreException {
					if (match.getElement() instanceof IMethod) {
						IMethod method = (IMethod) match.getElement();
						// verify pattern
						IAnnotation type = method.getAnnotation(annotationName);
						String annotationValue = (String) type.getMemberValuePairs()[0].getValue();
						if (step.matches(annotationValue)) {
							results.add(new JavaHyperlink("Open mapping " + annotationValue, method, region));
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
		return results;
	}
}
