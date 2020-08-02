package org.agileware.natural.cucumber.tests

import org.agileware.natural.cucumber.model.Feature
import org.agileware.natural.testing.AbstractExamplesTest
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(CucumberInjectorProvider)
class CucumberExamplesTest extends AbstractExamplesTest<Feature> {}
