package org.agileware.natural.cucumber.ui;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import org.agileware.natural.common.JavaAnnotationMatcher;
import org.agileware.natural.common.JavaHyperlink;
import org.agileware.natural.cucumber.cucumber.Step;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.jdt.core.IMethod;
import org.eclipse.jface.text.Region;
import org.eclipse.jface.text.hyperlink.IHyperlink;
import org.eclipse.xtext.nodemodel.INode;
import org.eclipse.xtext.nodemodel.impl.CompositeNode;
import org.eclipse.xtext.nodemodel.util.NodeModelUtils;
import org.eclipse.xtext.parser.IParseResult;
import org.eclipse.xtext.resource.EObjectAtOffsetHelper;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.ui.editor.hyperlinking.HyperlinkHelper;

import com.google.common.collect.Iterables;
import com.google.inject.Inject;

public class CucumberHyperlinkHelper extends HyperlinkHelper {

	@Inject
	private EObjectAtOffsetHelper helper;
	
	@Inject
	private JavaAnnotationMatcher matcher;

	@Override
	public IHyperlink[] createHyperlinksByOffset(XtextResource resource, int offset, boolean createMultipleHyperlinks) {
		IHyperlink[] defaults = super.createHyperlinksByOffset(resource, offset, createMultipleHyperlinks);
		List<IHyperlink> hyperlinks = (defaults == null ? new ArrayList<IHyperlink>() : Arrays.asList(defaults));

		EObject eObject = helper.resolveElementAt(resource, offset);
		if (eObject instanceof Step) {
			IParseResult parseResult = resource.getParseResult();
			INode node = NodeModelUtils.findLeafNodeAtOffset(parseResult.getRootNode(), offset);
			while (!(node instanceof CompositeNode && node.getSemanticElement() instanceof Step)) {
				node = node.getParent();
			}
			String description = ((Step) eObject).getDescription();
			hyperlinks.addAll(findLinkTargets(description, new Region(node.getOffset(), node.getText().trim().length())));
		}
		return hyperlinks.isEmpty() ? null : Iterables.toArray(hyperlinks, IHyperlink.class);
	}

	private Collection<? extends IHyperlink> findLinkTargets(String description, final Region region) {
		final List<IHyperlink> results = new ArrayList<IHyperlink>();
		matcher.findMatches(description.trim(), new JavaAnnotationMatcher.Command() {
			
			public void match(String annotationValue, IMethod method) {
				results.add(new JavaHyperlink("Open definition " + annotationValue, method, region));
				
			}
		});
		return results;
	}
}
