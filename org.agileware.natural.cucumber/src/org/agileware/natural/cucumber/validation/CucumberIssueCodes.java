package org.agileware.natural.cucumber.validation;

public interface CucumberIssueCodes {

	String PREFIX = "org.agileware.natural.cucumber.";
	
	String MISSING_FEATURE_TITLE = PREFIX + "MISSING_FEATURE_TITLE";

	String MISSING_SCENARIOS = PREFIX + "MISSING_SCENARIOS";
	
	String MISSING_SCENARIO_STEPS = PREFIX + "MISSING_SCENARIO_STEPS";
	
	String MISSING_STEPDEFS = PREFIX + "MISSING_STEPDEFS";
	
	String MULTIPLE_STEPDEFS = PREFIX + "MULTIPLE_STEPDEFS";
}
