Feature: Merge Articles
  As a blog administrator
  In order to have more interesting articles
  I want to be able to merge articles with each other

  Background:
    Given the blog is set up
	And the following articles exist:
	| id | title        | published | author  | body                            |
  	| 3  | Christmas    | true      | Mathias | Christmas toodle toodle hey hey |
  	| 4  | My x-mas     | true      | Andreas | My x-mas was dreadful. Yikes... |
    
  Scenario: Non-admins should not be able to Merge Articles
    Given I am on the manage articles page
    Then I should see "Login"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles but only one author.
    Given I am logged into the admin panel
  	And I am on the manage articles page
    Then I should see "Christmas"
    And I should see "My x-mas"
    When I follow "Christmas"
    Then I should see "Christmas toodle toodle hey hey"
    And I should see "Merge Articles"
    When I fill in "ArticleID" with 4
    And I press "Merge"
    Then I should see "Christmas toodle toodle hey hey"
    And I should see "My x-mas was dreadful. Yikes..."
