/*
 * generated by Xtext 2.23.0-SNAPSHOT
 */
package org.agileware.natural.lang.tests

import org.agileware.natural.lang.model.DocumentModel
import org.agileware.natural.testing.AbstractParserTest
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.Matchers.*

@RunWith(XtextRunner)
@InjectWith(NaturalInjectorProvider)
class NaturalParsingTest  extends AbstractParserTest<DocumentModel> {
	
	@Test
	def void helloDocumntModel() {
		
		val model = parse('''
			Section: Hello, Document Model!
		''')

		assertThat(model, notNullValue())
		assertThat(validate(model), empty())
	}
}
