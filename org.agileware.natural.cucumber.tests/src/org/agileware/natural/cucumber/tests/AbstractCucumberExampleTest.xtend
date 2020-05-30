package org.agileware.natural.cucumber.tests

import com.google.inject.Inject
import org.agileware.natural.cucumber.cucumber.Feature
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.runner.RunWith

import static org.hamcrest.CoreMatchers.equalTo
import static org.hamcrest.CoreMatchers.notNullValue
import static org.hamcrest.MatcherAssert.assertThat

@RunWith(XtextRunner) @InjectWith(CucumberInjectorProvider)
abstract class AbstractCucumberExampleTest {
	@Inject public ParseHelper<Feature> parseHelper

	def void assertThatExampleParses(String content) {
		val model = parseHelper.parse(content)
		assertThat(model, notNullValue())
		assertThat(model.eResource.errors, equalTo(#[]))
	}
}
