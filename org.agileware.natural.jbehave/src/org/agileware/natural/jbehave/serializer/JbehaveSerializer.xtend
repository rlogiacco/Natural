package org.agileware.natural.jbehave.serializer

import org.agileware.natural.jbehave.jbehave.AsA
import org.agileware.natural.jbehave.jbehave.Description
import org.agileware.natural.jbehave.jbehave.Examples
import org.agileware.natural.jbehave.jbehave.GivenStories
import org.agileware.natural.jbehave.jbehave.IWantTo
import org.agileware.natural.jbehave.jbehave.InOrderTo
import org.agileware.natural.jbehave.jbehave.Lifecycle
import org.agileware.natural.jbehave.jbehave.LifecycleAfter
import org.agileware.natural.jbehave.jbehave.LifecycleBefore
import org.agileware.natural.jbehave.jbehave.Meta
import org.agileware.natural.jbehave.jbehave.MetaElement
import org.agileware.natural.jbehave.jbehave.Narrative
import org.agileware.natural.jbehave.jbehave.NarrativeA
import org.agileware.natural.jbehave.jbehave.NarrativeB
import org.agileware.natural.jbehave.jbehave.Scenario
import org.agileware.natural.jbehave.jbehave.SoThat
import org.agileware.natural.jbehave.jbehave.Step
import org.agileware.natural.jbehave.jbehave.Story
import org.agileware.natural.jbehave.jbehave.StoryPath
import org.agileware.natural.jbehave.jbehave.Table

class JbehaveSerializer {
	
	def String serialize(Story model) '''
		«IF model.description !== null»
			«serialize(model.description)»
			
		«ENDIF»
		«IF model.meta !== null»
			«serialize(model.meta)»
			
		«ENDIF»
		«IF model.narrative !== null»
			«serialize(model.narrative)»
			
		«ENDIF»
		«IF model.lifecycle !== null»
			«serialize(model.lifecycle)»
			
		«ENDIF»
		«FOR s : model.scenarios»
			«serialize(s)»
			
		«ENDFOR»
	'''
	
	def String serialize(Description model) '''
		«FOR l : model.lines»
			«l»
		«ENDFOR»
	'''
	
	def String serialize(Meta model) '''
		Meta:
		«FOR e : model.elements»
			«serialize(e)»
		«ENDFOR»
	'''
	
	def String serialize(MetaElement model) '''
		@«model.key» «model.value»
	'''
	
	def String serialize(Narrative model) {
		if(model instanceof NarrativeA) {
			return serialize(model as NarrativeA)
		}
		else if(model instanceof NarrativeB) {
			return serialize(model as NarrativeB)
		}
	}
	
	def String serialize(NarrativeA model) '''
		Narrative:
		«serialize(model.inOrderTo)»
		«serialize(model.asA)»
		«serialize(model.wantTo)»
	'''
	
	def String serialize(NarrativeB model) '''
		Narrative:
		«serialize(model.asA)»
		«serialize(model.wantTo)»
		«serialize(model.soThat)»
	'''
	
	def String serialize(InOrderTo model) '''
		In order to «model.content»
	'''
	
	def String serialize(AsA model) '''
		As a «model.content»
	'''
	
	def String serialize(IWantTo model) '''
		I want to «model.content»
	'''
	
	def String serialize(SoThat model) '''
		So that «model.content»
	'''
	
	def String serialize(Scenario model) '''
		Scenario: «model.title»
		
		«IF model.meta !== null»
			«serialize(model.meta)»
			
		«ENDIF»
		«IF model.given !== null»
			«serialize(model.given)»
			
		«ENDIF»
		«FOR s : model.steps»
			«serialize(s)»
		«ENDFOR»
		«IF model.examples !== null»
			
			«serialize(model.examples)»
		«ENDIF»
	'''
	
	def String serialize(GivenStories model) '''
		GivenStories:
			«FOR r : model.resources SEPARATOR ','»
				«serialize(r)»
			«ENDFOR»
	'''
	
	def String serialize(StoryPath model) '''
		«model.path»
	'''
	
	def String serialize(Lifecycle model) '''
		Lifecycle:
		«IF model.before !== null»
			«serialize(model.before)»
		«ENDIF»
		«IF model.after !== null»
			«serialize(model.after)»
		«ENDIF»
	'''
	
	def String serialize(LifecycleBefore model) '''
		Before:
	'''
	
	def String serialize(LifecycleAfter model) '''
		After:
	'''
	
	def String serialize(Step model) '''
		«model.type» «model.content»
	'''
	
	def String serialize(Examples model) '''
		Examples:
		«IF model.table !== null»
			«serialize(model.table)»
		«ENDIF»
	'''
	
	def String serialize(Table model) '''
		«model.header»
		«FOR r : model.rows»
			«r»
		«ENDFOR»
	'''
}
