Feature: contribution process
  In order to maintain and evolve the project
  As a contributor
  I want to maximize the value of my contributions

  @critical
  Scenario: fixing critical issues
    When the previous version has issues labelled as "critical"
    Then I focus on resolving those first
    But I operate on a separate "fix/something" branch forked from the latest release

  @non-critical @evolution
  Scenario: adding features and fixing non-critical issues
    Given the previous version has 0 issues labelled as "critical"
    When I have time to dedicate to the project
    Then I can add additional features, each one in a separate PR
    And I can fix issues, each one in a distinct PR

  @release
  Scenario Outline: releasing a new version
    When the dev team decides we have collected enough value for a new release
    Then a member of the dev team bumps the versions ups
    And publishes a new <release> of the plugins
    And a new release announcement is sent to the medias

    @versions
    Examples:
      | release | explanation vs 1.0.0                                                                        |
      | 1.0.1   | something has been fixed                                                                    |
      | 1.1.0   | something has been added, something might have also been fixed                              |
      | 2.0.0   | breaking changes introduced so stuff that was working before will probably not work anymore |
