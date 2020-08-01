package org.agileware.natural.cucumber.validation;

import org.agileware.natural.common.IssueCode;

public class CucumberIssueCodes {

	public static IssueCode MISSING_SCENARIOS = new IssueCode("MISSING_SCENARIOS", 
			"Feature has no scenarios");

	public static IssueCode MISSING_FEATURE_TITLE = new IssueCode("MISSING_FEATURE_TITLE", 
			"Feature title is missing");

	public static IssueCode MISSING_SCENARIO_STEPS = new IssueCode("MISSING_SCENARIO_STEPS",
			"Scenario is missing steps");
	
	public static IssueCode INVALID_BACKGROUND = new IssueCode("INVALID_BACKGROUND",
			"Invalid background definition");

	public static IssueCode MISSING_STEPDEFS = new IssueCode("MISSING_STEPDEFS", 
			"No step definition found for `%s`");

	public static IssueCode MULTIPLE_STEPDEFS = new IssueCode("MULTIPLE_STEPDEFS",
			"Multiple step definitions found for `%s`");

}
