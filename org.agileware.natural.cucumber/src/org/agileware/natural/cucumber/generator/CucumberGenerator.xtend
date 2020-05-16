/*******************************************************************************
 * Copyright (c) 2011, 2018 itemis AG (http://www.itemis.eu) and others.
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 * 
 * SPDX-License-Identifier: EPL-2.0
 *******************************************************************************/
package org.agileware.natural.cucumber.generator

import com.google.inject.Inject
import org.agileware.natural.cucumber.cucumber.Feature
import org.agileware.natural.cucumber.cucumber.Scenario
import org.agileware.natural.cucumber.cucumber.ScenarioOutline
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.GrammarToDot
import org.eclipse.xtext.IGrammarAccess
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class CucumberGenerator extends AbstractGenerator {

	@Inject extension IGrammarAccess

	@Inject extension GrammarToDot

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		fsa.generateFile(resource.getURI().toString(), toCucumberCode(resource.contents.head as Feature))
		fsa.generateFile("Cucumber.dot", toDotCode())
	}

	protected def String toDotCode() {
		return grammar.draw
	}

	protected def toCucumberCode(Feature feature) '''
		«FOR tag : feature.tags»
			«tag.id»
		«ENDFOR»
		Feature: «feature.title»
		«feature.narrative»
		
		«IF feature.background !== null»
			Background: «feature.background.title»
				«feature.background.narrative»
			
				«FOR step : feature.background.steps»
					«step.keyword» «step.description»
				«ENDFOR»
		«ENDIF»
		«FOR scenario : feature.scenarios»
			
					«FOR tag : scenario.tags»
						«tag.id»
					«ENDFOR»
					«IF scenario instanceof Scenario»
						Scenario: «scenario.title»
					«ELSEIF scenario instanceof ScenarioOutline»
						Scenario Outline: «scenario.title»
					«ENDIF»
					«scenario.narrative»
			
				«FOR step : scenario.steps»
					«step.keyword» «step.description»
				«ENDFOR»
		«ENDFOR»
		
	'''
}
