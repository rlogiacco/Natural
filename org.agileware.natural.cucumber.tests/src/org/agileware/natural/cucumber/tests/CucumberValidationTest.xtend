package org.agileware.natural.cucumber.tests

import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

import static org.agileware.natural.cucumber.tests.CucumberTestHelpers.*
import static org.agileware.natural.cucumber.validation.IssueCode.*
import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.Matchers.*
import com.google.inject.Inject

@RunWith(XtextRunner)
@InjectWith(CucumberInjectorProvider)
class CucumberValidationTest {
	
	@Inject CucumberTestHelpers _th

	@Test
	def void missingScenarios() {
		val issues = _th.validate('''
			Feature: Hello, Cucumber!
		''')

		assertThat(issues, not(empty()))
		assertThat(issues, containsInAnyOrder(theError(MissingScenarios)))
	}

	@Test
	def void missingSteps() {
		val issues = _th.validate('''
			Feature: Hello, Cucumber!
			Scenario: Goobye, World!
		''')

		assertThat(issues, not(empty()))
		assertThat(issues, containsInAnyOrder(theError(MissingSteps)))
	}
}
