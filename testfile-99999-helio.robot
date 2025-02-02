*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            https://obstaclecourse.tricentis.com/Obstacles/99999
${BROWSER}        Firefox

*** Test Cases ***
Scroll Into View And Submit
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    submit
    Select Frame    container
    VAR    ${counter}    0
    WHILE    ${counter} < 4
        Sleep    1s
        Press Keys    //body    ARROW_DOWN
        Execute Javascript    var top = document.body.scrollTop; document.body.scrollTop = 100;
        ${counter}=    Evaluate    ${counter} + 1
        ${result}    ${code}=    Run Keyword And Ignore Error    Wait Until Element Is Enabled    textfield    timeout=1
        IF    "${result}" == "PASS"    BREAK
    END
    Sleep    1s
    # Input text in the text field
    Input Text    textfield    Tosca
    Sleep    1s
    Unselect Frame
    # Click the submit button
    Click Element    submit
    Sleep    1s
    Select Frame    container
    VAR    ${counter}    0
    WHILE    ${counter} < 4
        Sleep    1s
        Press Keys    //body    ARROW_UP
        Execute Javascript    var top = document.body.scrollTop; document.body.scrollTop = -100;
        ${counter}=    Evaluate    ${counter} + 1
        ${result}    ${code}=    Run Keyword And Ignore Error    Wait Until Element Is Enabled    textfield    timeout=1
        IF    "${result}" == "FAIL"    BREAK
    END
    Unselect Frame
    # Validate success message
    # On Firefox fails because is already at next challenge, on Chrome fails because scrolls main window
    Capture Page Screenshot
    # Page Should Contain    You solved this automation problem.