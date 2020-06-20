package org.agileware.natural.cucumber.serializer

import org.agileware.natural.cucumber.cucumber.Background
import org.agileware.natural.cucumber.cucumber.DocString
import org.agileware.natural.cucumber.cucumber.Example
import org.agileware.natural.cucumber.cucumber.Feature
import org.agileware.natural.cucumber.cucumber.Scenario
import org.agileware.natural.cucumber.cucumber.ScenarioOutline
import org.agileware.natural.cucumber.cucumber.Step
import org.agileware.natural.cucumber.cucumber.Table
import org.agileware.natural.cucumber.cucumber.TableCol
import org.agileware.natural.cucumber.cucumber.TableRow
import org.agileware.natural.cucumber.cucumber.Tag
import org.eclipse.xtext.nodemodel.util.NodeModelUtils
import org.agileware.natural.cucumber.cucumber.Text

class CucumberSerializer {

	def String serialize(Feature model) '''
		«FOR t : model.tags»
			«serialize(t)»
		«ENDFOR»
		Feature: «model.title»
		«model.narrative»
		
		«IF model.background !== null»
			«serialize(model.background)»
		«ENDIF»
		«FOR s : model.scenarios»
		
			«IF s instanceof Scenario»
				«serialize(s)»
			«ELSEIF s instanceof ScenarioOutline»
				«serialize(s)»
			«ENDIF»
		«ENDFOR»
	'''

	def String serialize(Background model) '''
		Background: «model.title»
		«model.narrative»
		«FOR s : model.steps»
			«serialize(s)»
		«ENDFOR»
	'''

	def String serialize(Scenario model) '''
		«FOR t : model.tags»
			«serialize(t)»
		«ENDFOR»
		Scenario: «model.title»
		«model.narrative»
		«FOR s : model.steps»
			«serialize(s)»
		«ENDFOR»
	'''

	def String serialize(ScenarioOutline model) '''
		«FOR t : model.tags»
			«serialize(t)»
		«ENDFOR»
		Scenario Outline: «model.title»
		«model.narrative»
		«FOR s : model.steps»
			«serialize(s)»
		«ENDFOR»
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
		«ELSEIF model.code !== null»
			«serialize(model.code)»
		«ENDIF»
	'''

	def String serialize(Tag model) '''
		@«model.id»
	'''

	def String serialize(Table model) '''
		«FOR r : model.rows»
			«serialize(r)»
		«ENDFOR»
	'''


	def String serialize(TableRow model) '''
		«model.cols.map[serialize].join()» |
	'''
	
	def String serialize(TableCol model) {
		return model.cell
	}

	def String serialize(DocString model) '''
		"""
		«serialize(model.text)»
		"""
	'''
	
	/**
	 * TODO this will most certainly break two-way serialization,
	 *      as trailing line breaks are not assigned within the TEXT_VALUE.
	 */
	def String serialize(Text model) '''
		«FOR l : model.lines»
			«l.value»
		«ENDFOR»
	'''
}
