package org.agileware.natural.cucumber.ui.tests

import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.testing.AbstractHighlightingTest
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(CucumberUiInjectorProvider)
class CucumberHighlightingTest extends AbstractHighlightingTest {
	@Test
	def void helloHighlighting() {
		// TODO...
	}
}
