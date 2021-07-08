package org.agileware.natural.lang.serializer

import org.agileware.natural.lang.model.Block
import org.agileware.natural.lang.model.DocString
import org.agileware.natural.lang.model.Document
import org.agileware.natural.lang.model.Meta
import org.agileware.natural.lang.model.Narrative
import org.agileware.natural.lang.model.NaturalModel
import org.agileware.natural.lang.model.Paragraph
import org.agileware.natural.lang.model.Section
import org.agileware.natural.lang.model.Table
import org.agileware.natural.lang.model.TableCol
import org.agileware.natural.lang.model.TableRow

class NaturalSerializer {

	def String serialize(NaturalModel model) {
		return (model.document === null) ? "\n" : serialize(model.document)
	}

	def String serialize(Document model) '''
		# language: en
		«serialize(model.meta)»
		Document: «model.title»
		«serialize(model.narrative)»
		«FOR s : model.sections»
			«serialize(s)»
		«ENDFOR»
	'''

	def String serialize(Section model) '''
		Section: «model.title»
		«serialize(model.narrative)»
	'''

	def String serialize(Meta model) {
		if(model === null) return ""

		return '''
			«FOR t : model.tags»
				«t.id»
			«ENDFOR»
		'''
	}
	
	def String serialize(Narrative model) {
		if(model === null) return ""
		return '''
			«FOR s : model.sections»
				«serialize(s)»
			«ENDFOR»
		'''
	}
	
	def String serialize(Block model) {
		if(model instanceof Paragraph) {
			return serialize(model as Paragraph)
		} else if(model instanceof Table) {
			return serialize(model as Table)
		} else if(model instanceof DocString) {
			return serialize(model as DocString)
		}
		
		return ""
	}

	def String serialize(Paragraph model) {
		if(model === null) return ""

		return model.value
	}

	def String serialize(Table model) {
		if(model === null) return ""

		return '''
			«FOR r : model.rows»
				«serialize(r)»
			«ENDFOR»
		'''
	}

	def String serialize(TableRow model) '''
		«model.cols.map[serialize].join()» |
	'''

	def String serialize(TableCol model) {
		return model.value
	}

	def String serialize(DocString model) {
		if(model === null) return ""

		return '''
			«model.value»
		'''
	}
}
