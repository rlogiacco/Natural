package org.agileware.natural.jbehave.tests

import com.google.inject.Inject
import java.util.List
import org.agileware.natural.jbehave.jbehave.Story
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.eclipse.xtext.validation.Issue

import static org.hamcrest.MatcherAssert.assertThat
import static org.hamcrest.Matchers.*

@InjectWith(JbehaveInjectorProvider)
class JbehaveTestHelpers {
	@Inject public ParseHelper<Story> parseHelper
	@Inject public ValidationTestHelper validationTestHelper

	def Story parse(CharSequence content) {
		return parseHelper.parse(content)
	}

	def List<Issue> validate(String contet) {
		val model = parseHelper.parse(contet)
		assertThat(model, notNullValue())

		return validationTestHelper.validate(model)
	}
}
