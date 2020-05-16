package org.agileware.natural.cucumber.tests

import com.google.inject.Inject
import com.google.inject.Provider
import java.util.List
import org.agileware.natural.cucumber.cucumber.Feature
import org.agileware.natural.cucumber.cucumber.Scenario
import org.agileware.natural.cucumber.cucumber.Step
import org.agileware.natural.cucumber.validation.CucumberIssueCode
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.diagnostics.Severity
import org.eclipse.xtext.resource.SaveOptions
import org.eclipse.xtext.serializer.ISerializer
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.formatter.FormatterTestHelper
import org.eclipse.xtext.testing.formatter.FormatterTestRequest
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.eclipse.xtext.validation.Issue
import org.hamcrest.Matcher

import static org.hamcrest.MatcherAssert.assertThat
import static org.hamcrest.Matchers.allOf
import static org.hamcrest.Matchers.equalTo
import static org.hamcrest.Matchers.hasProperty
import static org.hamcrest.Matchers.notNullValue

@InjectWith(CucumberInjectorProvider)
class CucumberTestHelpers {
	@Inject public ParseHelper<Feature> parseHelper
	@Inject public ValidationTestHelper validationTestHelper
	@Inject public FormatterTestHelper formatterTestHelper
	@Inject public Provider<FormatterTestRequest> formatterRequestProvider
	
	@Inject extension ISerializer

	def Feature parse(CharSequence content) throws Exception {
		return parseHelper.parse(content)
	}
	
	def String serialize(Feature model) throws Exception {
		return model.serialize(SaveOptions.newBuilder.format().getOptions())
	}

	def List<Issue> validate(String contet) throws Exception {
		var Feature model = parseHelper.parse(contet)
		assertThat(model, notNullValue())
		return validationTestHelper.validate(model)
	}

	def void assertFormatted(String toBeFormatted, String expectation) {
		formatterTestHelper.assertFormatted(
			formatterRequestProvider.get().setToBeFormatted(toBeFormatted).setExpectation(expectation))
	}

	def static Matcher<Scenario> withScenario(String title) {
		return hasProperty("title", equalTo(title))
	}

	def static Matcher<Step> withStep(String keyword, String description) {
		return allOf(
			hasProperty("keyword", equalTo(keyword)), 
			hasProperty("description", equalTo(description))
		)
	}

	def static Matcher<Issue> theError(CucumberIssueCode issue) {
		return allOf(
			hasProperty("severity", equalTo(Severity.ERROR)), 
			hasProperty("code", equalTo(issue.code()))
		)
	}

	def static Matcher<Issue> theWarning(CucumberIssueCode issue) {
		return allOf(
			hasProperty("severity", equalTo(Severity.WARNING)), 
			hasProperty("code", equalTo(issue.code()))
		)
	}
}
