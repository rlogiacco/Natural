package org.agileware.natural.cucumber.tests;

import static org.hamcrest.Matchers.*;

import org.agileware.natural.cucumber.cucumber.Scenario;
import org.agileware.natural.cucumber.cucumber.Step;
import org.agileware.natural.cucumber.validation.IssueCode;
import org.eclipse.xtext.diagnostics.Severity;
import org.eclipse.xtext.validation.Issue;
import org.hamcrest.Matcher;

public class CucumberMatchers {

	static public Matcher<Scenario> withScenario(String title) {
		return hasProperty("title", equalTo(title));
	}

	static public Matcher<Step> withStep(String description) {
		return hasProperty("description", equalTo(description));
	}
	
	static public Matcher<Issue> theError(IssueCode issue) {
		return allOf(
				hasProperty("severity", equalTo(Severity.ERROR)),
				hasProperty("code", equalTo(issue.code()))
		);
	}

	static public Matcher<Issue> theWarning(IssueCode issue) {
		return allOf(
				hasProperty("severity", equalTo(Severity.WARNING)),
				hasProperty("code", equalTo(issue.code()))
		);
	}

}