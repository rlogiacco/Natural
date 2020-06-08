package org.agileware.natural.cucumber.tests

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Suite

@RunWith(Suite)
@Suite.SuiteClasses(FeatureExamples, BackgroundExamples, ScenarioExamples, PathologicalExamples)
class CucumberExamplesTest {

	static class FeatureExamples extends AbstractCucumberExampleTest {

		@Test
		def void feature_02() {
			assertThatExampleParses('''
				Feature: Hello, Cucumber!
			''')
		}

		@Test
		def void feature_03() {
			assertThatExampleParses('''
				Feature: Hello, Cucumber!
				The quick brown fox
			''')
		}

		@Test
		def void feature_04() {
			assertThatExampleParses('''
				Feature: Hello, Cucumber!
				
				The quick brown fox
				Jumps over the lazy dog
			''')
		}

		@Test
		def void feature_05() {
			assertThatExampleParses('''
				@foo @bar
				@key:val
				Feature: Hello, Cucumber!
			''')
		}
		
		@Test
		def void feature_06() {
			assertThatExampleParses('''
				# language: sv
				
				Feature: Hello, Cucumber!
			''')
		}

	}

	static class BackgroundExamples extends AbstractCucumberExampleTest {

		@Test
		def void background_01() {
			assertThatExampleParses('''
				Feature: Hello, Cucumber!
				
				Background:
				Given "Jack" went up the hill
			''')
		}

		@Test
		def void background_02() {
			assertThatExampleParses('''
				Feature: Hello, Cucumber!
				
				Background: Jack and Jill
				* a stock of symbol STK1 and a threshold of 10.0
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

	}

	static class ScenarioExamples extends AbstractCucumberExampleTest {

		@Test
		def void scenario_01() {
			assertThatExampleParses('''
				Feature: Hello, Cucumber!
				Scenario:
				* a step
			''')
		}

		@Test
		def void scenario_02() {
			assertThatExampleParses('''
				Feature: Hello, Cucumber!
				
				Scenario: Stock Symbols
				* a stock of symbol STK1 and a threshold of 10.0
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
		def void scenario_03() {
			assertThatExampleParses('''
				Feature: Hello, Cucumber!
				
				@foo @bar
				Scenario:
				* a step
			''')
		}

		@Test
		def void scenario_04() {
			assertThatExampleParses('''
				Feature: Hello, Cucumber!
				
				Scenario: Eating pickles
				Given there are <start> pickles
				When I eat <eat> pickles
				Then I should have <left> pickles
			''')
		}

		@Test
		def void scenario_05() {
			assertThatExampleParses('''
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
		def void scenario_06() {
			assertThatExampleParses('''
				Feature: Hello, Cucumber!
				
				@eating-pickles
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
		def void scenario_07() {
			assertThatExampleParses('''
				Feature: Hello, Cucumber!
				
				@eating-pickles
				Scenario Outline: Eating pickles
				Given there are <start> pickles
				When I eat <eat> pickles
				Then I should have <left> pickles
				
				Examples:
					| start | eat | left |
					|    12 |  10 |    2 |
					|    20 |  15 |    5 |
				
				Examples:
					| start | eat | left |
					|    12 |   2 |   10 |
					|    20 |   5 |   15 |
			''')
		}

		@Test
		def void scenario_08() {
			assertThatExampleParses('''
				Feature: Jack and Jill
				Scenario: Jack falls down
					Given Jack falls down
					"""
					The quick brown fox
					Jumps over the lazy dog
					"""
			''')
		}

		@Test
		def void scenario_09() {
			assertThatExampleParses('''
				Feature: Jack and Jill
				Scenario: Jack falls down
					Given Jack falls down
					"""
					The quick brown fox
					Jumps over the lazy dog
					"""
					Then Jill comes tumbling after
			''')
		}

	}
	
	static class PathologicalExamples extends AbstractCucumberExampleTest {
		
		@Test
		def void pathological_01() {
			assertThatExampleParses('''
				Feature: ASCII punctuation
				,./;'[]\-=
				<>?:"{}|_+
				!@#$%^&*()`~
			''')
		}

		@Test
		def void pathological_02() {
			assertThatExampleParses('''
				Feature: Quotation Marks
				'
				"
				''
				""
				'"'
				"\'\'\'\'"\'"
				"\'"\'"\'\'\'\'"𝅳𝅴𝅵𝅶𝅷𝅸𝅹𝅺󠀁󠀠󠀡󠀢󠀣󠀤󠀥󠀦󠀧󠀨󠀩󠀪󠀫󠀬󠀭󠀮󠀯󠀰󠀱󠀲󠀳󠀴󠀵󠀶󠀷󠀸󠀹󠀺󠀻󠀼󠀽󠀾󠀿󠁀󠁁󠁂󠁃󠁄󠁅󠁆󠁇󠁈󠁉󠁊󠁋󠁌󠁍󠁎󠁏󠁐󠁑󠁒󠁓󠁔󠁕󠁖󠁗󠁘󠁙󠁚󠁛󠁜󠁝󠁞󠁟󠁠󠁡󠁢󠁣󠁤󠁥󠁦󠁧󠁨󠁩󠁪󠁫󠁬󠁭󠁮󠁯󠁰󠁱󠁲󠁳󠁴󠁵󠁶󠁷󠁸󠁹󠁺󠁻󠁼󠁽󠁾󠁿
			''')
		}

		@Test
		def void pathological_03() {
			assertThatExampleParses('''
				Feature: Two-Byte Characters
				田中さんにあげて下さい
				パーティーへ行かないか
				和製漢語
				部落格
				사회과학원 어학연구소
				찦차를 타고 온 펲시맨과 쑛다리 똠방각하
				社會科學院語學研究所
				울란바토르
				𠜎𠜱𠝹𠱓𠱸𠲖𠳏𝅳𝅴𝅵𝅶𝅷𝅸𝅹𝅺󠀁󠀠󠀡󠀢󠀣󠀤󠀥󠀦󠀧󠀨󠀩󠀪󠀫󠀬󠀭󠀮󠀯󠀰󠀱󠀲󠀳󠀴󠀵󠀶󠀷󠀸󠀹󠀺󠀻󠀼󠀽󠀾󠀿󠁀󠁁󠁂󠁃󠁄󠁅󠁆󠁇󠁈󠁉󠁊󠁋󠁌󠁍󠁎󠁏󠁐󠁑󠁒󠁓󠁔󠁕󠁖󠁗󠁘󠁙󠁚󠁛󠁜󠁝󠁞󠁟󠁠󠁡󠁢󠁣󠁤󠁥󠁦󠁧󠁨󠁩󠁪󠁫󠁬󠁭󠁮󠁯󠁰󠁱󠁲󠁳󠁴󠁵󠁶󠁷󠁸󠁹󠁺󠁻󠁼󠁽󠁾󠁿
			''')
		}
	}
}
