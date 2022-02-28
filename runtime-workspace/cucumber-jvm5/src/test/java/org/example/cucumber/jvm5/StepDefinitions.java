package org.example.cucumber.jvm5;

import io.cucumber.java.en.Given;

public class StepDefinitions {
	@Given("I have a matching step definition")
	public void i_have_a_matching_step_definition() {}
	
	@Given("{string} has {int} matching step definitions")
	public void actor_has_matching_step_definitions(String actor, Integer amount) {}
}
