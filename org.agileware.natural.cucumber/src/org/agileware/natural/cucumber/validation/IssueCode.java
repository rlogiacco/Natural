package org.agileware.natural.cucumber.validation;

import java.util.Formatter;
import java.util.Locale;

// TODO: load values from localized property file
public enum IssueCode {
	MissingScenarios("Scenarios are undefined. At least one Scenario is needed to complete the Feature."),
	MissingSteps("Scenario `%s` does not have any steps."),
	MissingStepDefinition("No definition found for `%s`."),
	MultipleStepDefinitions("Multiple definitions found for `%s`.");

	static private final String PREFIX = "org.agileware.natural.cucumber.";

	private final Formatter formatter;

	private final String message;

	public String code() {
		return PREFIX + this.toString();
	}

	public String message(Object... tokens) {
		return formatter.format(this.message, tokens).toString();
	}

	private IssueCode(String message) {
		this.message = message;
		this.formatter = new Formatter(new StringBuilder(), Locale.US);
	}
}
