*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${URL}        https://obstaclecourse.tricentis.com/Obstacles/70924

*** Test Cases ***
Obstacle course 12952
    [Documentation]    This test interacts with buttons on the obstacle course website.
    OPEN BROWSER    ${URL}    ${BROWSER}
    MAXIMIZE BROWSER WINDOW
    Wait Until Element Is Visible    xpath=//*[@id='b1']

    ${attempts} =    Set Variable    10
    ${index} =    Set Variable    0

    WHILE    ${index} < ${attempts}
    ${is_present}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//*[@id='b1']
    IF    ${is_present}
        ${ele}=    Get WebElement    xpath=//*[@id='b1']
        Execute Javascript    arguments[0].click();    ARGUMENTS    ${ele}
        Sleep    0.1
        ${index}=    Set Variable    ${index} + 1
    ELSE
        ${tech_button_present}=    Run Keyword And Return Status    Element Should Be Visible    id=tech
        IF    ${tech_button_present}
            Click Button    id=tech
            Log    Resetting attempts after pressing 'tech'
            ${index} =    Set Variable    0
        ELSE
            Log    Tech button is not available
            ${index}=    Set Variable    ${index} + 1
        END
    END
    END

    Element Should Contain    xpath=//body    You solved this automation problem.
    Close Browser