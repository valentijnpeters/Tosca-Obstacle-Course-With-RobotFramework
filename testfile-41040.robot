*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${URL}        https://obstaclecourse.tricentis.com/Obstacles/41040

*** Test Cases ***
Obstacle course 41040
    OPEN BROWSER  https://obstaclecourse.tricentis.com/Obstacles/41040

    ${ele}    Get WebElement    //input[@id='buttontoclick']
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    Element Should Contain    xpath=//body    You solved this automation problem.
