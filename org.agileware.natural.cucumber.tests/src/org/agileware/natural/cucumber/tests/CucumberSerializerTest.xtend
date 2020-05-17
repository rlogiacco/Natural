package org.agileware.natural.cucumber.tests

import com.google.inject.Inject
import org.agileware.natural.cucumber.cucumber.CucumberFactory
import org.eclipse.xtext.serializer.ISerializer
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

import static org.agileware.natural.cucumber.tests.CucumberTestHelpers.*
import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.Matchers.*

@RunWith(XtextRunner)
@InjectWith(CucumberInjectorProvider)
class CucumberSerializerTest {

	@Inject CucumberTestHelpers _th

	@Inject extension ISerializer

	@Test
	def void twoWaySerialization() {
		assertThat(
			_th.parse(EXAMPLE_FEATURE).serialize(),
			equalToCompressingWhiteSpace(EXAMPLE_FEATURE)
		)
	}
}
