*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}              https://obstaclecourse.tricentis.com/Obstacles/82018
${INSTRUCTIONS}     id=text
${SUCCESS_TEXT}     You solved this automation problem.

*** Test Cases ***
Handle Browser Closure Gracefully
    Open Browser    https://obstaclecourse.tricentis.com/Obstacles/82018    Chrome
    Maximize Browser Window
    Click Element    id=start

    WHILE    True
        ${status}=    Run Keyword And Ignore Error    Get Text    id=text
        Run Keyword If    '${status}[0]' == 'FAIL'    Log    Browser window closed. Exiting loop.    WARN
        Run Keyword If    '${status}[0]' == 'FAIL'    Exit For Loop

        ${text}=    Set Variable    ${status}[1]
        Log    Current instruction: ${text}

        Run Keyword If    '${text}' == 'You solved this automation problem.'    Log    Success!    INFO
        Run Keyword If    '${text}' == 'You solved this automation problem.'    Exit For Loop

        Run Keyword If    '${text}' == 'Go left!'    Execute Javascript    window.dispatchEvent(new KeyboardEvent('keydown', {key: 'ArrowLeft'}));
        Run Keyword If    '${text}' == 'Go right!'   Execute Javascript    window.dispatchEvent(new KeyboardEvent('keydown', {key: 'ArrowRight'}));

        Run Keyword If    '${text}' == 'Go left!'    Press Keys    //body    LEFT
        Run Keyword If    '${text}' == 'Go right!'   Press Keys    //body    RIGHT

        Sleep    0.1
    END

    Close Browser





