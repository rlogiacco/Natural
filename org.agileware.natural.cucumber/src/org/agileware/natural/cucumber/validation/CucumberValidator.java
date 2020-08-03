package org.agileware.natural.cucumber.validation;

//import static org.agileware.natural.cucumber.model.ModelPackage.Literals.ABSTRACT_SCENARIO__STEPS;
//import static org.agileware.natural.cucumber.model.ModelPackage.Literals.FEATURE__BACKGROUND;
//import static org.agileware.natural.cucumber.model.ModelPackage.Literals.FEATURE__SCENARIOS;
//import static org.agileware.natural.cucumber.model.ModelPackage.Literals.SECTION__TITLE;
//import static org.agileware.natural.cucumber.model.ModelPackage.Literals.STEP__DESCRIPTION;
//import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.INVALID_BACKGROUND;
//import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MISSING_FEATURE_TITLE;
//import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MISSING_SCENARIOS;
//import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MISSING_SCENARIO_STEPS;
//import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MISSING_STEPDEFS;
//import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.MULTIPLE_STEPDEFS;

//import org.agileware.natural.cucumber.model.AbstractScenario;
//import org.agileware.natural.cucumber.model.Background;
//import org.agileware.natural.cucumber.model.Feature;
//import org.agileware.natural.cucumber.model.Step;
import org.agileware.natural.stepmatcher.JavaAnnotationMatcher;
import org.eclipse.jdt.core.IMethod;
import org.eclipse.xtext.util.Strings;
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

//	/**
//	 * Issue a warning if the Feature has no title
//	 * 
//	 * @param model
//	 */
//	@Check(CheckType.FAST)
//	public void featureTitle(Feature model) {
//		if (Strings.isEmpty(model.getTitle())) {
//			warning("Feature title is missing", model, SECTION__TITLE, MISSING_FEATURE_TITLE);
//		}
//	}
//
//	/**
//	 * Due to Background being a valid AbstractScenario, we must explicitly test for
//	 * the existence of this element in the feature scenarios and manually generate
//	 * an error code.
//	 * 
//	 * @param model
//	 */
//	@Check(CheckType.FAST)
//	public void invalidBackground(Feature model) {
//		for (AbstractScenario s : model.getScenarios()) {
//			if (s instanceof Background) {
//				error("Invalid background definition", s, FEATURE__BACKGROUND, INVALID_BACKGROUND);
//			}
//		}
//	}
//
//	/**
//	 * Issue a warning if Feature has no scenarios defined. **note:** Do not depend
//	 * on grammar rule validation
//	 * 
//	 * @param model
//	 */
//	@Check(CheckType.FAST)
//	public void missingScenarios(Feature model) {
//		if (model.getScenarios().isEmpty()) {
//			warning("Feature has no scenarios", model, FEATURE__SCENARIOS, MISSING_SCENARIOS);
//		}
//	}
//
//	/**
//	 * Issue a warning if AbstractScenario has no defined steps. **note:** Do not
//	 * depend on grammar rule validation
//	 * 
//	 * @param model
//	 */
//	@Check(CheckType.FAST)
//	public void missingScenarioSteps(AbstractScenario model) {
//		if (model.getSteps().isEmpty()) {
//			warning("Scenario has no steps", model, ABSTRACT_SCENARIO__STEPS, MISSING_SCENARIO_STEPS);
//		}
//	}
//
//	@Check(CheckType.NORMAL)
//	public void invalidStepDefs(Step model) {
//		System.out.println("Validating: " + model);
//		final Counter counter = new Counter();
//		String description = model.getDescription().trim();
//		matcher.findMatches(description, counter);
//		if (counter.get() == 0) {
//			warning(String.format("No step definition found for `%s`", description), model, STEP__DESCRIPTION,
//					MISSING_STEPDEFS);
//		} else if (counter.get() > 1) {
//			warning(String.format("Multiple step definitions found for `%s`", description), model, STEP__DESCRIPTION,
//					MULTIPLE_STEPDEFS);
//		}
//	}
}
