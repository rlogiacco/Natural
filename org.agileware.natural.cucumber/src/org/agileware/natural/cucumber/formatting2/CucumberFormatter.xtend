/*
 * generated by Xtext
 */
package org.agileware.natural.cucumber.formatting2

import com.google.inject.Inject
import org.agileware.natural.cucumber.cucumber.Background
import org.agileware.natural.cucumber.cucumber.DocString
import org.agileware.natural.cucumber.cucumber.Examples
import org.agileware.natural.cucumber.cucumber.Feature
import org.agileware.natural.cucumber.cucumber.Scenario
import org.agileware.natural.cucumber.cucumber.ScenarioOutline
import org.agileware.natural.cucumber.cucumber.Step
import org.agileware.natural.cucumber.cucumber.Table
import org.agileware.natural.cucumber.cucumber.Tag
import org.agileware.natural.cucumber.services.CucumberGrammarAccess
import org.eclipse.xtext.formatting2.AbstractFormatter2
import org.eclipse.xtext.formatting2.IFormattableDocument
import org.eclipse.xtext.formatting2.regionaccess.ISemanticRegion

import static org.agileware.natural.cucumber.cucumber.CucumberPackage.Literals.*

class CucumberFormatter extends AbstractFormatter2 {

	@Inject extension CucumberGrammarAccess

	def dispatch void format(Feature feature, extension IFormattableDocument document) {
		// format top-level tags
		for (tag : feature.tags) {
			tag.format
		}

		// format background
		feature.background.format

		// format scenarios
		for (eObject : feature.scenarios) {
			eObject.format
		}

		// format narrative
		formatNarrative(feature.regionFor.feature(FEATURE__NARRATIVE))
	}

	def dispatch void format(Background background, extension IFormattableDocument document) {
		// format steps
		for (step : background.steps) {
			step.format
		}

		// format narrative
		formatNarrative(background.regionFor.feature(BACKGROUND__NARRATIVE))
	}

	def dispatch void format(Scenario scenario, extension IFormattableDocument document) {

		// format scenario tags
		for (tag : scenario.tags) {
			tag.format
		}

		// format steps
		for (step : scenario.steps) {
			step.format
		}

		// format narrative
		formatNarrative(scenario.regionFor.feature(SCENARIO__NARRATIVE))
	}

	def dispatch void format(ScenarioOutline scenarioOutline, extension IFormattableDocument document) {

		// format scenario tags
		for (tag : scenarioOutline.tags) {
			tag.format
		}

		// format steps
		for (step : scenarioOutline.steps) {
			step.format
		}

		// format examples
		scenarioOutline.examples.format

		// format narrative
		formatNarrative(scenarioOutline.regionFor.feature(SCENARIO__NARRATIVE))
	}

	def dispatch void format(Examples examples, extension IFormattableDocument document) {
		// format table
		examples.table.format

		// format narrative
		formatNarrative(examples.regionFor.feature(EXAMPLES__NARRATIVE))
	}

	def dispatch void format(Step step, extension IFormattableDocument document) {
		// format tables
		for (tables : step.tables) {
			tables.format
		}
	}

	def dispatch void format(Table table, extension IFormattableDocument document) {
		// TODO tables could in theory be formatted with a slightly different AST
	}

	def dispatch void format(DocString docString, extension IFormattableDocument document) {
		// TODO ...
	}

	def dispatch void format(Tag tag, extension IFormattableDocument document) {
		// TODO ...
	}

	def void formatNarrative(ISemanticRegion narrative) {
		// TODO cleanup indentation
		// narrative.prepend[indent]
	}
}
