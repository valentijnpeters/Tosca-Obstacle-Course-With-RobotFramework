*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Variables  variables.py

*** Variables ***
${URL}        https://obstaclecourse.tricentis.com/Obstacles/21269

*** Test Cases ***
Obstacle course 12952
    OPEN BROWSER  https://obstaclecourse.tricentis.com/Obstacles/21269

    ${current_year}    Get Current Date    result_format=%Y
    ${target_year}    Evaluate    ${current_year} + 2
    ${weekday}    Convert Date    ${target_year}-12-25    result_format=%A
    Log    Christmas in ${target_year} falls on: ${weekday}
    Log To Console  Christmas in ${target_year} falls on: ${weekday}
    Input Text        christmasday  text=${weekday}
    Element Should Contain    xpath=//body    You solved this automation problem.
