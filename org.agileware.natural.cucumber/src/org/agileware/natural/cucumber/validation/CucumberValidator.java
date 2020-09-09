package org.agileware.natural.cucumber.validation;

import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.ABSTRACT_SCENARIO__STEPS;
import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.FEATURE__SCENARIOS;
import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.FEATURE__TITLE;
import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MISSING_FEATURE_TITLE;
import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MISSING_SCENARIOS;
import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MISSING_SCENARIO_STEPS;

import java.util.Collection;

import org.agileware.natural.cucumber.cucumber.AbstractScenario;
import org.agileware.natural.cucumber.cucumber.CucumberPackage;
import org.agileware.natural.cucumber.cucumber.Feature;
import org.agileware.natural.cucumber.cucumber.Step;
import org.agileware.natural.stepmatcher.IStepMatcher;
import org.eclipse.xtext.validation.Check;
import org.eclipse.xtext.validation.CheckType;
import org.eclipse.xtext.validation.ValidationMessageAcceptor;

import com.google.inject.Inject;

public class CucumberValidator extends AbstractCucumberValidator {

	@Inject
	private IStepMatcher matcher;

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

	/**
	 * Issue a warning if Feature has no scenarios defined. **note:** Do not depend
	 * on grammar rule validation
	 *
	 * @param model
	 */
	@Check(CheckType.FAST)
	public void missingScenarios(final Feature model) {
		if (model.getScenarios().isEmpty()) {
			warning("Feature has no scenarios", model, FEATURE__SCENARIOS, MISSING_SCENARIOS);
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
	@Check(CheckType.NORMAL)
	public void checkStepMatching(final Step step) {
		if (!matcher.isActivated())
			return;

		final String keyword = step.getKeyword();
		final String description = step.getDescription();
		if (keyword != null && description != null) {
			final Collection<?> matches = matcher.findMatches(keyword, description);
			if (matches.size() == 0) {
				warning("No definition found for `" + description + "`", CucumberPackage.Literals.STEP__DESCRIPTION);
			} else if (matches.size() > 1) {
				warning("Multiple definitions found for `" + description + "`",
						CucumberPackage.Literals.STEP__DESCRIPTION);
			}
		}
	}
}
