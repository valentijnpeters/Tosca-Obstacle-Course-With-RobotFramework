*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${URL}        https://obstaclecourse.tricentis.com/Obstacles/72954

*** Test Cases ***
Obstacle course 72954 / two times
    OPEN BROWSER  https://obstaclecourse.tricentis.com/Obstacles/72954
    #
    Wait Until Element Is Visible  //*[@id[starts-with(., 'rnd_')]]
    Click Element   //*[@id[starts-with(., 'rnd_')]]
    Sleep  1
    Click Element   //*[@id[starts-with(., 'rnd_')]]
    #
    Element Should Contain    xpath=//body    You solved this automation problem.

