*** Settings ***
Library         SeleniumLibrary
Documentation   Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}    https://scouts-test.futbolkolektyw.pl/en
${BROWSER}      Chrome
${SIGNINBUTTON}  xpath=//*[text()='Sign in']
${EMAILINPUT}  xpath=//*[@id='login']
${PASSWORDINPUT}  xpath=//input[@type='password']
${PAGELOGO}  xpath=//*[@id="__next"]/div[1]/main/div[3]/div[1]/div/div[1]
${SIGNOUTBUTTON}  xpath=//*[text()="Sign out"]
${LINKADDPLAYER}  xpath=//*[text()="Add player"]
${ADDPLAYERTITLE}  xpath=//*[@id="__next"]/div[1]/main/div[2]/form/div[1]/div/span
${PLAYERNAME}  xpath=//input[@name="name"]
${PLAYERSURNAME}  xpath=//input[@name="surname"]
${PLAYERAGE}  xpath=//input[@name="age"]
${PLAYERNAMEPOSITION}  xpath=//input[@name="mainPosition"]
${BUTTONSUBMIT}  xpath=//*[text()="Submit"]

*** Test Cases ***
Login to the system
    Open Login Page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    [Teardown]  Close Browser

Log out of the system
    Open Login Page
    Type in email
    Type in password
    Click on the Submit button
    Wait until element is visible   ${PAGELOGO}
    Click on the Signout button
    Title Should be                 Scouts panel - sign in
    [Teardown]  Close Browser

Failed login to the system
   Open Login Page
   Type in email
   Input Text      ${PASSWORDINPUT}  Test-12345
   Click on the Submit button
   Title Should be                 Scouts panel - sign in
   [Teardown]  Close Browser

Add players redirects
   Open Login Page
   Type in email
   Type in password
   Click on the Submit button
   Click On The Link Add Player
   Wait until element is visible  ${ADDPLAYERTITLE}
   [Teardown]  Close Browser

Add player with requierd fields
   Open Login Page
   Type in email
   Type in password
   Click on the Submit button
   Click On The Link Add Player
   Wait until element is visible  ${ADDPLAYERTITLE}
   Type In Required Fields
   Click On The Submit Button To Add Player
   Sleep    5
   ${url}    Get Location
   Should Contain    ${url}    edit
   [Teardown]  Close Browser



*** Keywords ***
Open Login page
    Open Browser    ${LOGIN URL}     ${BROWSER}

Type in email
    Input Text      ${EMAILINPUT}     user01@getnada.com

Type in password
    Input Text      ${PASSWORDINPUT}  Test-1234

Click on the Submit button
    Click Element   xpath=//*[text()='Sign in']

Click on the Signout button
    Click Element  xpath=//*[text()="Sign out"]

Click on the link add player
    Wait until element is visible    ${LINKADDPLAYER}
    Click Element  xpath=//*[text()="Add player"]

Type in required fields
   Input Text  ${PLAYERNAME}  Vasilii
   Input Text  ${PLAYERSURNAME}  Pupkin
   Input Text  ${PLAYERAGE}  0808-19-80
   Input Text  ${PLAYERNAMEPOSITION}  Forward

Click on the submit button to add player
   Click Element  ${BUTTONSUBMIT}

Assert dashboard
    Wait until element is visible   ${PAGELOGO}
    Title Should be                 Scouts panel
    Capture Page screenshot         alert.png

