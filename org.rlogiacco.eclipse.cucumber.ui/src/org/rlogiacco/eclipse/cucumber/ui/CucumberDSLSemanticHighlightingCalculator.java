package org.rlogiacco.eclipse.cucumber.ui;

import org.eclipse.emf.common.util.EList;
import org.eclipse.xtext.nodemodel.INode;
import org.eclipse.xtext.nodemodel.util.NodeModelUtils;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.ui.editor.syntaxcoloring.IHighlightedPositionAcceptor;
import org.eclipse.xtext.ui.editor.syntaxcoloring.ISemanticHighlightingCalculator;
import org.rlogiacco.eclipse.cucumber.cucumberDSL.Feature;
import org.rlogiacco.eclipse.cucumber.cucumberDSL.Scenario;
import org.rlogiacco.eclipse.cucumber.cucumberDSL.ScenarioOutline;
import org.rlogiacco.eclipse.cucumber.cucumberDSL.Step;
import org.rlogiacco.eclipse.cucumber.cucumberDSL.Table;
import org.rlogiacco.eclipse.cucumber.cucumberDSL.Tag;

public class CucumberDSLSemanticHighlightingCalculator implements ISemanticHighlightingCalculator {
	
	@Override
	public void provideHighlightingFor(XtextResource resource, IHighlightedPositionAcceptor acceptor) {
		if (resource == null || resource.getParseResult() == null || resource.getContents().size() <= 0) {
			return;
		}
		Feature feature = (Feature) resource.getContents().get(0);
		provideHighlightingForTags(feature.getTags(), acceptor);
		for (Object child : feature.getScenarios()) {
			if (child instanceof Scenario) {
				Scenario scenario = (Scenario) child;
				provideHighlightingForSteps(scenario.getConditions(), acceptor);
				provideHighlightingForTags(scenario.getTags(), acceptor);
			}
			if (child instanceof ScenarioOutline) {
				ScenarioOutline outline = (ScenarioOutline) child;
				provideHighlightingForSteps(outline.getConditions(), acceptor);
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
					CucumberDSLHighlightingConfiguration.STEP_KEYWORD);
			if (step.getTable() != null) {
				provideHighlightingForTable(step.getTable(), acceptor);
			}
		}
	}

	private void provideHighlightingForTable(Table table, IHighlightedPositionAcceptor acceptor) {
		INode node = NodeModelUtils.getNode(table);
		acceptor.addPosition(
				node.getOffset(),
				node.getText().trim().length(),
				CucumberDSLHighlightingConfiguration.TABLE);
	}

	private void provideHighlightingForTags(EList<Tag> tags, IHighlightedPositionAcceptor acceptor) {
		for (Tag tag : tags) {
			INode node = NodeModelUtils.getNode(tag);
			acceptor.addPosition(
					node.getOffset(),
					node.getText().trim().length(),
					CucumberDSLHighlightingConfiguration.TAG);
		}
	}
}
