package org.agileware.natural.lang.serializer

import org.agileware.natural.lang.model.DocString
import org.agileware.natural.lang.model.NaturalDocument
import org.agileware.natural.lang.model.Meta
import org.agileware.natural.lang.model.Narrative
import org.agileware.natural.lang.model.NarrativeSection
import org.agileware.natural.lang.model.Paragraph
import org.agileware.natural.lang.model.Section
import org.agileware.natural.lang.model.Table
import org.agileware.natural.lang.model.TableCol
import org.agileware.natural.lang.model.TableRow
import org.agileware.natural.lang.model.Tag
import org.eclipse.xtext.util.Strings

class DefaultNaturalSerializer {
	def String serialize(NaturalDocument model) '''
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

	def String serialize(NarrativeSection model) {
		if(model instanceof Paragraph) {
			return serialize(model as Paragraph)
		}
		else if(model instanceof Table) {
			return serialize(model as Table)
		}
		else if(model instanceof DocString) {
			return serialize(model as DocString)
		}
	}

	def String serialize(Meta model) '''
		«FOR t : model.tags»
			«serialize(t)»
		«ENDFOR»
	'''

	def String serialize(Tag model) {
		if(Strings.isEmpty(model.value)) {
			return '''
				@«model.id»
			'''
		}
		
		return '''
			@«model.id»: «model.value»
		'''
	}

	def String serialize(Paragraph model) '''
		«FOR l : model.lines»
			«l.value»
		«ENDFOR»
	'''

	def String serialize(DocString model) '''
		"""
		«FOR l : model.contents.lines»
			«l»
		«ENDFOR»
		"""
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

}
