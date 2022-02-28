package org.agileware.natural.lang.tests

import org.agileware.natural.lang.model.NaturalModel
import org.agileware.natural.testing.AbstractExamplesTest
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(NaturalInjectorProvider)
class NaturalExamplesTest extends AbstractExamplesTest<NaturalModel> {

	@Test
	def void example_01() {
		assertExampleParses('''
			Document: Hello, Natural!
		''')
	}

	@Test
	def void example_02() {
		assertExampleParses('''
			# language: en
			Document: Hello, Natural!
		''')
	}

	@Test
	def void example_03() {
		assertExampleParses('''
			Document: 
			Section: B 
			  
			Section:
		''')
	}

	@Test
	def void example_04() {
		assertExampleParses('''
			Document: Hello, Natural!
			
			The quick brown fox
			Jumps over the lazy dog
		''')
	}

	@Test
	def void example_05() {
		assertExampleParses('''
			Document: Hello, Natural!
				
				The quick brown fox
				Jumps over the lazy dog
		''')
	}

	@Test
	def void example_06() {
		assertExampleParses('''
			Document:
			The quick brown fox
			
			Jumps over the lazy dog
		''')
	}

	@Test
	def void example_07() {
		assertExampleParses('''
			Document:   Hello, 	Natural! 
			  
			  The quick brown fox  
			  	Jumps over the lazy dog
			  
		''')
	}

	@Test
	def void example_08() {
		assertExampleParses('''
			# language: en  
			  
			Document:   Hello, 	Natural! 
				  
				Section:	A
				  
				  The quick brown fox  
				  
				  	Jumps over the lazy dog
				  
				  
				Section:  B 
				
				  The quick brown fox  
				
				  Jumps over the lazy dog
				  
				Section:	A	B 
				  The quick brown fox  
				  
				  	Jumps over the lazy dog
				  	
		''')
	}

	@Test
	def void example_09() {
		assertExampleParses('''
			# language: en
			@version:1
			Document:   Hello, 	Natural! 
			
			  @foo
			@bar
			Section: A
			
			@foo @bar 
				
			Section: B
		''')
	}

	@Test
	def void example_10() {
		assertExampleParses('''
			Document: Hello, ASCII Punctuation! 
			,./;'[]\-=
			<>?:"{}|_+
			!@$%^&*()`~
		''')
	}
}
