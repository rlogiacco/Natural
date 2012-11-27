package org.agileware.natural.cucumber.validation;

import org.agileware.natural.common.JavaAnnotationMatcher;
import org.agileware.natural.cucumber.cucumber.CucumberPackage;
import org.agileware.natural.cucumber.cucumber.Step;
import org.eclipse.jdt.core.IMethod;
import org.eclipse.xtext.validation.Check;

import com.google.inject.Inject;

public class CucumberJavaValidator extends AbstractCucumberJavaValidator {
	
	@Inject
	private JavaAnnotationMatcher matcher;

	@Check
	public void checkStepMatching(Step step) {
		final Counter counter = new Counter();
		String description = step.getDescription().trim();
		matcher.findMatches(description, counter);
		if (counter.get() == 0) {
			warning("No definition found for `" + description + "`", CucumberPackage.Literals.STEP__DESCRIPTION);
		} else if (counter.get() > 1) {
			warning("Multiple definitions found for `" + description + "`", CucumberPackage.Literals.STEP__DESCRIPTION);
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
