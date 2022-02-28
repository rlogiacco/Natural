#language: en
@release:Release-2
@version:1.0.0
@pet_store
Feature: Add a new pet  
	
	"""
	In order to sell a pet
	As a store owner
	I want to add a new pet to the catalog
	"""
	
	,./;'[]\-=
	<>?:"{}|_+
	!@$%^&*()`~
	
	| x | y |
	| a | 0 |
	| b | 1 |
	
	田中さんにあげて下さい
	パーティーへ行かないか

	Background: Add a dog
		Given I have the following pet
		| name | status    |
		| Fido | available |
		And I add the pet to the store
		But the pet is not yet mine

	@add
	@fido
	Scenario: Add another dog
		Then the should be available in the store

	@update
	@fido
	Scenario:
		Given the pet is available in the store -9.8
		"""
		The quick brown fox
		Jumps over the lazy dog
		"""
		When I update the pet with  
		| name | status      |
		| Fido | unavailable |
		Then the pet should be "unavailable" in the store 

	@eat-pickles
	Scenario Outline: Eating pickles
		Given there are <start> pickles
		When I eat <eat> pickles
		Then I should have <left> pickles

		@hungry
		Examples:
		| start | eat | left |
		|    12 |  10 |    2 |
		|    20 |  15 |    5 |
	
		@full
		Examples: With a title
		| start | eat | left |
		|    12 |   2 |   10 |
		|    20 |   5 |   15 |

