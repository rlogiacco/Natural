package org.agileware.natural.cucumber.ui.tests

import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.testing.AbstractHighlightingTest
import org.junit.Test
import org.junit.runner.RunWith
import org.agileware.natural.cucumber.ui.syntaxcoloring.HighlightingConfiguration
import com.google.inject.Inject

@RunWith(XtextRunner)
@InjectWith(CucumberUiInjectorProvider)
class CucumberHighlightingTest extends AbstractHighlightingTest {
	
	@Inject extension HighlightingConfiguration
	
	@Test
	def void featureKeyword() {
		'''
			Feature:
		'''.testHighlighting("Feature:", keywordTextStyle)
	}
	
	@Test
	def void backgroundKeyword() {
		'''
			Feature:
			Background:
		'''.testHighlighting("Background:", keywordTextStyle)
	}
	
	@Test
	def void scenarioKeyword() {
		'''
			Feature:
			Scenario:
		'''.testHighlighting("Scenario:", keywordTextStyle)
	}
	
	@Test
	def void scenarioOutlineKeyword() {
		'''
			Feature:
			Scenario Outline:
		'''.testHighlighting("Scenario Outline:", keywordTextStyle)
	}
	
	@Test
	def void examplesKeyword() {
		'''
			Feature:
			Scenario Outline:
			Examples:
			| foo |
		'''.testHighlighting("Examples:", keywordTextStyle)
	}
	
	@Test
	def void givenStepKeyword() {
		'''
			Feature:
			Scenario:
			Given foo
		'''.testHighlighting("Given", keywordTextStyle)
	}
	
	@Test
	def void whenStepKeyword() {
		'''
			Feature:
			Scenario:
			When foo
		'''.testHighlighting("When", keywordTextStyle)
	}
	
	@Test
	def void thenStepKeyword() {
		'''
			Feature:
			Scenario:
			Then foo
		'''.testHighlighting("Then", keywordTextStyle)
	}
	
	@Test
	def void andStepKeyword() {
		'''
			Feature:
			Scenario:
			And foo
		'''.testHighlighting("And", keywordTextStyle)
	}
	
	@Test
	def void butStepKeyword() {
		'''
			Feature:
			Scenario:
			But foo
		'''.testHighlighting("But", keywordTextStyle)
	}
	
	@Test
	def void anyStepKeyword() {
		'''
			Feature:
			Scenario:
			* foo
		'''.testHighlighting("*", keywordTextStyle)
	}
	
	@Test
	def void docString_01() {
		'''
			Feature:
			"""
			The quick brown fox
			Jumps pver the lazy dog
			"""
		'''.testHighlighting('''
			"""
			The quick brown fox
			Jumps pver the lazy dog
			"""
		''', docStringTextStyle)
	}
	
	@Test
	def void docString_02() {
		'''
			Feature:
			Scenario:
			Given foo
			"""
			The quick brown fox
			Jumps pver the lazy dog
			"""
		'''.testHighlighting('''
			"""
			The quick brown fox
			Jumps pver the lazy dog
			"""
		''', docStringTextStyle)
	}
	
	@Test
	def void table_01() {
		'''
			Feature:
			| x | 0 |
			| y | 1 |
		'''.testHighlighting('''
			| x | 0 |
			| y | 1 |
		''', tableTextStyle)
	}
	
	@Test
	def void table_02() {
		'''
			Feature:
			Scenario:
			Given foo
			| x | 0 |
			| y | 1 |
		'''.testHighlighting('''
			| x | 0 |
			| y | 1 |
		''', docStringTextStyle)
	}
	
	@Test
	def void table_03() {
		'''
			Feature:
			Scenario Outline:
			Given <x> and <y>
			Examples:
			| x | 0 |
			| y | 1 |
		'''.testHighlighting('''
			| x | 0 |
			| y | 1 |
		''', docStringTextStyle)
	}
	
	@Test
	def void comment_01() {
		'''
			# language: en
			Feature:
		'''.testHighlighting("# language: en", commentTextStyle)
	}
	
	@Test
	def void comment_02() {
		'''
			Feature: #Foo
		'''.testHighlighting("#Foo", commentTextStyle)
	}
	
	@Test
	def void string_01() {
		'''
			Feature:
			Scenario:
			Given "foo"
		'''.testHighlighting("\"foo\"", stringTextStyle)
	}
	
	@Test
	def void string_02() {
		'''
			Feature:
			Scenario:
			Given ullamcorper "pretium ut eu" neque.
		'''.testHighlighting("\"pretium ut eu\"", stringTextStyle)
	}
	
	@Test
	def void string_03() {
		'''
			Feature:
			Scenario:
			Given 'foo'
		'''.testHighlighting("'foo'", stringTextStyle)
	}
	
	@Test
	def void string_04() {
		'''
			Feature:
			Scenario:
			Given ullamcorper 'pretium ut eu' neque.
		'''.testHighlighting("'pretium ut eu'", stringTextStyle)
	}
	
		
	@Test
	def void number_01() {
		'''
			Feature:
			Scenario:
			Given 0
		'''.testHighlighting("0", numberTextStyle)
	}
		
	@Test
	def void number_02() {
		'''
			Feature:
			Scenario:
			Given 1
		'''.testHighlighting("1", numberTextStyle)
	}
		
	@Test
	def void number_03() {
		'''
			Feature:
			Scenario:
			Given -1
		'''.testHighlighting("-1", numberTextStyle)
	}
	
			
	@Test
	def void number_04() {
		'''
			Feature:
			Scenario:
			Given 1.0
		'''.testHighlighting("1.0", numberTextStyle)
	}
			
	@Test
	def void number_05() {
		'''
			Feature:
			Scenario:
			Given -1.0
		'''.testHighlighting("-1.0", numberTextStyle)
	}
			
	@Test
	def void number_06() {
		'''
			Feature:
			Scenario:
			Given 3.30e23
		'''.testHighlighting("3.30e23", numberTextStyle)
	}
			
	@Test
	def void number_07() {
		'''
			Feature:
			Scenario:
			Given 6.67E-11
		'''.testHighlighting("6.67E-11", numberTextStyle)
	}
			
	@Test
	def void number_08() {
		'''
			Feature:
			Scenario:
			Given -3.30e23
		'''.testHighlighting("-3.30e23", numberTextStyle)
	}
			
	@Test
	def void number_09() {
		'''
			Feature:
			Scenario:
			Given 0xFFFFFF
		'''.testHighlighting("0xFFFFFF", numberTextStyle)
	}

	@Test
	def void number_10() {
		'''
			Feature:
			Scenario:
			Given -0xFFFFFF
		'''.testHighlighting("-0xFFFFFF", numberTextStyle)
	}
			
	@Test
	def void number_11() {
		'''
			Feature:
			Scenario:
			Given 1.0.0
		'''.testHighlighting("1.0.0", defaultTextStyle)
	}
}
