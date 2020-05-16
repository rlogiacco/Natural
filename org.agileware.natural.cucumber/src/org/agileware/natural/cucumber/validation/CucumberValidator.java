package org.agileware.natural.cucumber.validation;

import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.ABSTRACT_SCENARIO__STEPS;
import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.BACKGROUND__STEPS;
import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.FEATURE__SCENARIOS;
import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.STEP__DESCRIPTION;
import static org.agileware.natural.cucumber.validation.CucumberIssueCode.MissingScenarios;
import static org.agileware.natural.cucumber.validation.CucumberIssueCode.MissingStepDefinition;
import static org.agileware.natural.cucumber.validation.CucumberIssueCode.MissingSteps;
import static org.agileware.natural.cucumber.validation.CucumberIssueCode.MultipleStepDefinitions;

import org.agileware.natural.cucumber.cucumber.AbstractScenario;
import org.agileware.natural.cucumber.cucumber.Background;
import org.agileware.natural.cucumber.cucumber.Feature;
import org.agileware.natural.cucumber.cucumber.Step;
import org.agileware.natural.stepmatcher.JavaAnnotationMatcher;
import org.eclipse.jdt.core.IMethod;
import org.eclipse.xtext.validation.Check;
import org.eclipse.xtext.validation.CheckType;

import com.google.inject.Inject;

public class CucumberValidator extends AbstractCucumberValidator {

	@Inject
	private JavaAnnotationMatcher matcher;

	@Check
	public void featureHasScenarios(Feature model) {
		if (model.getScenarios().isEmpty()) {
			error(MissingScenarios.message(), model, FEATURE__SCENARIOS, MissingScenarios.code());
		}
	}
	
	@Check
	public void backgrounHasSteps(Background model) {
		if (model.getSteps().isEmpty()) {
			String title = model.getTitle();
			error(MissingSteps.message(title), model, BACKGROUND__STEPS, MissingSteps.code());
		}
	}
	
	@Check
	public void scenariosHasSteps(AbstractScenario model) {
		if (model.getSteps().isEmpty()) {
			String title = model.getTitle();
			error(MissingSteps.message(title), model, ABSTRACT_SCENARIO__STEPS, MissingSteps.code());
		}
	}

	@Check(CheckType.EXPENSIVE)
	public void stepsHaveMatchingDefinition(Step model) {
		final Counter counter = new Counter();
		String description = model.getDescription().trim();
		matcher.findMatches(description, counter);
		if (counter.get() == 0) {
			warning(MissingStepDefinition.message(description), STEP__DESCRIPTION, MissingStepDefinition.code());
		} else if (counter.get() > 1) {
			warning(MultipleStepDefinitions.message(description), STEP__DESCRIPTION, MultipleStepDefinitions.code());
		}
	}

	private final static class Counter implements JavaAnnotationMatcher.Command {
		private int count = 0;

		public int get() {
			return count;
		}

		public void match(String annotationValue, IMethod method) {
			count++;
		}
	}
}
