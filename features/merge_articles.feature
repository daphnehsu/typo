Feature: Merge articles
	As an administrator
	In order to prevent two articles on the same topic
	I want to merge articles

	Background:
	Given the blog is set up



	Given the following users exist:
    | profile_id | login  | name  | password | email          | state  |
    | 2          | user1  | user1 | 12345    | u1@example.com | active |
    | 3          | user2  | user2 | 12345    | u2@example.com | active |

	Given the following articles exist:
	|user_id | author | body | id          | title  | published |
	| 2         | user1  | cat  |  3          | title1 | true      |
	| 3         | user2  | dog  |  4          | title2 | true      |

	Given the following comments exist:
	|id | article_id | author | body | user_id |
	| 1 | 3 		 | user1  | hi   | 2	   |
	| 2 | 4 	     | user2  | bye  | 3       |
	
	Given I am logged in as "admin" with pass "aaaaaaaa"
	And I am on the Edit Page with id "1"
	When I fill in "merge_with" with "2"
	And I press "Merge"

	Scenario: Merged article should contain text of both previous articles
	Given I have merged articles with id "3" and id "4"
	And I am on the home page
	Then I should see "title1"
    When I follow "title1"
    Then I should see "cat"
	And I should see "dog"

	Scenario: A non-admin cannot merge two articles
	Given I am on the new article page 
	And I am on the Edit Page with id "3"
	Then I should not see "merge"

	Scenario: Merged article should have one author
	Given I have merged articles with id "3" and id "4"
	Then the article with id "3" should have author "user1" or "user2"

	Scenario: Comments from previous articles should carry over to new merged article
	Given I have merged articles with id "3" and id "4"
	And I am on the home page
	Then I should see "title1"
    When I follow "title1"
	Then I should see "hi"
	And I should see "bye"

	Scenario: Title of merged article should be either of the old article titles
	Given I have merged articles with id "3" and id "4"
	And I am on the home page
	Then I should see "title1"
	And I should not see "title2"

