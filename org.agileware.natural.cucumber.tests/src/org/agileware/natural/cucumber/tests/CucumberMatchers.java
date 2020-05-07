package org.agileware.natural.cucumber.tests;

import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasProperty;

import org.agileware.natural.cucumber.cucumber.Scenario;
import org.agileware.natural.cucumber.cucumber.Step;
import org.hamcrest.Matcher;

public class CucumberMatchers {

	static public Matcher<Scenario> withScenario(String title) {
		return hasProperty("title", equalTo(title));
	}

	static public Matcher<Step> withStep(String description) {
		return hasProperty("description", equalTo(description));
	}

}