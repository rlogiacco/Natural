package org.agileware.natural.cucumber.ui.syntaxcoloring;

import org.agileware.natural.cucumber.cucumber.AbstractScenario;
import org.agileware.natural.cucumber.cucumber.CucumberModel;
import org.agileware.natural.cucumber.cucumber.Step;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtext.ide.editor.syntaxcoloring.IHighlightedPositionAcceptor;
import org.eclipse.xtext.ide.editor.syntaxcoloring.ISemanticHighlightingCalculator;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.util.CancelIndicator;

public class SemanticHighlightingCalculator implements ISemanticHighlightingCalculator {


	@Override
	public void provideHighlightingFor(XtextResource resource, IHighlightedPositionAcceptor acceptor,
			CancelIndicator cancelIndicator) {
		if (resource == null || resource.getParseResult() == null || resource.getContents().size() <= 0) {
			return;
		}
		CucumberModel model = (CucumberModel) resource.getContents().get(0);
		if (model.getDocument() != null) {
			for (AbstractScenario scenario : model.getDocument().getScenarios()) {
				provideHighlightingForSteps(scenario.getSteps(), acceptor);
			}
		}
	}

	private void provideHighlightingForSteps(EList<Step> steps, IHighlightedPositionAcceptor acceptor) {
//		for (Step step : steps) {
//			INode node = NodeModelUtils.getNode(step);
//			acceptor.addPosition(node.getOffset(), node.getText().trim().indexOf(" "),
//					HighlightingConfiguration.STEP_KEYWORD);
//			if (step.eContainer() instanceof ScenarioOutline && step.getDescription() != null) {
//				this.provideHighlightingForPlaceholders(node.getText(), node, 0, acceptor);
//			}
//		}
	}
}
