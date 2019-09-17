# Price Calculator acceptance tests

## Test Plan

For testing an App like this, in an agile team, I recommend a combination of automated user interface tests and exploratory testing.

### Exploratory testing
During the exploratory testing process, we learn the product, design test cases, execute test cases and interprete the test results at the same time. It is a method that requires the tester to think critically through the entire process.

For document the exploratory tests, we can follow one (or combined) of this tecniques:
- Notepad test logs, where we should add information about the execution environment, date, time, test case, test input, output and summary.

```
1. Login scenario: valid user and invalid password

user: user@qabify.com
password: 1234

Login page displayed => OK
Enter credentials => OK
Enter button => OK
Error message => OK

Result: OK

```

- Mind Map. A very visual way to represnet the case/scenario your are checking.
![image](https://user-images.githubusercontent.com/5942864/65079599-da7a8200-d99f-11e9-936e-df21e080fc67.png)


### Automated tests
Regaring the automated tests, first, we should build a framework and then, automate the most important or most critical scenarios. Automated tests are done using Page Object structure fo facilitate the creation of the framework.

In this App, I've automated the following scenarios:

- Login page
  - positive case (valid credentials)
  - negative case
    - invalid user
    - invalid password
    - invalid user and password
    - empty credentials
- Journey page
  - enter an invalid captcha
  - valid captcha
    - valid route
      - car type lite
      - car type executive
      - car both type lite and executive
      - not selecting any car type (bug)
      - compare lite and executive price
      - estimate a second car before request it (bug)
        - change the destination
        - change the car type
  - route
    - select a valid origen and destination
    - select an invalid origen
    - select an invalid destination
    - origen same as destination (Q&A)
- Past journeys
  - single journey
  - multiple journeys
- Android gestures
  - Restart the app (Q&A)
    - in login page
    - in code page
    - in journey page
    - in past journeys page
  - Expose the app
    - in login page
    - in code page
    - in journey page
    - in past journeys page

For the exploratory testing 

## Decisions taken

There are some frameworks and scopes we can use for automate the tests. In this case, I've decided to automate the tests using Appium + RSpec(ruby). RSpec includes traditional Unit Testing, but RSpec is also used for Acceptance Testing.

These tests are business-case driven Integration Tests (BDD), which mean they simulate the way a user uses the application and uses the different parts of it together, in a way that unit testing will not find.

### Why not use Cucumber?
The main difference between RSpec and Cucumber are the business readability factor. Cucumber's main draw is that the specification (features) are separate from the test code, so your product owners can provide or review the specification without having to dig through code. These are the .feature files that you make in Cucumber.

RSpec has a similar mechanism, but instead you describe a step with a `Describe` and `It` block that contains the business specification, and then immediately have the code that executes that statement. This approach is a little easier for developers to work with but a little harder for non-technical folks and that's the main reason I decided to use it. I believe in Agile teams, all members should work together and writing the acceptance tests using RSpec facilitate the collaboration between QAs and developers.


## Bugs
### Bug template

For reporting the bugs, we could use a template to unify the format of them, identify easily the important details and do not forget any of it.

A template should include:

```
## Expected Behavior
<!--- Tell us what should happen -->

## Current Behavior
<!--- Tell us what happens instead of the expected behavior -->

## Possible Solution
<!--- Not obligatory, but suggest a fix/reason for the bug -->

## Steps to Reproduce
<!--- Provide a link to a live example, or an unambiguous set of steps to -->
<!--- reproduce this bug. Include code to reproduce, if relevant -->
1.
2.
3.
4.

## Context (Environment)
<!--- Providing context helps us come up with a solution that is most useful in the real world -->
```

### Bugs reported

1. Estimate a second car before request it

    - Expected: Expect the request car button is disable after change any journey parameter. A new extimation is necesary before request it
    - Current: It's possible request a new car without extimate it

    - Steps to reproduce: see `spec/feature/journey_spec.rb`, scenarios: `'estimate a second car before request it: change destination'` and `'estimate a second car before request it: change type'`

2. In the journey page, it is possible to estimate a car without indicating the type of car. Also, it's possible selecting both types. I don't think las opetion is a bug, but it needs clarification

    - Expected: Estimate journey needs to select at least one car type
    - Current: It's possible estimate a hourney without selecting any car type

    - Steps to reproduce: see `spec/feature/origen_and_destination_spec copy.rb`, scenario: `'estimate a second car before request it: change destination'`

3. First time the user access to the journey page, the estimated price is `null €`

    - Expected: When the price has not been estimated, the price should be `0 €`
    - Current: Currently, the estimated price is `null €`

    - Steps to reproduce:
    ```
    1. Login with valid credentials
    2. Note the code
    3. In Journey details page, check the estimated price
    ```


## Q&A
1. In a journey, is it possible that the origin is the same than the destination? It looks weird to be and it shouldn't be possible.
2. What is the expected behaviour after restart (close and open) the app? Should remember the data of the page? Currently, user is log out and login page is displayed

## Future Improvements
- Execution in parallel to speed up the tests execution
- Ececution is more than one device for testing how the App performace with diferent resolutions