package org.agileware.natural.cucumber.validation;

import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.ABSTRACT_SCENARIO__STEPS;
import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.FEATURE__BACKGROUND;
import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.FEATURE__SCENARIOS;
import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.SECTION__TITLE;
import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.STEP__DESCRIPTION;
import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.INVALID_BACKGROUND;
import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MISSING_FEATURE_TITLE;
import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MISSING_SCENARIOS;
import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MISSING_SCENARIO_STEPS;
import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MISSING_STEPDEFS;
import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MULTIPLE_STEPDEFS;

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

	private final static class Counter implements JavaAnnotationMatcher.Command {
		private int count = 0;

		public int get() {
			return count;
		}

		public void match(String annotationValue, IMethod method) {
			count++;
		}
	}

	@Inject
	private JavaAnnotationMatcher matcher;

	/**
	 * Issue a warning if the Feature has no title
	 * 
	 * @param model
	 */
	@Check(CheckType.FAST)
	public void featureTitle(Feature model) {
		if (model.getTitle() == null || model.getTitle().isBlank()) {
			warning(MISSING_FEATURE_TITLE.message(), model, SECTION__TITLE, MISSING_FEATURE_TITLE.id());
		}
	}

	/**
	 * Due to Background being a valid AbstractScenario, we must explicitly test for
	 * the existence of this element in the feature scenarios and manually generate
	 * an error code.
	 * 
	 * @param model
	 */
	@Check(CheckType.NORMAL)
	public void invalidBackground(Feature model) {
		for (AbstractScenario s : model.getScenarios()) {
			if (s instanceof Background) {
				error(INVALID_BACKGROUND.message(), s, FEATURE__BACKGROUND, INVALID_BACKGROUND.id());
			}
		}
	}

	/**
	 * Issue a warning if Feature has no scenarios defined. **note:** Do not depend
	 * on grammar rule validation
	 * 
	 * @param model
	 */
	@Check(CheckType.FAST)
	public void missingScenarios(Feature model) {
		if (model.getScenarios().isEmpty()) {
			warning(MISSING_SCENARIOS.message(), model, FEATURE__SCENARIOS, MISSING_SCENARIOS.id());
		}
	}

	/**
	 * Issue a warning if AbstractScenario has no defined steps. **note:** Do not
	 * depend on grammar rule validation
	 * 
	 * @param model
	 */
	@Check(CheckType.FAST)
	public void missingScenarioSteps(AbstractScenario model) {
		if (model.getSteps().isEmpty()) {
			warning(MISSING_SCENARIO_STEPS.message(), model, ABSTRACT_SCENARIO__STEPS, MISSING_SCENARIO_STEPS.id());
		}
	}

	@Check(CheckType.EXPENSIVE)
	public void invalidStepDefs(Step model) {
		System.out.println("Validating: " + model);
		final Counter counter = new Counter();
		String description = model.getDescription().trim();
		matcher.findMatches(description, counter);
		if (counter.get() == 0) {
			warning(MISSING_STEPDEFS.message(description), model, STEP__DESCRIPTION, MISSING_STEPDEFS.id());
		} else if (counter.get() > 1) {
			warning(MULTIPLE_STEPDEFS.message(description), model, STEP__DESCRIPTION, MULTIPLE_STEPDEFS.id());
		}
	}
}
