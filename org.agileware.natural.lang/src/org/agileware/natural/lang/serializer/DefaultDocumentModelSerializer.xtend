package org.agileware.natural.lang.serializer

import org.agileware.natural.lang.model.DocumentModel
import org.agileware.natural.lang.model.Narrative
import org.agileware.natural.lang.model.Paragraph
import org.agileware.natural.lang.model.Section

class DefaultDocumentModelSerializer {
	def String serialize(DocumentModel model) '''
		# language: en
		«FOR s : model.sections»
			
			«serialize(s)»
		«ENDFOR»
	'''
	
	def String serialize(Section model) '''
		Section: «model.title»
		«IF model.narrative !== null»
			«serialize(model.narrative)»
		«ENDIF»
	'''
	
	def String serialize(Narrative model) '''
		«FOR s : model.sections»
			
			«serialize(s)»
		«ENDFOR»
	'''
	
	def String serialize(Paragraph model) '''
		«FOR l : model.lines»
			«l.value»
		«ENDFOR»
	'''
}