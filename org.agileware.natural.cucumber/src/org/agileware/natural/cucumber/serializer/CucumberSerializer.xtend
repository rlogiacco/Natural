package org.agileware.natural.cucumber.serializer

import org.agileware.natural.cucumber.cucumber.AbstractScenario
import org.agileware.natural.cucumber.cucumber.Background
import org.agileware.natural.cucumber.cucumber.DocString
import org.agileware.natural.cucumber.cucumber.Example
import org.agileware.natural.cucumber.cucumber.Feature
import org.agileware.natural.cucumber.cucumber.Meta
import org.agileware.natural.cucumber.cucumber.Narrative
import org.agileware.natural.cucumber.cucumber.Scenario
import org.agileware.natural.cucumber.cucumber.ScenarioOutline
import org.agileware.natural.cucumber.cucumber.Step
import org.agileware.natural.cucumber.cucumber.Table
import org.agileware.natural.cucumber.cucumber.Tag
import org.agileware.natural.cucumber.cucumber.TextLine

class CucumberSerializer {
	
	def String serialize(Feature model) '''
		«IF model.meta !== null»
			«serialize(model.meta)»
		«ENDIF»
		Feature: «model.title»
		«serialize(model.narrative)»
		«IF model.background !== null»
			«serialize(model.background)»
		«ENDIF»
		«FOR s : model.scenarios»
			«serialize(s)»
		«ENDFOR»
	'''
	
	def String serialize(Background model) '''
		Background: «model.title»
		«serialize(model.narrative)»
		«FOR s : model.steps»
			«serialize(s)»
		«ENDFOR»
	'''
	
	def String serialize(AbstractScenario model) {
		if(model instanceof Scenario) {
			return serialize(model as Scenario)
		}
		else if(model instanceof ScenarioOutline) {
			return serialize(model as ScenarioOutline)
		}
		
		return ""
	}
	
	def String serialize(Scenario model) '''
		«IF model.meta !== null»
			«serialize(model.meta)»
		«ENDIF»
		Scenario: «model.title»
		«serialize(model.narrative)»
		«FOR s : model.steps»
			«serialize(s)»
		«ENDFOR»
	'''
	
	def String serialize(ScenarioOutline model) '''
		«IF model.meta !== null»
			«serialize(model.meta)»
		«ENDIF»
		Scenario Outline: «model.title»
		«serialize(model.narrative)»
		«FOR s : model.steps»
			«serialize(s)»
		«ENDFOR»
		«FOR e : model.examples»
			«serialize(e)»
		«ENDFOR»
	'''
	
	def String serialize(Example model) '''
		«IF model.meta !== null»
			«serialize(model.meta)»
		«ENDIF»
		Example: «model.title»
		«serialize(model.narrative)»
		«serialize(model.table)»
	'''
	
	def String serialize(Step model) '''
		«model.keyword» «model.description»
		«IF model.table !== null»
			«serialize(model.table)»
		«ELSEIF model.text !== null»
			«serialize(model.text)»
		«ENDIF»
	'''
	
	def String serialize(Meta model) '''
		«FOR t : model.tags»
			«serialize(t)»
		«ENDFOR»
	'''
	
	def String serialize(Tag model) '''
		@«model.key» «model.value»
	'''
	
	def String serialize(Table model) '''
		«FOR r : model.rows»
			«r»
		«ENDFOR»
	'''
	
	
	def String serialize(DocString model) '''
		"""
		«FOR l : model.lines»
			«serialize(l)»
		«ENDFOR»
		"""
	'''
	
	def String serialize(Narrative model) '''
		«FOR l : model.lines»
			«serialize(l)»
		«ENDFOR»
	'''
	
	def String serialize(TextLine model) '''
		«model.value»
	'''
}