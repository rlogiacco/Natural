package org.agileware.natural.lang.formatting2

import com.google.inject.Inject
import java.util.List
import org.agileware.natural.lang.model.Meta
import org.agileware.natural.lang.model.MetaElement
import org.agileware.natural.lang.services.NaturalGrammarAccess
import org.agileware.natural.lang.text.TextLine
import org.agileware.natural.lang.text.TextModel
import org.apache.commons.lang.StringUtils
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor
import org.eclipse.xtext.Assignment
import org.eclipse.xtext.RuleCall
import org.eclipse.xtext.formatting.IIndentationInformation
import org.eclipse.xtext.formatting2.FormatterPreferenceKeys
import org.eclipse.xtext.formatting2.FormatterRequest
import org.eclipse.xtext.formatting2.IFormattableDocument
import org.eclipse.xtext.formatting2.ITextReplacer
import org.eclipse.xtext.formatting2.ITextReplacerContext
import org.eclipse.xtext.formatting2.regionaccess.ISemanticRegion
import org.eclipse.xtext.formatting2.regionaccess.ITextRegionAccess
import org.eclipse.xtext.formatting2.regionaccess.ITextRegionExtensions
import org.eclipse.xtext.formatting2.regionaccess.ITextSegment
import org.eclipse.xtext.formatting2.regionaccess.internal.NodeSemanticRegion
import org.eclipse.xtext.nodemodel.util.NodeModelUtils
import org.eclipse.xtext.preferences.MapBasedPreferenceValues

@FinalFieldsConstructor
class NaturalFormatHelper {

	static class Factory {
		@Inject IIndentationInformation indentationInformation

		def NaturalFormatHelper create(ITextRegionAccess regionAccess, NaturalGrammarAccess grammerAccess) {
			new NaturalFormatHelper(this, regionAccess.extensions, grammerAccess)
		}
	}

	val Factory factory

	val extension ITextRegionExtensions

	val extension NaturalGrammarAccess

	var int _indentationLevel = 0

	def int getIndentationLevel() {
		return _indentationLevel
	}

	def void resetIndentation() {
		_indentationLevel = 0
	}

	def void increaseIndent() {
		_indentationLevel += 1
	}

	def void decreaseIndent() {
		_indentationLevel -= 1
	}

	def void initialize(FormatterRequest request) {
		val preferences = request.preferences
		if (preferences instanceof MapBasedPreferenceValues) {
			preferences.put(FormatterPreferenceKeys.indentation, factory.indentationInformation.indentString)
		}

		_indentationLevel = 0
	}

	def void formatMultilineText(EObject owner, Assignment assignment, int indentationLevel,
		extension IFormattableDocument doc) {
		val region = owner.regionFor.assignment(assignment)
		if (region instanceof NodeSemanticRegion) {
			addReplacer(new MultilineTextReplacer(region, indentationLevel))
		}
	}

	def void trimBlankSpace(EObject owner, RuleCall rule, extension IFormattableDocument doc) {
		trimBlankSpace(owner, rule, 0, doc)
	}

	def void trimBlankSpace(EObject owner, RuleCall rule, int newLines, extension IFormattableDocument doc) {
		val region = owner.regionFor.ruleCall(rule)
		if (region instanceof NodeSemanticRegion) {
			addReplacer(new BlankSpaceReplacer(region, newLines))
		}
	}

	def void indentBlock(ISemanticRegion start, ISemanticRegion end, extension IFormattableDocument doc) {
		//	println('''
		//		========= Indent Block («indentationLevel») ========= 
		//		start=[«start.offset», «start.length»] «start.grammarElement»
		//		end=[«end.offset», «end.length»] «end.grammarElement»
		//	''')
		interior(start, end)[indent]
	}

	def boolean hasLeadingBlankSpace(EObject model) {
		immediatelyPreceding(model).ruleCallTo(BLANK_SPACERule) !== null
	}

	def boolean hasTrailingBlankSpace(EObject model) {
		immediatelyFollowing(model).ruleCallTo(BLANK_SPACERule) !== null
	}

	def trimBlankSpace(ISemanticRegion region, int newLines, extension IFormattableDocument doc) {
		if (region instanceof NodeSemanticRegion) {
			addReplacer(new BlankSpaceReplacer(region, newLines))
		}
	}

	def dispatch boolean isLast(MetaElement model) {
		val meta = model.eContainer as Meta
		model == meta.tags.last
	}
}

@FinalFieldsConstructor
public class BlankSpaceReplacer implements ITextReplacer {
	val NodeSemanticRegion region

	val int newLines

	override ITextSegment getRegion() {
		region
	}

	override createReplacements(ITextReplacerContext context) {
		val newText = (newLines === 0) ? "" : StringUtils.repeat(System.lineSeparator, newLines)

		context.addReplacement(region.replaceWith(newText))

		return context
	}
}

@FinalFieldsConstructor
class MultilineTextReplacer implements ITextReplacer {

	static def indentToRemove(List<TextLine> lines, int originalStartColumn) {
		var count = lines.length - 1
		if (count < 1) {
			return 0
		}

		val (TextLine)=>Integer countLeadingWS = [leadingWhiteSpace.length()]
		val minCountLeadingWS = lines.tail.take(count).map[countLeadingWS.apply(it)].min

		return Math.min(minCountLeadingWS, originalStartColumn)
	}

	val NodeSemanticRegion region

	val int indentationLevel

	override ITextSegment getRegion() {
		region
	}

	override createReplacements(ITextReplacerContext context) {
		val indentationString = context.getIndentationString(1)
		val originalStartColumn = NodeModelUtils.getLineAndColumn(region.node, region.offset).column

		val model = TextModel.build(region.text)
		if (model.lines.size > 1) {
			val indentToRemove = indentToRemove(model.lines, originalStartColumn)
			// println('''======= Processng Text Indentation (indentationLevel: «indentationLevel», originalStartColumn: «originalStartColumn», indentToRemove: «indentToRemove») =======''')
			context.addReplacement(
				region.replaceWith(
					toIndentedString(model.lines, indentationString, indentationLevel, originalStartColumn,
						indentToRemove)))
		}

		return context
	}

	def String toIndentedString(List<TextLine> lines, String indentationString, int indentationLevel,
		int originalStartColumn, int indentToRemove) {
		val result = new StringBuilder()
		val length = lines.size()

		for (var i = 0; i < length; i++) {
			val line = lines.get(i)
			// println('''[offset: «line.relativeOffset», length: «line.length», leadingWhiteSpace: «line.leadingWhiteSpace.length»] «line»''')
			val toColumn = indentationLevel + 1
			if (i == 0) {
				// append first line as is (will be indented by formatter rules)
				result.append(line)
			} else {
				if (originalStartColumn < toColumn) {
					// increase indent
					val indentIncrease = StringUtils.repeat(indentationString, toColumn - originalStartColumn)
					result.append(indentIncrease).append(line)
				} else if (originalStartColumn > toColumn) {
					// decrease indent
					val leadingWs = line.leadingWhiteSpace.toString()
					val newIndent = StringUtils.replace(leadingWs, indentationString, "",
						originalStartColumn - toColumn)
					result.append(newIndent).append(line.semanticText)
				} else {
					// no adjustment needed
					result.append(line)
				}
			}

			if (i < length - 1) {
				result.append(System.lineSeparator());
			}
		}

		return result.toString();
	}
}
