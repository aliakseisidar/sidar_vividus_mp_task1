Description: Simple story to check the page availability;

Meta:
    @proxy

Scenario: Log in
Given I am on the main application page
When I click on element located `By.xpath(//*[text()='Sign In'])`
And I click on element located `By.xpath(//*[text()='Sign in with IMDb'])`
And I enter `${userEmail}` in field located `By.xpath(//*[@id="ap_email"])`
And I enter `${userPassword}` in field located `By.xpath(//*[@id="ap_password"])`
And I click on element located `By.xpath(//input[@id='signInSubmit'])`
Then the text 'Aliaksei' exists

Scenario: Find a movie
When I enter `${filmTitle}` in field located `By.xpath(//*[@id="suggestion-search"])`
And I click on element located `By.xpath(//*[@id="suggestion-search-button"])`
Then the text 'Results for "${filmTitle}"' exists

Scenario: Open movie from the search
When I click on element located `By.xpath(//h3[text()[contains(.,'Titles')]]/following-sibling::table//tr[1]/td[1]/a)`
Then the page title contains the text '${filmTitle}'

Scenario: Add movie to watchlist
When I wait until element located `By.xpath(//div[@class='ipc-btn__text']/preceding-sibling::*)` appears
And I save number of elements located `By.xpath(//*[text()='Add to Watchlist'])` to scenario variable `numberOfElements`
And the condition '#{eval("${numberOfElements}"=="1")}' is true I do
|step|
|When I click on element located `By.xpath(//div[text()[contains(.,'Add to Watchlist')]]/..)`|
Then the text 'In Watchlist' exists

Scenario: Navigate to watchlist
When I click on element located `By.xpath(//nav[@id='imdbHeader']//div[text()='Watchlist']/..)`
Then the page title contains the text 'Your Watchlist'

Scenario: Sort and export the watchlist
When I click on element located `By.xpath(//*[@id="lister-sort-by-options"])`
And I click on element located `By.xpath(//*[@id="lister-sort-by-options"]/option[4])`
And I click on element located `By.xpath(//a[text()='Export this list'])`
And I capture HTTP GET request with URL pattern `https://www.imdb.com/list/ls\d\d\d\d\d\d\d\d\d/export` and save request data to scenario variable `data`
Then `${data.responseStatus}` is equal to `200`
