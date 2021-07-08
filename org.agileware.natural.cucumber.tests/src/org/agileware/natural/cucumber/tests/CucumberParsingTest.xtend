package org.agileware.natural.cucumber.tests

import com.google.inject.Inject
import org.agileware.natural.cucumber.cucumber.CucumberModel
import org.agileware.natural.cucumber.cucumber.ScenarioOutline
import org.agileware.natural.cucumber.serializer.CucumberSerializer
import org.agileware.natural.testing.AbstractParserTest
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

import static org.agileware.natural.testing.Matchers.*
import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.Matchers.*

@RunWith(XtextRunner)
@InjectWith(CucumberInjectorProvider)
class CucumberParsingTest extends AbstractParserTest<CucumberModel> {

	@Inject CucumberSerializer serializer

	@Test
	def void parseSimpleFeature() {
		val model = parse('''
			Feature: Hello, World!
			
			Scenario: A
				Given a precondition
			
			Scenario: B
				And another
		''')

		assertThat(model, notNullValue())
		assertThat(validate(model), empty())
	}

	@Test
	def void parseTableData() {
		val model = parse('''
			# language: en
			Feature: Hello, Tables!
			
			Scenario: A
			Given the data
			| name  | status |
			
			Scenario Outline: B
			Given <foo>
			And <bar>
			
			Examples:
			| foo | bar |
			|  12 |  10 |
			|  20 |  15 |
		''')

		assertThat(model, notNullValue())
		assertThat(validate(model), empty())

		val doc = model.document
		assertThat(doc, notNullValue())

//		val t1 = doc.scenarios.get(0).steps.get(0).table
//		assertThat(t1, notNullValue())
//		assertThat(t1.rows, hasSize(1))
//
//		val t2 = (doc.scenarios.get(1) as ScenarioOutline).examples.get(0).table
//		assertThat(t2, notNullValue())
//		assertThat(t2.rows, hasSize(3))
	}

	@Test
	def void parseFullExample() {
		val model = parse('''
			#language: en
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
					But the pet is not yet mine
			
				@add @fido
				Scenario: Add another dog 
					Then the should be available in the store
			
				@update @fido
				Scenario:
					Given the pet is available in the store -9.8
					"""
					The quick brown fox
					Jumps over the lazy dog
					"""
					When I update the pet with  
						| name | status      |
						| Fido | unavailable |
					Then the pet should be "unavailable" in the store 
			
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
					Examples: With a title
					| start | eat | left |
					|    12 |   2 |   10 |
					|    20 |   5 |   15 |
		''')

		assertThat(model, notNullValue())
		assertThat(validate(model), hasNoErrors())
	}
}
