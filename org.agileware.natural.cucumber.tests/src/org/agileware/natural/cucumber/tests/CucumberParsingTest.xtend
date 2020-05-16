/*
 * generated by Xtext
 */
package org.agileware.natural.cucumber.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

import static org.agileware.natural.cucumber.tests.CucumberTestHelpers.*
import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.Matchers.*

@RunWith(XtextRunner)
@InjectWith(CucumberInjectorProvider)
class CucumberParsingTest {

	@Inject CucumberTestHelpers _th
	
	@Test
	def void helloCucumber() {
		val feature = _th.parse('''
			Feature: Hello, Cucumber!
			  The quick brown fox
			  Jumps over the lazy dog
			
			Scenario: Jack and Jill
			  Given Jack and Jill went up a hill
		''')

		// Should parse without issues
		assertThat(feature, notNullValue())
		assertThat(feature.eResource.errors, empty())
		
		assertThat(feature.title, equalTo("Hello, Cucumber!"))
		assertThat(feature.narrative, notNullValue())
		assertThat(feature.narrative.lines, hasSize(2))

		val scenarios = feature.scenarios
		assertThat(scenarios, hasSize(1))
		assertThat(scenarios, hasItem(withScenario("Jack and Jill")))
		
		val steps = scenarios.get(0).steps
		assertThat(steps, hasSize(1))
		assertThat(steps, hasItems(
			withStep("Given", "Jack and Jill went up a hill")
		))
	}

	@Test
	def void scenarioWithBackground() {
		val feature = _th.parse('''
			Feature: Jack and Jill
			
			Background: 
			  Given Jack and Jill went up a hill
			  
			Scenario: Jack falls down
			  When "Jack" falls down
			  Then "Jill" comes tumbling after
		''')

		// Should parse without issues
		assertThat(feature, notNullValue())
		assertThat(feature.eResource.errors, empty())
		
		assertThat(feature.title, equalTo("Jack and Jill"))
		
		val background = feature.background
		assertThat(background, notNullValue())
		assertThat(background.steps, hasItems(
			withStep("Given", "Jack and Jill went up a hill")
		))

		val scenarios = feature.scenarios
		assertThat(scenarios, hasSize(1))
		assertThat(scenarios.get(0).steps, hasItems(
			withStep("When", "\"Jack\" falls down"),
			withStep("Then", "\"Jill\" comes tumbling after")
		))
	}
	
	@Test
	def void stepsWithData() {
		val feature = _th.parse('''
			Feature: Jack and Jill
			
			Scenario: Jack
			  Given the pet
			    | name | status      |
			    | Fido | unavailable |
			  Then the owner
			  """
			  Is sad to see him go
			  """
		''')
		
		// Should parse without issues
		assertThat(feature, notNullValue())
		assertThat(feature.eResource.errors, empty())
		assertThat(feature.scenarios, hasSize(1))
		
		val steps = feature.scenarios.get(0).steps
		assertThat(steps, hasSize(2))
		assertThat(steps, hasItems(
			withStep("Given", "the pet"),
			withStep("Then", "the owner")
		))
		
		assertThat(steps.get(0).table, notNullValue())
		assertThat(steps.get(1).text.value, equalToCompressingWhiteSpace('''
		  """
		  Is sad to see him go
		  """
		'''))
	}

	@Test
	def void allSupportedSyntax() {
		val feature = _th.parse(EXAMPLE_FEATURE)
		assertThat(feature, notNullValue())
		assertThat(feature.eResource.errors, empty())
	}
}
