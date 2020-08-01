package org.agileware.natural.jbehave.tests

import com.google.inject.Inject
import org.agileware.natural.jbehave.jbehave.Story
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.runner.RunWith

import static org.hamcrest.CoreMatchers.*
import static org.hamcrest.MatcherAssert.assertThat

@RunWith(XtextRunner)
@InjectWith(JbehaveInjectorProvider)
abstract class AbstractExampleTest {
	
	@Inject public ParseHelper<Story> parseHelper
	
	def void assertThatExampleParses(String content) {
		val model = parseHelper.parse(content)
		assertThat(model, notNullValue())
		assertThat(model.eResource.errors, equalTo(#[]))
	}
}