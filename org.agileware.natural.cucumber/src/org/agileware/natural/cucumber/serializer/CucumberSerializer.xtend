package org.agileware.natural.cucumber.serializer

import com.google.inject.Inject
import org.agileware.natural.cucumber.cucumber.AbstractScenario
import org.agileware.natural.cucumber.cucumber.Background
import org.agileware.natural.cucumber.cucumber.CucumberModel
import org.agileware.natural.cucumber.cucumber.Example
import org.agileware.natural.cucumber.cucumber.Feature
import org.agileware.natural.cucumber.cucumber.Scenario
import org.agileware.natural.cucumber.cucumber.ScenarioOutline
import org.agileware.natural.cucumber.cucumber.Step
import org.agileware.natural.lang.serializer.NaturalSerializer
import org.eclipse.xtext.nodemodel.util.NodeModelUtils

class CucumberSerializer {

	@Inject extension NaturalSerializer

	def String serialize(CucumberModel model) '''
		# language: en
		«IF model.document !== null»
			«serialize(model.document)»
		«ENDIF»
	'''

	def String serialize(Feature model) '''
		«serialize(model.meta)»
		Feature: «model.title»
		«model.narrative»
		«FOR s : model.scenarios»
			
			«serialize(s)»
		«ENDFOR»
	'''

	def String serialize(AbstractScenario model) {
		if (model instanceof Background) {
			return serialize(model as Background)
		} else if (model instanceof Scenario) {
			return serialize(model as Scenario)
		} else if (model instanceof ScenarioOutline) {
			return serialize(model as ScenarioOutline)
		}

		return "\n"
	}

	def String serialize(Background model) '''
		«serialize(model.meta)»
		Background: «model.title»
		«model.narrative»
		«FOR s : model.steps»
			«serialize(s)»
		«ENDFOR»
	'''

	def String serialize(Scenario model) '''
		«serialize(model.meta)»
		Scenario: «model.title»
		«model.narrative»
		«FOR s : model.steps»
			«serialize(s)»
		«ENDFOR»
	'''

	def String serialize(ScenarioOutline model) '''
		«serialize(model.meta)»
		Scenario Outline:«model.title»
		«model.narrative»
		«FOR e : model.examples»
			
				«serialize(e)»
		«ENDFOR»
	'''

	def String serialize(Example model) '''
		Example: «model.title»
		«model.narrative»
		«serialize(model.table)»
	'''

	def String serialize(Step model) '''
		«NodeModelUtils.getNode(model).getText()»
		«IF model.table !== null»
			«serialize(model.table)»
		«ELSEIF model.text !== null»
			«serialize(model.text)»
		«ENDIF»
	'''
}
