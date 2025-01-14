*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${URL}        https://obstaclecourse.tricentis.com/Obstacles/51130

*** Test Cases ***
Obstacle course 12952
    OPEN BROWSER  https://obstaclecourse.tricentis.com/Obstacles/51130

    ${ele}    Get WebElement    xpath=//*[@id='button']
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele}
    ${window_handles}=    Get Window Handles
    # Als het nieuwe venster het tweede venster is
    Switch Window    ${window_handles[1]}
    Close Window
