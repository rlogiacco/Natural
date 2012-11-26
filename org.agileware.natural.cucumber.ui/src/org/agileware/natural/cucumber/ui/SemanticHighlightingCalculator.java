package org.agileware.natural.cucumber.ui;

import org.agileware.natural.cucumber.cucumber.DocString;
import org.agileware.natural.cucumber.cucumber.Feature;
import org.agileware.natural.cucumber.cucumber.Scenario;
import org.agileware.natural.cucumber.cucumber.ScenarioOutline;
import org.agileware.natural.cucumber.cucumber.Step;
import org.agileware.natural.cucumber.cucumber.Table;
import org.agileware.natural.cucumber.cucumber.Tag;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.nodemodel.INode;
import org.eclipse.xtext.nodemodel.util.NodeModelUtils;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.ui.editor.syntaxcoloring.IHighlightedPositionAcceptor;
import org.eclipse.xtext.ui.editor.syntaxcoloring.ISemanticHighlightingCalculator;

public class SemanticHighlightingCalculator implements ISemanticHighlightingCalculator {
	
	public void provideHighlightingFor(XtextResource resource, IHighlightedPositionAcceptor acceptor) {
		if (resource == null || resource.getParseResult() == null || resource.getContents().size() <= 0) {
			return;
		}
		Feature feature = (Feature) resource.getContents().get(0);
		provideHighlightingForTags(feature.getTags(), acceptor);
		if (feature.getBackground() != null) {
			provideHighlightingForSteps(feature.getBackground().getSteps(), acceptor);
		}
		for (Object child : feature.getScenarios()) {
			if (child instanceof Scenario) {
				Scenario scenario = (Scenario) child;
				provideHighlightingForSteps(scenario.getSteps(), acceptor);
				provideHighlightingForTags(scenario.getTags(), acceptor);
			}
			if (child instanceof ScenarioOutline) {
				ScenarioOutline outline = (ScenarioOutline) child;
				provideHighlightingForSteps(outline.getSteps(), acceptor);
				provideHighlightingForTags(outline.getTags(), acceptor);
				if (outline.getExamples() != null && outline.getExamples().getTable() != null) {
					provideHighlightingForTable(outline.getExamples().getTable(), acceptor);
				}
			}
		}
	}

	private void provideHighlightingForSteps(EList<Step> steps, IHighlightedPositionAcceptor acceptor) {
		for (Step step : steps) {
			INode node = NodeModelUtils.getNode(step);
			acceptor.addPosition(
					node.getOffset(),
					node.getText().trim().indexOf(" "),
					HighlightingConfiguration.STEP_KEYWORD);
			if (step.eContainer() instanceof ScenarioOutline) {
				this.provideHighlightingForPlaceholders(step.getDescription(), node, 0, acceptor);
			}
			for (EObject attach : step.getAttach()) {
				if (attach instanceof Table) {
					provideHighlightingForTable((Table)attach, acceptor);
				} else if (attach instanceof DocString) {
					provideHighlightingForDocString((DocString)attach, acceptor);
				}
			}
		}
	}

	private void provideHighlightingForPlaceholders(String description, INode node, int offset, IHighlightedPositionAcceptor acceptor) {
		int start = description.indexOf('<', offset);
		int stop = description.indexOf('>', start);
		if (start > 0 && stop > 0 && description.charAt(start + 1) != ' ') {
			acceptor.addPosition(node.getOffset() + start, stop - start + 1, HighlightingConfiguration.PLACEHOLDER);
			this.provideHighlightingForPlaceholders(description, node, stop + 1, acceptor);
		}
	}

	private void provideHighlightingForTable(Table table, IHighlightedPositionAcceptor acceptor) {
		INode node = NodeModelUtils.getNode(table);
		acceptor.addPosition(
				node.getOffset(),
				node.getText().trim().length(),
				HighlightingConfiguration.TABLE);
	}

	private void provideHighlightingForTags(EList<Tag> tags, IHighlightedPositionAcceptor acceptor) {
		for (Tag tag : tags) {
			INode node = NodeModelUtils.getNode(tag);
			acceptor.addPosition(
					node.getOffset(),
					node.getText().trim().length(),
					HighlightingConfiguration.TAG);
		}
	}
	
	private void provideHighlightingForDocString(DocString code, IHighlightedPositionAcceptor acceptor) {
		INode node = NodeModelUtils.getNode(code);
		acceptor.addPosition(
				node.getOffset(),
				node.getText().trim().length(),
				HighlightingConfiguration.DOC_STRING);
	}
}
