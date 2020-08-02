package org.agileware.natural.testing;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.empty;
import static org.hamcrest.Matchers.notNullValue;

import org.eclipse.emf.ecore.EObject;

public class AbstractExamplesTest<T extends EObject> extends AbstractParserTest<T> {

	public void assertExampleParses(String content) throws Exception {
		T model = parseHelper.parse(content);
		assertThat(model, notNullValue());
		assertThat(model.eResource().getErrors(), empty());
	}
}
