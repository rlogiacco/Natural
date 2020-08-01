package org.agileware.natural.jbehave.ui.tests

import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.testing.AbstractHighlightingTest
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(JbehaveUiInjectorProvider)
class JbehaveHighlightingTest extends AbstractHighlightingTest {
	@Test
	def void helloHighlighting() {
		// TODO...
	}
}
