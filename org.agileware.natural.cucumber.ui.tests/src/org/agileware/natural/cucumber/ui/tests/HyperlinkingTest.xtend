package org.agileware.natural.cucumber.ui.tests

import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.testing.AbstractHyperlinkingTest
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(CucumberUiInjectorProvider)
class HyperlinkingTest extends AbstractHyperlinkingTest {

	@Before
	def void setup() {
		// TODO setup example project...
	}
	
	@Test 
	def helloHyperlinking() {
		'''
		Feature: Hello, Hyperlinking!
		
		Scenario: Jack and Jill
		  Given Jack and Jill went up a hill
		'''.hasHyperlinkTo("org.agileware.natural.example.cucumber.stepdefs.JackAndJill")
	}

}
