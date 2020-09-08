package org.agileware.natural.lang.tests

import org.agileware.natural.lang.model.NaturalModel
import org.agileware.natural.testing.AbstractFormatterTest
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith
import org.eclipse.xtext.formatting2.FormatterPreferenceKeys

@RunWith(XtextRunner)
@InjectWith(NaturalInjectorProvider)
class NaturalFormatterTest extends AbstractFormatterTest<NaturalModel> {

	@Test
	def void cleanupTitleText() {
		val toBeFormatted = '''
			# language: en
			Document: 	Hello,	Natural Formatter !  
				
				Section:	A	
				
				Section:	
				The quick brown fox
				Jumps over the lazy dog
		'''
		val expectation = '''
			# language: en
			Document: Hello,	Natural Formatter !
				
				Section: A
				
				Section:
					The quick brown fox
					Jumps over the lazy dog
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void indentNarrative_01() {
		val toBeFormatted = '''
			# language: en
			Document:
				
				The quick brown fox
				Jumps over the lazy dog
		'''
		assertFormatted(toBeFormatted)
	}

	@Test
	def void indentNarrative_02() {
		val toBeFormatted = '''
			# language: en
			Document:
			
			The quick brown fox
			Jumps over the lazy dog
		'''
		val expectation = '''
			# language: en
			Document:
				
				The quick brown fox
				Jumps over the lazy dog
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void indentNarrative_03() {
		val toBeFormatted = '''
			# language: en
			Document:
				
				* 1
					* 1.1
					* 1.2
				* 2
					* 2.1
		'''
		assertFormatted(toBeFormatted)
	}

	@Test
	def void indentNarrative_04() {
		val toBeFormatted = '''
			# language: en
			Document:
			
			* 1
				* 1.1
				* 1.2
			* 2
				* 2.1
		'''
		val expectation = '''
			# language: en
			Document:
				
				* 1
					* 1.1
					* 1.2
				* 2
					* 2.1
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void indentNarrative_05() {
		val toBeFormatted = '''
			# language: en
			Document:
			
			1)
				* 1.1
				* 1.2
			
				2)
					* 2.1
					* 2.2
			
					3)
						* 3.1
						* 3.2
		'''
		val expectation = '''
			# language: en
			Document:
				
				1)
					* 1.1
					* 1.2
			
				2)
					* 2.1
					* 2.2
			
				3)
					* 3.1
					* 3.2
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void indentNarrative_06() {
		val toBeFormatted = '''
			# language: en
			Document:
			
			The quick brown fox
			Jumps over the lazy dog
			
			| a | 0 |
			| b | 1 |
			
			"""
				,./;'[]\-=
				<>?:"{}|_+
				!@#$%^&*()`~
			"""
		'''
		val expectation = '''
			# language: en
			Document:
				
				The quick brown fox
				Jumps over the lazy dog
			
				| a | 0 |
				| b | 1 |
			
				"""
					,./;'[]\-=
					<>?:"{}|_+
					!@#$%^&*()`~
				"""
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void indentSections_01() {
		val toBeFormatted = '''
			# language: en
			Document:
				
				The quick brown fox
				Jumps over the lazy dog
				
				Section:
					The quick brown fox
				
				Section:
					Jumps over the lazy dog
		'''
		assertFormatted(toBeFormatted)
	}

	@Test
	def void indentSections_02() {
		val toBeFormatted = '''
			# language: en
			Document:
			
			The quick brown fox
			Jumps over the lazy dog
			
			Section:
			The quick brown fox
			
			Section:
			Jumps over the lazy dog
		'''
		val expectation = '''
			# language: en
			Document:
				
				The quick brown fox
				Jumps over the lazy dog
			
				Section:
					The quick brown fox
			
				Section:
					Jumps over the lazy dog
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void indentSections_03() {
		val toBeFormatted = '''
			# language: en
			Document:
			
			@foo
			Section: A
			
			@foo
			@bar
			Section: B
			The quick brown fox
			Jumps over the lazy dog
		'''
		val expectation = '''
			# language: en
			Document:
				
				@foo
				Section: A
				
				@foo
				@bar
				Section: B
					The quick brown fox
					Jumps over the lazy dog
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void adjustBlockSpacing_01() {
		val toBeFormatted = '''
			# language: en
			Document:
				The quick brown fox
				Jumps over the lazy dog
				Section:
					The quick brown fox
			
				Section:
					Jumps over the lazy dog
		'''
		val expectation = '''
			# language: en
			Document:
			
				The quick brown fox
				Jumps over the lazy dog
			
				Section:
					The quick brown fox
			
				Section:
					Jumps over the lazy dog
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void adjustBlockSpacing_02() {
		val toBeFormatted = '''
			# language: en
			Document:
			
			
			
			The quick brown fox
			Jumps over the lazy dog
			
			
			
			
			Section:
			
			
			The quick brown fox
			
			Section:
			
			
			
			Jumps over the lazy dog
		'''
		val expectation = '''
			# language: en
			Document:
				
				The quick brown fox
				Jumps over the lazy dog
			
				Section:
					
					The quick brown fox
			
				Section:
					
					Jumps over the lazy dog
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void cleanupMetaTags_01() {
		val toBeFormatted = '''
			# language: en
			@foo	@bar  
				
				@foobar 
			Document:
		'''
		val expectation = '''
			# language: en
			@foo
			@bar
			@foobar
			Document:
		'''
		assertFormatted(toBeFormatted, expectation)
	}

	@Test
	def void cleanupMetaTags_02() {
		val toBeFormatted = '''
			# language: en
			Document:
				
				@foo  @bar	
					
			@foobar
				Section:
					The quick brown fox
		'''
		val expectation = '''
			# language: en
			Document:
				
				@foo
				@bar
				@foobar
				Section:
					The quick brown fox
		'''
		assertFormatted(toBeFormatted, expectation)
	}

//	TODO add support for user indentation preferences
//	@Test
//	def void indentWithSpaces_01() {
//		formatterTestHelper.assertFormatted[
//			preferences[ put(FormatterPreferenceKeys.indentation, "  ") ]
//			toBeFormatted = '''
//				# language: en
//				Document:
//				
//				The quick brown fox
//				Jumps over the lazy dog
//			'''
//			expectation = '''
//				# language: en
//				Document:
//				  
//				  The quick brown fox
//				  Jumps over the lazy dog
//			'''
//		]
//	}
}
