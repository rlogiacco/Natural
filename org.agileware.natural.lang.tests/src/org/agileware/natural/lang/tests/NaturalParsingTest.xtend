/*
 * generated by Xtext 2.23.0-SNAPSHOT
 */
package org.agileware.natural.lang.tests

import org.agileware.natural.lang.model.DocumentModel
import org.agileware.natural.testing.AbstractExamplesTest
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.Matchers.*

@RunWith(XtextRunner)
@InjectWith(NaturalInjectorProvider)
class NaturalParsingTest extends AbstractExamplesTest<DocumentModel> {

	@Test
	def void singleSectionWithTitle() {

		val model = parse('''
			Section: Hello, Natural!
		''')

		assertThat(model, notNullValue())
		assertThat(validate(model), empty())

		assertThat(model.sections, hasSize(1))
		assertThat(model.sections.get(0).title, equalTo("Hello, Natural!"))
	}

	@Test
	def void singleSectionWithNarrative() {

		val model = parse('''
			Section:
			The quick brown fox
			Jumps over the lazy dog
		''')

		assertThat(model, notNullValue())
		assertThat(validate(model), empty())
		assertThat(model.sections, hasSize(1))

		val s1 = model.sections.get(0)
		assertThat(s1.title, nullValue())
		assertThat(s1.narrative, notNullValue())
		assertThat(s1.narrative.sections, hasSize(1))
	}
}
