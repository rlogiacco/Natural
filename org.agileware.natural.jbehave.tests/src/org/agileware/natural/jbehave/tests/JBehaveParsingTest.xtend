/*
 * generated by Xtext
 */
package org.agileware.natural.jbehave.tests

import com.google.inject.Inject
import org.agileware.natural.jbehave.jbehave.Story
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(JBehaveInjectorProvider)
class JBehaveParsingTest {
	@Inject
	ParseHelper<Story> parseHelper
	
	@Test
	def void loadModel() {
		val result = parseHelper.parse('''
			Hello Xtext!
		''')
		Assert.assertNotNull(result)
		val errors = result.eResource.errors
		Assert.assertTrue('''Unexpected errors: «errors.join(", ")»''', errors.isEmpty)
	}
}