package org.agileware.natural.testing;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.testing.formatter.FormatterTestHelper;
import org.eclipse.xtext.testing.formatter.FormatterTestRequest;

import com.google.inject.Inject;
import com.google.inject.Provider;

public class AbstractFormatterTest<T extends EObject> {

	@Inject
	FormatterTestHelper formatterTestHelper;

	@Inject
	Provider<FormatterTestRequest> formatterRequestProvider;

	public void assertFormatted(String toBeFormatted, String expectation) {
		formatterTestHelper.assertFormatted(
				formatterRequestProvider.get()
						.setToBeFormatted(toBeFormatted)
						.setExpectation(expectation));
	}

	public void assertFormatted(String toBeFormatted) {
		formatterTestHelper.assertFormatted(
				formatterRequestProvider.get()
						.setToBeFormatted(toBeFormatted));
	}
}
