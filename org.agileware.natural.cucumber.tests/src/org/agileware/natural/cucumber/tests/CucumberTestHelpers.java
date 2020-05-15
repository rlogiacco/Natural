package org.agileware.natural.cucumber.tests;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasProperty;
import static org.hamcrest.Matchers.notNullValue;

import java.util.List;

import org.agileware.natural.cucumber.cucumber.Feature;
import org.agileware.natural.cucumber.cucumber.Scenario;
import org.agileware.natural.cucumber.cucumber.Step;
import org.agileware.natural.cucumber.validation.CucumberIssueCode;
import org.eclipse.xtext.diagnostics.Severity;
import org.eclipse.xtext.testing.InjectWith;
import org.eclipse.xtext.testing.formatter.FormatterTestHelper;
import org.eclipse.xtext.testing.formatter.FormatterTestRequest;
import org.eclipse.xtext.testing.util.ParseHelper;
import org.eclipse.xtext.testing.validation.ValidationTestHelper;
import org.eclipse.xtext.validation.Issue;
import org.hamcrest.Matcher;

import com.google.inject.Inject;
import com.google.inject.Provider;

@InjectWith(CucumberInjectorProvider.class)
public class CucumberTestHelpers {

	@Inject
	public ParseHelper<Feature> parseHelper;
	
	@Inject 
	public ValidationTestHelper validationTestHelper;
	
	@Inject
	public FormatterTestHelper formatterTestHelper;
	
	@Inject
	public Provider<FormatterTestRequest> formatterRequestProvider;

	public Feature parse(CharSequence content) throws Exception {
		return parseHelper.parse(content);
	}
	
	public List<Issue> validate(String contet) throws Exception {
		Feature model = parseHelper.parse(contet);
		assertThat(model, notNullValue());

		return validationTestHelper.validate(model);
	}

	public void assertFormatted(String toBeFormatted, String expectation) {
		formatterTestHelper.assertFormatted(
				formatterRequestProvider.get()
					.setToBeFormatted(toBeFormatted)
					.setExpectation(expectation));
	}

	static public Matcher<Scenario> withScenario(String title) {
		return hasProperty("title", equalTo(title));
	}

	static public Matcher<Step> withStep(String keyword, String description) {
		return allOf(
				hasProperty("keyword", equalTo(keyword)),
				hasProperty("description", equalTo(description))
		);
	}

	static public Matcher<Issue> theError(CucumberIssueCode issue) {
		return allOf(
				hasProperty("severity", equalTo(Severity.ERROR)), 
				hasProperty("code", equalTo(issue.code()))
		);
	}

	static public Matcher<Issue> theWarning(CucumberIssueCode issue) {
		return allOf(
				hasProperty("severity", equalTo(Severity.WARNING)), 
				hasProperty("code", equalTo(issue.code()))
		);
	}

}