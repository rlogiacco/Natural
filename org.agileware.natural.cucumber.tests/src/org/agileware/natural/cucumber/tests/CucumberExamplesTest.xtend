package org.agileware.natural.cucumber.tests

import org.agileware.natural.cucumber.cucumber.CucumberModel
import org.agileware.natural.testing.AbstractExamplesTest
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(CucumberInjectorProvider)
class CucumberExamplesTest extends AbstractExamplesTest<CucumberModel> {

	@Test
	def void background_01() {
		assertExampleParses('''
			# language: en
			Feature: Hello, Cucumber!
			
			Background: Foo
			Given "Jack" went up the hill
			
			Scenario:
			Given a step
		''')
	}

	@Test
	def void background_02() {
		assertExampleParses('''
			# language: en
			Feature: Hello, Cucumber!
			
			@foo @bar
			Background: Jack and Jill
			The quick brown fox
			Jumps over the lazy dog
			
			Given the stock is traded at 5.0
			"""
			The quick brown fox
			Jumps over the lazy dog
			"""
			And the alert status should be OFF
			When the stock is traded at 11.0
			| precondition | be-captured     |
			| abc          | be captured     |
			| xyz          | not be captured |
			Then the alert status should be ON
				
			Scenario:
			Given a step
		''')
	}

	@Test
	def void scenario_01() {
		assertExampleParses('''
			# language: en
			Feature: Hello, Cucumber!
			Scenario: A
			Given a step
		''')
	}

	@Test
	def void scenario_02() {
		assertExampleParses('''
			# language: en
			Feature: Hello, Cucumber!
			The quick brown fox
			Jumps over the lazy dog
			
			Scenario:
				The quick brown fox
				Jumps over the lazy dog
			
				Given a step
			
			Scenario: B
				And another
		''')
	}

	@Test
	def void scenario_03() {
		assertExampleParses('''
			# language: en
			Feature: Hello, Cucumber!
			
			@foo @bar
			Scenario: Stock Symbols
				The quick brown fox
				Jumps over the lazy dog
							
				Given the stock is traded at 5.0
				"""
				The quick brown fox
				Jumps over the lazy dog
				"""
				And the alert status should be OFF
				When the stock is traded at 11.0
				| precondition | be-captured     |
				| abc          | be captured     |
				| xyz          | not be captured |
				Then the alert status should be ON
		''')
	}

	@Test
	def void scenario_outline_01() {
		assertExampleParses('''
			# language: en
			Feature: Hello, Cucumber!
			
			Scenario Outline: Eating pickles
			Given there are <start> pickles
			When I eat <eat> pickles
			Then I should have <left> pickles
			
			Examples:
				| start | eat | left |
				|    12 |  10 |    2 |
				|    20 |  15 |    5 |
		''')
	}

	@Test
	def void scenario_outline_02() {
		assertExampleParses('''
			# language: en
			Feature: Hello, Cucumber!
			
			@eating-pickles
			Scenario Outline: Eating pickles
				Given there are <start> pickles
				When I eat <eat> pickles
				Then I should have <left> pickles
			
				@foo
				Examples: A
				| start | eat | left |
				|    12 |  10 |    2 |
				
				@bar
				Examples: B
				| start | eat | left |
				|    20 |  15 |    5 |
		''')
	}

	@Test
	def void pathological_01() {
		assertExampleParses('''
			# language: en
			Feature: ASCII punctuation
			# ,./;'[]\-=
			# <>?:"{}|_+
			# !@#$%^&*()`~
			
			Scenario:
			Given a step
		''')
	}

	@Test
	def void pathological_02() {
		assertExampleParses('''
			# language: en
			Feature: Two-Byte Characters
			田中さんにあげて下さい
			パーティーへ行かないか
			和製漢語
			部落格
			사회과학원 어학연구소
			찦차를 타고 온 펲시맨과 쑛다리 똠방각하
			社會科學院語學研究所
			울란바토르
			𠜎𠜱𠝹𠱓𠱸𠲖𠳏
			
			Scenario:
			Given a step𝅳𝅴𝅵𝅶𝅷𝅸𝅹𝅺󠀁󠀠󠀡󠀢󠀣󠀤󠀥󠀦󠀧󠀨󠀩󠀪󠀫󠀬󠀭󠀮󠀯󠀰󠀱󠀲󠀳󠀴󠀵󠀶󠀷󠀸󠀹󠀺󠀻󠀼󠀽󠀾󠀿󠁀󠁁󠁂󠁃󠁄󠁅󠁆󠁇󠁈󠁉󠁊󠁋󠁌󠁍󠁎󠁏󠁐󠁑󠁒󠁓󠁔󠁕󠁖󠁗󠁘󠁙󠁚󠁛󠁜󠁝󠁞󠁟󠁠󠁡󠁢󠁣󠁤󠁥󠁦󠁧󠁨󠁩󠁪󠁫󠁬󠁭󠁮󠁯󠁰󠁱󠁲󠁳󠁴󠁵󠁶󠁷󠁸󠁹󠁺󠁻󠁼󠁽󠁾󠁿
		''')
	}

	@Test
	def void pathological_03() {
		assertExampleParses('''
			# language: en
		''')
	}

	@Test
	def void pathological_04() {
		assertExampleParses('''
			# language: en
			Feature: Hello, World!
		''')
	}

	@Test
	def void pathological_05() {
		assertExampleParses('''
			# language: en
			Feature:
			Background:
			Scenario: A
			Scenario: B
		''')
	}
}
