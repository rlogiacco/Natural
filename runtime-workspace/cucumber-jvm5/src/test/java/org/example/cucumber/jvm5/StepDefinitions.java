package org.example.cucumber.jvm5;

import static org.junit.Assert.assertTrue;

import io.cucumber.java.en.Given;

public class StepDefinitions {
	@Given("I have a matching step definition")
	public void i_have_a_matching_step_definition() {
		assertTrue("I have a matching step definition", true);
	}
}
