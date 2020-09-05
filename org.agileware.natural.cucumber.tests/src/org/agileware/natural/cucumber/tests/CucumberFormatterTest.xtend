package org.agileware.natural.cucumber.tests

import org.agileware.natural.cucumber.cucumber.CucumberModel
import org.agileware.natural.testing.AbstractFormatterTest
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

import static org.agileware.natural.cucumber.tests.Constants.EXAMPLE_FEATURE

@RunWith(XtextRunner)
@InjectWith(CucumberInjectorProvider)
class CucumberFormatterTest extends AbstractFormatterTest<CucumberModel> {

	@Test
	def void preserveValidFormatting() {
		assertFormatted(EXAMPLE_FEATURE)
	}

	@Test
	def void indentScenarioSteps_01() {
		// MUST preserve existing format
		val toBeFormatted = '''
			# language: en
			Feature: Jack and Jill
				
				Background:
					Given a precondition
				
				Scenario: Jack falls down
					When Jack falls down
					Then Jill comes tumbling after
		'''
		assertFormatted(toBeFormatted)
	}

	@Test
	def void indentScenarioSteps_02() {
		// SHOULD align steps to column 1
		val toBeFormatted = '''
			# language: en
			Feature: Jack and Jill
			
			Background:
			Given a precondition
			
			Scenario: Jack falls down
			When Jack falls down
			Then Jill comes tumbling after
		'''
		val expectation = '''
			# language: en
			Feature: Jack and Jill
				
				Background:
					Given a precondition
			
				Scenario: Jack falls down
					When Jack falls down
					Then Jill comes tumbling after
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void indentScenarioSteps_03() {
		// SHOULD align steps to column 1
		val toBeFormatted = '''
			# language: en
			@foo
			@bar
			Feature: Jack and Jill
			
			Background:
			Given a precondition
			
			@foo @bar
			Scenario: A
			And another
			
			@foo
			@bar
			Scenario: B
			When something happens
			Then there should be a result
		'''
		val expectation = '''
			# language: en
			@foo
			@bar
			Feature: Jack and Jill
				
				Background:
					Given a precondition
			
				@foo
				@bar
				Scenario: A
					And another
			
				@foo
				@bar
				Scenario: B
					When something happens
					Then there should be a result
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void indentScenarioOutline_01() {
		// MUST preserve existing formatting
		val toBeFormatted = '''
			# language: en
			Feature: With a title
				
				Scenario Outline:
					Given <foo>
					And <bar>
				
					Examples:
					| foo | bar |
					|  12 |  10 |
					|  20 |  15 |
		'''
		assertFormatted(toBeFormatted)
	}

	@Test
	def void indentScenarioOutline_02() {
		val toBeFormatted = '''
			# language: en
			Feature: With a title
			
			Scenario Outline:
			Given <foo>
			And <bar>
			
			Examples:
			| foo | bar |
			|  12 |  10 |
			|  20 |  15 |
		'''
		val expectation = '''
			# language: en
			Feature: With a title
				
				Scenario Outline:
					Given <foo>
					And <bar>
			
					Examples:
					| foo | bar |
					|  12 |  10 |
					|  20 |  15 |
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void indentScenarioOutline_03() {
		// MUST preserve existing formatting
		val toBeFormatted = '''
			# language: en
			Feature: With a title
				
				Scenario Outline:
					Given <foo>
					And <bar>
			
					@foo
					Examples:
					| foo | bar |
					|  12 |  10 |
					|  20 |  15 |
			
					@bar
					Examples:
					| foo | bar |
					|  12 |  10 |
					|  20 |  15 |
		'''
		assertFormatted(toBeFormatted)
	}

	@Test
	def void indentScenarioOutline_04() {
		val toBeFormatted = '''
			# language: en
			Feature: With a title
			
			Scenario Outline:
			Given <foo>
			And <bar>
			
			@foo
			Examples:
			| foo | bar |
			|  12 |  10 |
			|  20 |  15 |
			
			@bar
			Examples:
			| foo | bar |
			|  12 |  10 |
			|  20 |  15 |
		'''
		val expectation = '''
			# language: en
			Feature: With a title
				
				Scenario Outline:
					Given <foo>
					And <bar>
			
					@foo
					Examples:
					| foo | bar |
					|  12 |  10 |
					|  20 |  15 |
			
					@bar
					Examples:
					| foo | bar |
					|  12 |  10 |
					|  20 |  15 |
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void indentDocString_01() {
		// SHOULD  DocString to column 1
		val toBeFormatted = '''
			# language: en
			Feature: With a title
			
			Scenario:
			Given the DocString
			"""
			The quick brown fox
			Jumps over the lazy dog
			"""
		'''
		val expectation = '''
			# language: en
			Feature: With a title
				
				Scenario:
					Given the DocString
					"""
					The quick brown fox
					Jumps over the lazy dog
					"""
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void indentStepInterior_01() {
		// MUST preserve existing formatting
		val toBeFormatted = '''
			# language: en
			Feature: With a title
				
				Scenario: Stock Symbols
					The quick brown fox
					Jumps over the lazy dog
				
					Given the stock is traded at 5.0
					"""
					The quick brown fox
					Jumps over the lazy dog
					"""
					And the alert status should be OFF
					When the stock is traded at 11.0
					| precondition | be-captured     |
					| abc          | be captured     |
					| xyz          | not be captured |
					Then the alert status should be ON
		'''
		assertFormatted(toBeFormatted)
	}

	@Test
	def void indentStepInterior_02() {
		// SHOULD align Table and DocString to column 1
		val toBeFormatted = '''
			# language: en
			Feature: With a title
			
			Scenario:
			Given the stock is traded at 5.0
			"""
			The quick brown fox
			Jumps over the lazy dog
			"""
			And the alert status should be OFF
			When the stock is traded at 11.0
			| precondition | be-captured     |
			| abc          | be captured     |
			| xyz          | not be captured |
			Then the alert status should be ON
		'''
		val expectation = '''
			# language: en
			Feature: With a title
				
				Scenario:
					Given the stock is traded at 5.0
					"""
					The quick brown fox
					Jumps over the lazy dog
					"""
					And the alert status should be OFF
					When the stock is traded at 11.0
					| precondition | be-captured     |
					| abc          | be captured     |
					| xyz          | not be captured |
					Then the alert status should be ON
		'''
		assertFormatted(toBeFormatted, expectation)
	}
}
