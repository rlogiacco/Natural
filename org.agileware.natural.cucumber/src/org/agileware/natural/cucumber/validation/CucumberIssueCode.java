package org.agileware.natural.cucumber.validation;

import org.agileware.natural.common.validation.IssueCodeHelper;

// TODO: load values from localized property file
public enum CucumberIssueCode {
	MissingScenarios("Scenarios are undefined. At least one Scenario is needed to complete the Feature."),
	MissingSteps("Scenario `%s` does not have any steps."),
	MissingStepDefinition("No definition found for `%s`."),
	MultipleStepDefinitions("Multiple definitions found for `%s`.");

	private final IssueCodeHelper helper;
	
	public String code() {
		return helper.codeFor(this);
	}

	public String message(Object... tokens) {
		return helper.message(tokens);
	}
	
	private CucumberIssueCode(String message) {
		helper = new IssueCodeHelper(message);
	}
}
