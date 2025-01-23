*** Settings ***
Library    SeleniumLibrary
Variables  variables.py

*** Variables ***
${URL}        https://obstaclecourse.tricentis.com/Obstacles/22505

*** Test Cases ***
Obstacle course 22505
    OPEN BROWSER  https://obstaclecourse.tricentis.com/Obstacles/22505

    ${ele}    Get WebElement    xpath=//*[text()='Click me!']
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    Element Should Contain    xpath=//body    You solved this automation problem.
