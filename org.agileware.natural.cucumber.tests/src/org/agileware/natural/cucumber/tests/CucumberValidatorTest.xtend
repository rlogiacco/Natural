package org.agileware.natural.cucumber.tests

import org.agileware.natural.cucumber.cucumber.CucumberModel
import org.agileware.natural.testing.AbstractParserTest
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

import static org.agileware.natural.cucumber.validation.CucumberIssueCodes.*
import static org.agileware.natural.testing.Matchers.*
import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.Matchers.*

@RunWith(XtextRunner)
@InjectWith(CucumberInjectorProvider)
class CucumberValidatorTest extends AbstractParserTest<CucumberModel> {

	@Test
	def void featureMissingTitle() {
		val issues = validate(parse('''
			# language: en
			Feature:
			Scenario: A
			Given a step
		'''))

		assertThat(issues, hasItems(theWarning(MISSING_FEATURE_TITLE)))
	}

	@Test
	def void featureMissingScenarios() {
		val issues = validate(parse('''
			# language: en
			Feature: With a title
		'''))

		assertThat(issues, hasItems(theWarning(MISSING_SCENARIOS)))
	}

	@Test
	def void scenarioMissingSteps() {
		val issues = validate(parse('''
			# language: en
			Feature: With a title
			Background:
		'''))

		assertThat(issues, hasItems(theWarning(MISSING_SCENARIO_STEPS)))
	}
}
