package org.agileware.natural.jbehave.tests

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Suite

@RunWith(Suite)
@Suite.SuiteClasses(DescriptionExamples, ScenarioExamples, NarrativeExamples, MetaExamples, LifecycleExamples, GivenStoriesExamples, PathologicalExamples)
class JbehaveExamplesTest {

	static class DescriptionExamples extends AbstractExampleTest {

		@Test
		def void description_01() {
			assertThatExampleParses('''
				The quick brown fox
			''')
		}

		@Test
		def void description_02() {
			assertThatExampleParses('''
				The quick brown fox
				Jumps over the lazy dog
			''')
		}

	}

	static class ScenarioExamples extends AbstractExampleTest {
		
		@Test
		def void scenario_01() {
			assertThatExampleParses('''
				Scenario: Hello, World!
				Given a single step
			''')
		}

		@Test
		def void scenario_02() {
			assertThatExampleParses('''
				Scenario: Hello, World!
				
				Given a precondition
				And another
				When something happens
				Then everything is a-ok
			''')
		}

		@Test
		def void scenario_04() {
			assertThatExampleParses('''
				Scenario: Hello, World!
				
				Given a [precondition]
				When a negative event occurs
				Then the outcome should <be-captured>
				 
				Examples: 
				|precondition|be-captured|
				|abc|be captured    |
				|xyz|not be captured|
			''')
		}

		@Test
		def void scenario_05() {
			assertThatExampleParses('''
				Scenario:
				Given a step
				And another step
			''')
		}

		@Test
		def void scenario_06() {
			assertThatExampleParses('''
				The quick brown fox
				Jumps over the lazy dog
				
				Scenario:
				Given a step
				And another step
			''')
		}

		@Test
		def void scenario_07() {
			assertThatExampleParses('''
				Scenario:
				
				Meta:
				@key:value
				@themes UI Usability
				
				Given a step
				And another step
			''')
		}
	}

	static class NarrativeExamples extends AbstractExampleTest {
		
		@Test
		def void narrative_01() {
			assertThatExampleParses('''
				Narrative:
				In order to sell a pet
				As a store owner
				I want to add a new pet
			''')
		}

		@Test
		def void narrative_02() {
			assertThatExampleParses('''
				Narrative:
				As a store owner
				I want to add a new pet
				So that the pet gets sold
			''')
		}

		@Test
		def void narrative_03() {
			assertThatExampleParses('''
				The quick brown fox
				Jumps over the lazy dog
				
				Narrative:
				In order to sell a pet
				As a store owner
				I want to add a new pet
			''')
		}
	}

	static class MetaExamples extends AbstractExampleTest {
		
		@Test
		def void meta_01() {
			assertThatExampleParses('''
				Meta:
				@key:value
			''')
		}

		@Test
		def void meta_02() {
			assertThatExampleParses('''
				Meta:
				@key:value
				@themes UI Usability
			''')
		}

		@Test
		def void meta_03() {
			assertThatExampleParses('''
				The quick brown fox
				Jumps over the lazy dog
				
				Meta:
				@key:value
				@themes UI Usability
			''')
		}

		@Test
		def void meta_04() {
			assertThatExampleParses('''
				The quick brown fox
				Jumps over the lazy dog
				
				Meta:
				@key:value
				@themes UI Usability
				
				Narrative:
				In order to sell a pet
				As a store owner
				I want to add a new pet
			''')
		}
	}

	static class LifecycleExamples extends AbstractExampleTest {
		
		@Test
		def void lifecycle_01() {
			assertThatExampleParses('''
				Lifecycle:
				Before:
				Scope: STORY
				Given a step
			''')
		}

		@Test
		def void lifecycle_02() {
			assertThatExampleParses('''
				Lifecycle:
				After:
				Scope: STORY
				Given a step
			''')
		}

		@Test
		def void lifecycle_03() {
			assertThatExampleParses('''
				Lifecycle:
				Before:
				Scope: STORY
				Given a step
				After:
				Scope: STORY
				Given a step
			''')
		}

		@Test
		def void lifecycle_04() {
			assertThatExampleParses('''
				Lifecycle:
				Before:
				Scope: STORY
				Given a step
				After:
				Scope: STORY
				Outcome: ANY
				Given another step
			''')
		}

		@Test
		def void lifecycle_05() {
			assertThatExampleParses('''
				Lifecycle:
				Before:
				Scope: STORY
				Given a step
				
				Scenario:
				Given a precondition
				And another precondition
			''')
		}
	}

	static class GivenStoriesExamples extends AbstractExampleTest {

		@Test
		def void givenstories_01() {
			assertThatExampleParses('''
				Scenario: Hello, World!
				
				GivenStories: /path/to/example.story
				
				Given a precondition
				And another precondition
			''')
		}

		@Test
		def void givenstories_02() {
			assertThatExampleParses('''
				Scenario: Hello, World!
				
				GivenStories: /path/to/example_01.story,
				                /path/to/example_01.story
				
				Given a precondition
				And another precondition
			''')
		}
	}

	static class PathologicalExamples extends AbstractExampleTest {

		@Test
		def void pathological_01() {
			assertThatExampleParses('''
				Scenario: Hello, World!
				Given a precondition
				
				Scenario:
				Given a precondition
				And another precondition
				
				Given a [precondition]
				When a negative event occurs
				Then the outcome should <be-captured>
				    
				Examples: 
				|precondition|be-captured|
				|abc|be captured    |
				|xyz|not be captured|
			''')
		}

		@Test
		def void pathological_02() {
			assertThatExampleParses('''
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
			''')
		}
	}
}
