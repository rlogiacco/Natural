package org.agileware.natural.jbehave.tests

class Examples {

	// ----------------------------------------------------------
	//
	// Descripton
	//
	// ----------------------------------------------------------
	
	public static final String DESCRIPTION_01 = '''
		The quick brown fox
	'''

	public static final String DESCRIPTION_02 = '''
		The quick brown fox
		Jumps over the lazy dog
	'''

	// ----------------------------------------------------------
	//
	// Scenarios
	//
	// ----------------------------------------------------------
	
	public static final String SCENARIO_01 = '''
		Scenario: Hello, World!
		Given a single step
	'''

	public static final String SCENARIO_02 = '''
		Scenario: Hello, World!
		
		Given a precondition
		And another
		When something happens
		Then everything is a-ok
	'''

	public static final String SCENARIO_03 = '''
		Scenario: Hello, World!
		
		Given a [precondition]
		When a negative event occurs
		Then the outcome should <be-captured>
		 
		Examples: 
		|precondition|be-captured|
		|abc|be captured    |
		|xyz|not be captured|
	'''

	public static final String SCENARIO_04 = '''
		Scenario:
		Given a step
		And another step
	'''

	public static final String SCENARIO_05 = '''
		The quick brown fox
		Jumps over the lazy dog
		
		Scenario:
		Given a step
		And another step
	'''

	public static final String SCENARIO_06 = '''
		Scenario:
		
		Meta:
		@key:value
		@themes UI Usability
		
		Given a step
		And another step
	'''

	// ----------------------------------------------------------
	//
	// Narrative
	//
	// ----------------------------------------------------------
	
	public static final String NARRATIVE_01 = '''
		Narrative:
		In order to sell a pet
		As a store owner
		I want to add a new pet
	'''

	public static final String NARRATIVE_02 = '''
		Narrative:
		As a store owner
		I want to add a new pet
		So that the pet gets sold
	'''

	public static final String NARRATIVE_03 = '''
		The quick brown fox
		Jumps over the lazy dog
		
		Narrative:
		In order to sell a pet
		As a store owner
		I want to add a new pet
	'''

	// ----------------------------------------------------------
	//
	// Meta Data
	//
	// ----------------------------------------------------------
	
	public static final String META_01 = '''
		Meta:
		@key:value
	'''

	public static final String META_02 = '''
		Meta:
		@key:value
		@themes UI Usability
	'''

	public static final String META_03 = '''
		The quick brown fox
		Jumps over the lazy dog
		
		Meta:
		@key:value
		@themes UI Usability
	'''

	public static final String META_04 = '''
		The quick brown fox
		Jumps over the lazy dog
		
		Meta:
		@key:value
		@themes UI Usability
		
		Narrative:
		In order to sell a pet
		As a store owner
		I want to add a new pet
	'''


	// ----------------------------------------------------------
	//
	// Life Cycle
	//
	// ----------------------------------------------------------
	
	public static final String LIFECYCLE_01 = '''
		Lifecycle:
		Before:
		Scope: STORY
		Given a step
	'''

	public static final String LIFECYCLE_02 = '''
		Lifecycle:
		After:
		Scope: STORY
		Given a step
	'''

	public static final String LIFECYCLE_03 = '''
		Lifecycle:
		Before:
		Scope: STORY
		Given a step
		After:
		Scope: STORY
		Given a step
	'''

	public static final String LIFECYCLE_04 = '''
		Lifecycle:
		Before:
		Scope: STORY
		Given a step
		After:
		Scope: STORY
		Outcome: ANY
		Given another step
	'''

	public static final String LIFECYCLE_05 = '''
		Lifecycle:
		Before:
		Scope: STORY
		Given a step
		
		Scenario:
		Given a precondition
		And another precondition
	'''


	// ----------------------------------------------------------
	//
	// Given Stories
	//
	// ----------------------------------------------------------
	
	public static final String GIVENSTORIES_01 = '''
		Scenario: Hello, World!
		
		GivenStories: /path/to/example.story
		
		Given a precondition
		And another precondition
	'''

	public static final String GIVENSTORIES_02 = '''
		Scenario: Hello, World!
		
		GivenStories: /path/to/example_01.story,
		              /path/to/example_01.story
		
		Given a precondition
		And another precondition
	'''

	// ----------------------------------------------------------
	//
	// Pathological Examples
	//
	// ----------------------------------------------------------
	
	public static final String EXAMPLE_01 = '''
		Scenario: Hello, World!
		Given a "precondition" of -9.8 m/s^2
		
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
	'''

	public static final String EXAMPLE_02 = '''
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
}
