package org.agileware.natural.cucumber.validation;

import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.*;
import static org.agileware.natural.cucumber.validation.IssueCodes.*;

import org.agileware.natural.common.JavaAnnotationMatcher;
import org.agileware.natural.cucumber.cucumber.Feature;
import org.agileware.natural.cucumber.cucumber.Step;
import org.eclipse.jdt.core.IMethod;
import org.eclipse.xtext.validation.Check;
import org.eclipse.xtext.validation.CheckType;

import com.google.inject.Inject;

public class CucumberValidator extends AbstractCucumberValidator {

	@Inject
	private JavaAnnotationMatcher matcher;

	@Check(CheckType.FAST)
	public void featureHasScenarios(Feature model) {
		if (model.getScenarios().isEmpty()) {
			error(MissingScenarios.value(), model, FEATURE__SCENARIOS, MissingScenarios.code());
		}
	}

	@Check(CheckType.EXPENSIVE)
	public void stepsHaveMatchingDefinition(Step model) {
		final Counter counter = new Counter();
		String description = model.getDescription().trim();
		matcher.findMatches(description, counter);
		if (counter.get() == 0) {
			warning(MissingStepDefinition.value(description), STEP__DESCRIPTION, MissingStepDefinition.code());
		} else if (counter.get() > 1) {
			warning(MultipleStepDefinitions.value(description), STEP__DESCRIPTION, MultipleStepDefinitions.code());
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
