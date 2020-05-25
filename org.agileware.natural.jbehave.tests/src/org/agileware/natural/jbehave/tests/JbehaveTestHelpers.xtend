package org.agileware.natural.jbehave.tests

import com.google.inject.Inject
import java.util.List
import org.agileware.natural.jbehave.jbehave.AndStep
import org.agileware.natural.jbehave.jbehave.AsA
import org.agileware.natural.jbehave.jbehave.GivenStep
import org.agileware.natural.jbehave.jbehave.IWantTo
import org.agileware.natural.jbehave.jbehave.InOrderTo
import org.agileware.natural.jbehave.jbehave.SoThat
import org.agileware.natural.jbehave.jbehave.Story
import org.agileware.natural.jbehave.jbehave.ThenStep
import org.agileware.natural.jbehave.jbehave.WhenStep
import org.agileware.natural.jbehave.serializer.JbehaveSerializer
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.eclipse.xtext.validation.Issue
import org.hamcrest.Matcher

import static org.hamcrest.Matchers.*

@InjectWith(JbehaveInjectorProvider)
class JbehaveTestHelpers {
	
	@Inject ParseHelper<Story> parseHelper
	@Inject ValidationTestHelper validationTestHelper
	@Inject JbehaveSerializer serializer
	
	public static final String SIMPLE_NARRATIVE = '''
		Narrative:
		In order to sell a pet
		As a store owner
		I want to add a new pet
	'''
	
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
		And another step that is executed before each story
		Scope: SCENARIO
		Given a step that is executed before each scenario
		After:
		Scope: STEP
		Given a step that is executed after each scenario step
		And another step that is executed after each scenario step
		Scope: STORY
		Outcome: ANY
		Given a step that is executed after each story regardless of outcome
		 
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
	
	def static Matcher<Story> hasNarrative(Matcher... matchers) {
		return hasProperty("narrative", allOf(matchers))
	}
	
	def static hasSimpleNarrative() {
		return hasNarrative(
			inOrderTo("sell a pet"),
			asA("store owner"),
			iWantTo("add a new pet")
		)
	}
	
	def static Matcher<InOrderTo> inOrderTo(String content) {
		return hasProperty("inOrderTo", 
				hasProperty("content", equalTo(content)))
	}
	
	def static Matcher<AsA> asA(String content) {
		return hasProperty("asA", 
				hasProperty("content", equalTo(content)))
	}
	
	def static Matcher<IWantTo> iWantTo(String content) {
		return hasProperty("wantTo", 
				hasProperty("content", equalTo(content)))
	}
	
	def static Matcher<SoThat> soThat(String content) {
		return hasProperty("soThat", 
				hasProperty("content", equalTo(content)))
	}
	
	def static givenStep(String content) {
		return allOf(
				instanceOf(GivenStep),
				hasProperty("content", equalTo(content))
		)
	}
	
	def static whenStep(String content) {
		return allOf(
				instanceOf(WhenStep),
				hasProperty("content", equalTo(content))
		)
	}
	
	def static thenStep(String content) {
		return allOf(
				instanceOf(ThenStep),
				hasProperty("content", equalTo(content))
		)
	}
	
	def static andStep(String content) {
		return allOf(
				instanceOf(AndStep),
				hasProperty("content", equalTo(content))
		)
	}

	def Story parse(CharSequence content) {
		return parseHelper.parse(content)
	}

	def List<Issue> validate(Story model) {
		return validationTestHelper.validate(model)
	}
	
	def void trace(String group, Story model) {
		println("------------------" + group + "------------------")
		for(e : model.eResource.errors) {
			println(e)
		}
		println(serializer.serialize(model))
	}
}
