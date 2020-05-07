package org.agileware.natural.cucumber.tests

import com.google.inject.Inject
import java.util.List
import org.agileware.natural.cucumber.cucumber.Feature
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.eclipse.xtext.validation.Issue
import org.junit.Test
import org.junit.runner.RunWith

import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.Matchers.*

@RunWith(XtextRunner)
@InjectWith(CucumberInjectorProvider)
class CucumberValidationTest {

	@Inject ParseHelper<Feature> parseHelper

	@Inject ValidationTestHelper validationTestHelper

	def List<Issue> validate(String contet) {
		val model = parseHelper.parse(contet)
		assertThat(model, notNullValue())

		return validationTestHelper.validate(model)
	}

	@Test
	def void missingScenarios() {
		val issues = validate('''
			Feature: Hello, Cucumber!
		''')

		assertThat(issues, not(empty()))
	}
}
