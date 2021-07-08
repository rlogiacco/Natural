package org.agileware.natural.cucumber.ui.syntaxcoloring;

import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.ABSTRACT_SCENARIO__TITLE;
import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.EXAMPLE__TITLE;
import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.FEATURE__TITLE;
import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.STEP__DESCRIPTION;
import static org.eclipse.xtext.nodemodel.util.NodeModelUtils.findNodesForFeature;

import java.util.regex.Pattern;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

import org.agileware.natural.cucumber.cucumber.AbstractScenario;
import org.agileware.natural.cucumber.cucumber.CucumberModel;
import org.agileware.natural.cucumber.cucumber.Example;
import org.agileware.natural.cucumber.cucumber.Feature;
import org.agileware.natural.cucumber.cucumber.ScenarioOutline;
import org.agileware.natural.cucumber.cucumber.Step;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EStructuralFeature;
import org.eclipse.xtext.ide.editor.syntaxcoloring.IHighlightedPositionAcceptor;
import org.eclipse.xtext.ide.editor.syntaxcoloring.ISemanticHighlightingCalculator;
import org.eclipse.xtext.nodemodel.ILeafNode;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.util.CancelIndicator;

public class SemanticHighlightingCalculator implements ISemanticHighlightingCalculator {

	private static final Pattern NUMBER_PATTERN = Pattern.compile("(0)|([1-9][0-9]*)|(0x[0-9a-fA-F]+)");

	private static Stream<ILeafNode> allLeafNodesFor(final EObject semanticObject,
			final EStructuralFeature structuralFeature) {
		return findNodesForFeature(semanticObject, structuralFeature)
				.stream()
				.flatMap(n -> StreamSupport.stream(n.getLeafNodes().spliterator(), false))
				.filter(n -> !n.isHidden());
	}

	@Override
	public void provideHighlightingFor(final XtextResource resource, final IHighlightedPositionAcceptor acceptor,
			CancelIndicator cancelIndicator) {
		if (resource == null || resource.getParseResult() == null || resource.getContents().size() <= 0
				|| cancelIndicator.isCanceled()) {
			return;
		}

		final CucumberModel model = (CucumberModel) resource.getContents().get(0);
		if (model.getDocument() != null) {
			provideHighlightingFor(model.getDocument(), acceptor);
		}
	}

	private void provideHighlightingFor(final Feature feature, final IHighlightedPositionAcceptor acceptor) {
		provideHighlightingForTextLiterals(allLeafNodesFor(feature, FEATURE__TITLE), acceptor);
		for (final AbstractScenario scenario : feature.getScenarios()) {
			provideHighlightingFor(scenario, acceptor);
		}
	}

	private void provideHighlightingFor(final AbstractScenario scenario, final IHighlightedPositionAcceptor acceptor) {
		provideHighlightingForTextLiterals(allLeafNodesFor(scenario, ABSTRACT_SCENARIO__TITLE), acceptor);
		for (final Step step : scenario.getSteps()) {
			provideHighlightingFor(step, acceptor);
			if (scenario instanceof ScenarioOutline) {
				for (final Example example : ((ScenarioOutline) scenario).getExamples()) {
					provideHighlightingFor(example, acceptor);
				}
			}
		}
	}

	private void provideHighlightingFor(final Example example, final IHighlightedPositionAcceptor acceptor) {
		provideHighlightingForTextLiterals(allLeafNodesFor(example, EXAMPLE__TITLE), acceptor);
	}

	private void provideHighlightingFor(final Step step, final IHighlightedPositionAcceptor acceptor) {
		provideHighlightingForTextLiterals(allLeafNodesFor(step, STEP__DESCRIPTION), acceptor);
	}

	private void provideHighlightingForTextLiterals(final Stream<ILeafNode> leafNodes,
			final IHighlightedPositionAcceptor acceptor) {
		leafNodes.forEach(node -> {
			// Temporary work around for LexicalHighlighter failing to flag certain numbers
			// forms
			if (NUMBER_PATTERN.matcher(node.getText()).matches()) {
				acceptor.addPosition(node.getOffset(), node.getLength(),
						HighlightingConfiguration.NUMBER_ID);
			}
		});
	}
}
