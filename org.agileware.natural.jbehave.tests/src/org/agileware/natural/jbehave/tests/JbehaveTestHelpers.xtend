package org.agileware.natural.jbehave.tests

import com.google.inject.Inject
import java.util.List
import org.agileware.natural.jbehave.jbehave.Story
import org.agileware.natural.jbehave.serializer.JbehaveSerializer
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.eclipse.xtext.validation.Issue

import static org.hamcrest.MatcherAssert.assertThat
import static org.hamcrest.Matchers.*

@InjectWith(JbehaveInjectorProvider)
class JbehaveTestHelpers {
	@Inject public ParseHelper<Story> parseHelper
	@Inject public ValidationTestHelper validationTestHelper
	
	@Inject JbehaveSerializer serializer
	
	public static final String EXAMPLE_STORY = '''
		A story is a collection of scenarios
		 
		Narrative:
		In order to communicate effectively to the business some functionality
		As a development team
		I want to use Behaviour-Driven Development
		 
		Lifecycle: 
		Before:
		Scope: STORY
		Given a step that is executed before each story
		Scope: SCENARIO
		Given a step that is executed before each scenario
		Scope: STEP
		Given a step that is executed before each scenario step
		After:
		Scope: STEP
		Given a step that is executed after each scenario step
		Scope: SCENARIO
		Outcome: ANY
		Given a step that is executed after each scenario regardless of outcome
		Outcome: SUCCESS 
		Given a step that is executed after each successful scenario
		Outcome: FAILURE 
		Given a step that is executed after each failed scenario
		Scope: STORY
		Outcome: ANY
		Given a step that is executed after each story regardless of outcome
		Outcome: SUCCESS
		Given a step that is executed after each successful story
		Outcome: FAILURE
		Given a step that is executed after each failed story
		 
		Scenario:  A scenario is a collection of executable steps of different type
		 
		Given step represents a precondition to an event
		When step represents the occurrence of the event
		Then step represents the outcome of the event
		 
		Scenario:  Another scenario exploring different combination of events
		 
		Given a [precondition]
		When a negative event occurs
		Then a the outcome should [be-captured]    
		 
		Examples: 
		|precondition|be-captured|
		|abc|be captured    |
		|xyz|not be captured|
	'''

	def Story parse(CharSequence content) {
		return parseHelper.parse(content)
	}

	def List<Issue> validate(String contet) {
		val model = parseHelper.parse(contet)
		assertThat(model, notNullValue())

		return validationTestHelper.validate(model)
	}
	
	def void trace(String group, Story model) {
		println("------------------" + group + "------------------")
		println(serializer.serialize(model))
	}
}
