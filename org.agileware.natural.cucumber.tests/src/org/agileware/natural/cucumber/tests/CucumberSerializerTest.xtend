package org.agileware.natural.cucumber.tests

import com.google.inject.Inject
import org.agileware.natural.cucumber.cucumber.CucumberFactory
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.Matchers.*

@RunWith(XtextRunner)
@InjectWith(CucumberInjectorProvider)
class CucumberSerializerTest {
	
	CucumberFactory _factory = CucumberFactory.eINSTANCE

	@Inject CucumberTestHelpers _th
	
	@Test
	def void featureWithNarrative() {
		
		val model = _factory.createFeature()
		model.title = "The quick brown fox"
		model.narrative = _factory.createNarrative()
		model.narrative.lines.add(_factory.createNarrativeLine())
		model.narrative.lines.get(0).value = "Jumps over"
		model.narrative.lines.add(_factory.createNarrativeLine())
		model.narrative.lines.get(1).value = "The lazy dog"

		val expectation = '''
			Feature: The quick brown fox 
			  Jumps over
			  The lazy dog
		'''

		val result = _th.serialize(model)
		assertThat(result, equalToCompressingWhiteSpace(expectation))
	}
}
