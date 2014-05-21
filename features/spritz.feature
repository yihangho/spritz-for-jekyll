Feature: Spritz
  In order for visitors to use Spritz
  As a site owner
  I want to import necessary code

Scenario: Using the default settings
  Given I have the "_posts" directory
  And I have a post
  And I configure Spritz with client_id and url
  When I run jekyll build
  Then I should have the "_site" directory
  And I should have the "_site/login_success.html" file
  And I should have the "_site/2000/01/01/test.html" file
  And the "_site/2000/01/01/test.html" file should match 'clientId:\s*"12345"'
  And the "_site/2000/01/01/test.html" file should match 'redirectUri:\s*"https://www.example.com/login_success.html"'
  And the "_site/2000/01/01/test.html" file should match 'spritz.min.js'
  And the "_site/2000/01/01/test.html" file should have a div with "data-role" set to "spritzer"

Scenario: Client ID not provided
  Given I have the "_posts" directory
  And I have a post
  And I configure Spritz with:
  | key | value                  |
  | url | https://www.example.com |
  When I run jekyll build
  Then I should be warned that "You need a client ID"

Scenario: URL not provided
  Given I have the "_posts" directory
  And I have a post
  And I configure Spritz with:
  | key       | value |
  | client_id | 12345 |
  When I run jekyll build
  Then I should be warned that "URL not set"

Scenario: URL protocol not specified
  Given I have the "_posts" directory
  And I have a post
  And I configure Spritz with:
  | key       | value           |
  | client_id | 12345           |
  | url       | www.example.com |
  When I run jekyll build
  Then I should be warned that "URL does not contain protocol"
  And I should have the "_site/2000/01/01/test.html" file
  And the "_site/2000/01/01/test.html" file should match 'redirectUri:\s*"http://www.example.com/login_success.html"'

Scenario: URL ends with slashes
  Given I have the "_posts" directory
  And I have a post
  And I configure Spritz with:
  | key       | value                          |
  | client_id | 12345                          |
  | url       | https://www.example.com/////// |
  When I run jekyll build
  Then I should be warned that "URL ends with a forward slash"
  And I should have the "_site/2000/01/01/test.html" file
  And the "_site/2000/01/01/test.html" file should match 'redirectUri:\s*"https://www.example.com/login_success.html"'

Scenario: URL points to another option
  Given I have the "_posts" directory
  And I have a post
  And I configure the site with "base_url" set to "https://www.example.org"
  And I configure Spritz with:
  | key       | value    |
  | client_id | 12345    |
  | url       | base_url |
  When I run jekyll build
  Then I should have the "_site/2000/01/01/test.html" file
  And the "_site/2000/01/01/test.html" file should match 'redirectUri:\s*"https://www.example.org/login_success.html"'

Scenario: login_success_name given
  Given I have the "_posts" directory
  And I have a post
  And I configure Spritz with:
  | key                | value                             |
  | client_id          | 12345                             |
  | url                | http://www.example.com            |
  | login_success_name | subdir/another/subdir/spritz.html |
  When I run jekyll build
  Then I should have the "_site/subdir/another/subdir" directory
  And I should have the "_site/subdir/another/subdir/spritz.html" file

Scenario: selector is given
  Given I have the "_posts" directory
  And I have a post
  And I configure Spritz with:
  | key       | value                  |
  | client_id | 12345                  |
  | url       | http://www.example.com |
  | selector  | div#content            |
  When I run jekyll build
  Then I should have the "_site/2000/01/01/test.html" file
  And the "_site/2000/01/01/test.html" file should have a div with "data-selector" set to "div\#content"

Scenario: auto mode is switched off
  Given I have the "_posts" directory
  And I have a post
  And I configure Spritz with:
  | key       | value                  |
  | client_id | 12345                  |
  | url       | http://www.example.com |
  | auto_mode | false                  |
  When I run jekyll build
  Then I should have the "_site/2000/01/01/test.html" file
  And the "_site/2000/01/01/test.html" file should not match 'spritz.min.js'
  And the "_site/2000/01/01/test.html" file should not have a div with "data-role" set to "spritzer"

Scenario: auto mode is enabled, but Spritz is disabled on a post
  Given I have the "_posts" directory
  And I have a post with "spritz" set to "false"
  And I configure Spritz with client_id and url
  When I run jekyll build
  Then I should have the "_site/2000/01/01/test.html" file
  And the "_site/2000/01/01/test.html" file should not match 'spritz.min.js'
  And the "_site/2000/01/01/test.html" file should not have a div with "data-role" set to "spritzer"

Scenario: auto mode is switched off, use spritz_redicle tag
  Given I have the "_posts" directory
  And I have a post with content "{% spritz_redicle %}"
  And I configure Spritz with:
  | key       | value                  |
  | client_id | 12345                  |
  | url       | http://www.example.com |
  | auto_mode | false                  |
  When I run jekyll build
  Then I should have the "_site/2000/01/01/test.html" file
  And the "_site/2000/01/01/test.html" file should not match 'spritz.min.js'
  And the "_site/2000/01/01/test.html" file should have a div with "data-role" set to "spritzer"

Scenario: auto mode is switched off, use spritz_scripts tag
  Given I have the "_posts" directory
  And I have a post with content "{% spritz_scripts %}"
  And I configure Spritz with:
  | key       | value                  |
  | client_id | 12345                  |
  | url       | http://www.example.com |
  | auto_mode | false                  |
  When I run jekyll build
  Then I should have the "_site/2000/01/01/test.html" file

Scenario: Disable jquery fallback
  Given I have the "_posts" directory
  And I have a post
  And I configure Spritz with:
  | key       | value                  |
  | client_id | 12345                  |
  | url       | http://www.example.com |
  | jquery    | false                  |
  When I run jekyll build
  Then I should have the "_site/2000/01/01/test.html" file
  And the "_site/2000/01/01/test.html" file should not match 'jquery.min.js'

Scenario: Customize jquery fallback
  Given I have the "_posts" directory
  And I have a post
  And I configure Spritz with:
  | key | value |
  | client_id | 12345 |
  | url | http://www.example.com |
  | jquery | ["jquery1.min.js", "jquery2.min.js"] |
  When I run jekyll build
  Then I should have the "_site/2000/01/01/test.html" file
  And the "_site/2000/01/01/test.html" file should match 'jquery1\.min\.js.*jquery2\.min\.js'

Scenario: Customize the redicle
  Given I have the "_posts" directory
  And I have a post
  And I configure Spritz with:
  | key       | value                                           |
  | client_id | 12345                                           |
  | url       | http://www.example.com                          |
  | redicle   | { width: 500, height: 100, default_speed: 600 } |
  When I run jekyll build
  Then I should have the "_site/2000/01/01/test.html" file
  And the "_site/2000/01/01/test.html" file should match 'data-options'
  And the "_site/2000/01/01/test.html" file should match '"redicleWidth":500'
  And the "_site/2000/01/01/test.html" file should match '"redicleHeight":100'
  And the "_site/2000/01/01/test.html" file should match '"defaultSpeed":600'
