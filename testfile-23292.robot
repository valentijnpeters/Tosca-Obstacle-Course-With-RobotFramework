*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}            https://obstaclecourse.tricentis.com/Obstacles/23292
${SOURCE_TABLE_ID}    todo-tasks
${TARGET_TABLE_ID}    completed-tasks
${index}    1
${BROWSER}    Chrome

*** Test Cases ***
Drag And Drop All Tasks
    Open Browser    ${URL}
    ${rows}=    Get Rows From Table    ${SOURCE_TABLE_ID}
    ${target_table}=    Get WebElement    id=${TARGET_TABLE_ID}
    
    # We gaan nu door alle rijen met een index en slepen ze naar de target table
    Log To Console  ${rows}
    Drag And Drop Rows    ${rows}    ${target_table}
    Close Browser

*** Keywords ***
Get Rows From Table
    [Arguments]    ${table_id}
    ${rows}=    Get WebElements    xpath=//table[@id='${table_id}']//tr
    RETURN    ${rows}

Drag And Drop Rows
    [Arguments]    ${rows}    ${target_table}
    Set Variable    ${index}    1  # Start bij 1
    FOR    ${row}    IN    @{rows}
        # Zoek de <td> met de tekst die overeenkomt met de waarde van ${index}
        ${td}=    Get WebElement    xpath=//tr[td[text()='${index}']]
        Log To Console    message=current is ${index}
        Run Keyword If    ${td}    Drag And Drop Row    ${td}    ${target_table}
        # Verhoog de index
        Set Variable    ${index} + 1
    END

Drag And Drop Row
    [Arguments]    ${source}    ${target}
    Drag And Drop    ${source}    ${target}



