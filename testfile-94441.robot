*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${URL}        https://obstaclecourse.tricentis.com/Obstacles/94441

*** Test Cases ***
Obstacle course 94441 / testing methods
    OPEN BROWSER  https://obstaclecourse.tricentis.com/Obstacles/94441
    #
    Wait Until Element Is Visible  //option[text()='Functional testing']
    Execute Javascript    var shiftKeyDown = new KeyboardEvent('keydown', {key: 'Shift'}); document.dispatchEvent(shiftKeyDown);
    Click Element    //option[text()='Functional testing']
    Click Element    //option[text()='End2End testing']
    Click Element    //option[text()='GUI testing']
    Click Element    //option[text()='Exploratory testing']
    Execute Javascript    var shiftKeyUp = new KeyboardEvent('keyup', {key: 'Shift'}); document.dispatchEvent(shiftKeyUp)
    #
    Element Should Contain    xpath=//body    You solved this automation problem.

