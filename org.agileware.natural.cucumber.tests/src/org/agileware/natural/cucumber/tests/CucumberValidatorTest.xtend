package org.agileware.natural.cucumber.tests

import org.agileware.natural.cucumber.model.CucumberModel
import org.agileware.natural.testing.AbstractParserTest
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.Matchers.*

@RunWith(XtextRunner)
@InjectWith(CucumberInjectorProvider)
class CucumberValidatorTest extends AbstractParserTest<CucumberModel>  {
	
	@Test
	def void simpleValidFeature() {
		val issues = validate(parse('''
			Feature: Hello, World!
			
			Scenario: A
				Given a precondition
			
			Scenario: B
				And another
		'''))

		assertThat(issues, empty())
	}
}