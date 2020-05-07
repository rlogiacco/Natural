package org.agileware.natural.cucumber.validation;

import java.util.Formatter;
import java.util.Locale;

// TODO: load values from localized property file
public enum IssueCodes {
	MissingScenarios("Scenarios are undefined. At least one Scenario is needed to complete the Feature."),
	MissingSteps("Scenario `%s` does not have any steps."),
	MissingStepDefinition("No definition found for `%s`."),
	MultipleStepDefinitions("Multiple definitions found for `%s`.");

	static private final String PREFIX = "org.agileware.natural.cucumber.";

	private final Formatter formatter;

	private final String value;

	public String code() {
		return PREFIX + this.toString();
	}

	public String value(Object... tokens) {
		return formatter.format(this.value, tokens).toString();
	}

	private IssueCodes(String value) {
		this.value = value;
		this.formatter = new Formatter(new StringBuilder(), Locale.US);
	}
}
