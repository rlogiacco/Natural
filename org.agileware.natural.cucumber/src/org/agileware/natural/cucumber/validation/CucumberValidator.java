package org.agileware.natural.cucumber.validation;

import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.ABSTRACT_SCENARIO__STEPS;
import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.FEATURE__TITLE;
import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MISSING_FEATURE_TITLE;
import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MISSING_SCENARIO_STEPS;

import org.agileware.natural.common.JavaAnnotationMatcher;
import org.agileware.natural.cucumber.cucumber.AbstractScenario;
import org.agileware.natural.cucumber.cucumber.CucumberPackage;
import org.agileware.natural.cucumber.cucumber.Feature;
import org.agileware.natural.cucumber.cucumber.Step;
import org.eclipse.jdt.core.IMethod;
import org.eclipse.xtext.validation.Check;
import org.eclipse.xtext.validation.CheckType;
import org.eclipse.xtext.validation.ValidationMessageAcceptor;

import com.google.inject.Inject;

public class CucumberValidator extends AbstractCucumberValidator {

	@Inject
	private JavaAnnotationMatcher matcher;

	/**
	 * Issue a warning if the Feature has no title
	 *
	 * @param model
	 */
	@Check(CheckType.FAST)
	public void featureTitle(final Feature model) {
		if (model.getTitle() == null) {
			warning("Feature title is missing", FEATURE__TITLE, ValidationMessageAcceptor.INSIGNIFICANT_INDEX,
					MISSING_FEATURE_TITLE);
		}
	}

	private final static class Counter implements JavaAnnotationMatcher.Command {
		private int count = 0;

		public int get() {
			return count;
		}

		@Override
		public void match(final String annotationValue, final IMethod method) {
			count += 1;
		}
	}

	/**
	 * Issue a warning if AbstractScenario has no defined steps. **note:** Do not
	 * depend on grammar rule validation
	 *
	 * @param model
	 */
	@Check(CheckType.FAST)
	public void missingScenarioSteps(final AbstractScenario model) {
		if (model.getSteps().isEmpty()) {
			warning("Scenario has no steps", model, ABSTRACT_SCENARIO__STEPS, MISSING_SCENARIO_STEPS);
		}
	}

	/**
	 * Scan for matching java annotation if activated
	 *
	 * @param model
	 */
	@Check(CheckType.EXPENSIVE)
	public void checkStepMatching(final Step step) {
		final Counter counter = new Counter();
		final String description = step.getDescription().trim();
		matcher.findMatches(description, counter);
		if (counter.get() == 0) {
			warning("No definition found for `" + description + "`", CucumberPackage.Literals.STEP__DESCRIPTION);
		} else if (counter.get() > 1) {
			warning("Multiple definitions found for `" + description + "`", CucumberPackage.Literals.STEP__DESCRIPTION);
		}
	}
}
