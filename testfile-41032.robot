*** Settings ***
Library    SeleniumLibrary
Variables  variables.py

*** Variables ***
${URL}        https://obstaclecourse.tricentis.com/Obstacles/41032

*** Test Cases ***
Obstacle course 72954 / two times
    OPEN BROWSER  https://obstaclecourse.tricentis.com/Obstacles/41032
    #
    ${row_count}=    Get Element Count    xpath=//table[@id='rowCountTable']/tr
    Log    The table has ${row_count} rows
    Log To Console  The table has ${row_count} rows
    #
    Click Element  id=lblAmount
    #Input Text  id=lblAmount  ${row_count}
    Execute JavaScript    document.getElementById('lblAmount').innerText = '${row_count}'
    Sleep  2
    Click Element  id=sample
    Execute JavaScript    document.getElementById('lblAmount').outerText = '${row_count}'
    Sleep  2
    #Click Element  id=sample
    Input Text  id=rowcount  ${row_count}
    Click Element  id=sample
    Sleep  2
    Element Should Contain    xpath=//body    You solved this automation problem.

