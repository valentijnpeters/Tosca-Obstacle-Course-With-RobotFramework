*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${URL}        https://obstaclecourse.tricentis.com/Obstacles/12952

*** Test Cases ***
Obstacle course 12952
    OPEN BROWSER  https://obstaclecourse.tricentis.com/Obstacles/12952

    Wait Until Element Is Visible  xpath=//*[@id='id']
    ${ele}    Get WebElement    xpath=//*[@id='thisoneistheright']//*[text()='I am the one!']
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    Element Should Contain    xpath=//body    You solved this automation problem.
