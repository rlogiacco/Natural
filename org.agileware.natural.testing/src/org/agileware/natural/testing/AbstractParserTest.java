package org.agileware.natural.testing;

import java.util.List;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.testing.util.ParseHelper;
import org.eclipse.xtext.testing.validation.ValidationTestHelper;
import org.eclipse.xtext.validation.Issue;

import com.google.inject.Inject;

public class AbstractParserTest<T extends EObject> {

	@Inject
	ParseHelper<T> parseHelper;
	
	@Inject 
	ValidationTestHelper validationTestHelper;

	public T parse(String content) throws Exception {
		return parseHelper.parse(content);
	}
	
	public List<Issue> validate(T model) throws Exception {
		return validationTestHelper.validate(model);
	}
}
