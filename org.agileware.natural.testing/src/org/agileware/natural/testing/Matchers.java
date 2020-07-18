package org.agileware.natural.testing;

import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.hasProperty;
import static org.hamcrest.Matchers.not;

import org.eclipse.xtext.diagnostics.Severity;
import org.eclipse.xtext.validation.Issue;
import org.hamcrest.Matcher;

public class Matchers {

	public static Matcher<Issue> theError(String code) {
		return allOf(
				hasProperty("severity", equalTo(Severity.ERROR)), 
				hasProperty("code", equalTo(code))
		);
	}

	public static Matcher<Issue> theWarning(String code) {
		return allOf(
				hasProperty("severity", equalTo(Severity.WARNING)), 
				hasProperty("code", equalTo(code))
		);
	}
	
	public static Matcher<Iterable<? super Issue>> hasNoErrors() {
		return not(hasItem(hasProperty("severity", 
				equalTo(Severity.ERROR))));
	}

}
