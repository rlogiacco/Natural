package org.rlogiacco.eclipse.cucumber.validation;

import org.eclipse.jdt.core.IMethod;
import org.eclipse.xtext.validation.Check;
import org.rlogiacco.eclipse.bdd.common.JavaAnnotationMatcher;
import org.rlogiacco.eclipse.cucumber.cucumberDSL.CucumberDSLPackage;
import org.rlogiacco.eclipse.cucumber.cucumberDSL.Step;

import com.google.inject.Inject;

public class CucumberDSLJavaValidator extends AbstractCucumberDSLJavaValidator {
	
	@Inject
	private JavaAnnotationMatcher matcher;

	@Check
	public void checkStepMatching(Step step) {
		final Counter counter = new Counter();
		String description = step.getDescription().substring(step.getDescription().indexOf(' ') + 1);
		matcher.findMatches(description, new JavaAnnotationMatcher.Command() {

			public void match(String annotationValue, IMethod method) {
				counter.increment();
			}
		});
		if (counter.get() == 0) {
			warning("No definition found for `" + description + "`", CucumberDSLPackage.Literals.STEP__DESCRIPTION);
		} else if (counter.get() > 1) {
			warning("Multiple definition found for `" + description + "`", CucumberDSLPackage.Literals.STEP__DESCRIPTION);
		}
	}

	private final static class Counter {
		private int count = 0;
		
		public void increment() {
			count++;
		}
		
		public int get() {
			return count;
		}
	}
}
