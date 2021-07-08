package org.agileware.natural.cucumber.ui;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import org.agileware.natural.cucumber.cucumber.Step;
import org.agileware.natural.stepmatcher.ui.JavaAnnotationMatcher;
import org.agileware.natural.stepmatcher.ui.JavaHyperlink;
import org.eclipse.emf.ecore.EObject;
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
	public IHyperlink[] createHyperlinksByOffset(final XtextResource resource, final int offset,
			final boolean createMultipleHyperlinks) {
		final IHyperlink[] defaults = super.createHyperlinksByOffset(resource, offset, createMultipleHyperlinks);
		final List<IHyperlink> hyperlinks = (defaults == null ? new ArrayList<IHyperlink>() : Arrays.asList(defaults));

		final EObject eObject = helper.resolveElementAt(resource, offset);
		if (eObject instanceof Step) {
			final IParseResult parseResult = resource.getParseResult();
			INode node = NodeModelUtils.findLeafNodeAtOffset(parseResult.getRootNode(), offset);
			while (!(node instanceof CompositeNode && node.getSemanticElement() instanceof Step)) {
				node = node.getParent();
			}
			final String description = ((Step) eObject).getDescription();
			final Region region = new Region(node.getOffset(), node.getText().trim().length());
			hyperlinks.addAll(findLinkTargets(description, region));
		}
		return hyperlinks.isEmpty() ? null : Iterables.toArray(hyperlinks, IHyperlink.class);
	}

	private Collection<? extends IHyperlink> findLinkTargets(final String description, final Region region) {
		final List<IHyperlink> results = new ArrayList<IHyperlink>();
		matcher.findMatches(description.trim(), (annotationValue, method) -> results
				.add(new JavaHyperlink("Open definition " + annotationValue, method, region)));
		return results;
	}
}
