package org.agileware.natural.lang.tests

import org.agileware.natural.lang.model.NaturalDocument
import org.agileware.natural.testing.AbstractExamplesTest
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(NaturalInjectorProvider)
class NaturalExamplesTest extends AbstractExamplesTest<NaturalDocument> {

	@Test
	def void example_01() {
		assertExampleParses('''
			Section: Hello, Natural!
		''')
	}

	@Test
	def void example_02() {
		assertExampleParses('''
			# language: en
			
			Section: Hello, Natural!
		''')
	}

	@Test
	def void example_03() {
		assertExampleParses('''
			Section: A
			Section: B
			
			Section:
		''')
	}

	@Test
	def void example_04() {
		assertExampleParses('''
			Section: Hello, Natural!
			
			The quick brown fox
			Jumps over the lazy dog
		''')
	}

	@Test
	def void example_05() {
		assertExampleParses('''
			Section: Hello, Natural!
			
				The quick brown fox
				Jumps over the lazy dog
		''')
	}

	@Test
	def void example_06() {
		assertExampleParses('''
			Section:
			The quick brown fox
			
			Jumps over the lazy dog
		''')
	}

	@Test
	def void example_07() {
		assertExampleParses('''
			Section:   Hello, 	Natural! 
			  
			  The quick brown fox  
			  	Jumps over the lazy dog
			  
		''')
	}

	@Test
	def void example_08() {
		assertExampleParses('''
			# language: en  
			  
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
			@title: Hello, Meta Tags!
			
			Section: A
			
			@foo
			@bar
			Section: B
			
			@foo @bar
			
			Section: C
		''')
	}
}
