package org.agileware.natural.cucumber.tests

import com.google.inject.Inject
import java.util.List
import org.agileware.natural.cucumber.cucumber.Feature
import org.agileware.natural.cucumber.cucumber.Scenario
import org.agileware.natural.cucumber.cucumber.Step
import org.agileware.natural.cucumber.validation.CucumberIssueCode
import org.eclipse.xtext.diagnostics.Severity
import org.eclipse.xtext.testing.InjectWith
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
	
	public static String EXAMPLE_FEATURE = '''
		@release:Release-2 
		@version:1.0.0
		@pet_store
		Feature: Add a new pet 
			In order to sell a pet
			As a store owner
			I want to add a new pet to the catalog
		
		Background: Add a dog 
			Given I have the following pet
				| name | status    |
				| Fido | available |
			And I add the pet to the store
		
		@add @fido
		Scenario: Add a dog 
			Then the pet should be available in the store 
			
		@update @fido
		Scenario: Update a dog 
			Given the pet is available in the store
			When I update the pet with  
				| name | status      |
				| Fido | unavailable |
			Then the pet should be unavailable in the store 
		
		@eat-pickles	
		Scenario Outline: Eating pickles
			Given there are <start> pickles
			When I eat <eat> pickles
			Then I should have <left> pickles
		
			@hungry
			Examples:
				| start | eat | left |
				|    12 |  10 |    2 |
				|    20 |  15 |    5 |
		
			@full
			Examples:
				| start | eat | left |
				|    12 |   2 |   10 |
				|    20 |   5 |   15 |
				
	'''
	

	def Feature parse(CharSequence content) {
		return parseHelper.parse(content)
	}

	def List<Issue> validate(String contet) {
		val model = parseHelper.parse(contet)
		assertThat(model, notNullValue())
		
		return validationTestHelper.validate(model)
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
