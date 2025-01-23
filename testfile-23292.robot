*** Settings ***
Library    SeleniumLibrary
Variables  variables.py

*** Variables ***
${URL}            https://obstaclecourse.tricentis.com/Obstacles/23292
${SOURCE_TABLE_ID}    todo-tasks
${TARGET_TABLE_ID}    completed-tasks

*** Test Cases ***
Drag And Drop All Tasks
    [Setup]    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    id=${SOURCE_TABLE_ID}
    ${rows}=    Get Rows From Table    ${SOURCE_TABLE_ID}
    ${target_table}=    Get WebElement    id=${TARGET_TABLE_ID}
    Log To Console    Found ${rows} rows to drag and drop.
    Drag And Drop Rows    ${rows}    ${target_table}
    [Teardown]    Close Browser

*** Keywords ***
Get Rows From Table
    [Arguments]    ${table_id}
    ${rows}=    Get WebElements    xpath=//table[@id='${table_id}']//tr
    Log To Console    Found ${rows} rows in the table.
    RETURN    ${rows}

Drag And Drop Rows
    [Arguments]    ${rows}    ${target_table}
    ${row_count}=    Get Length    ${rows}
    Log To Console    Total rows to process: ${row_count}.
    # -2? TH en de onderste.
    FOR    ${i}    IN RANGE    1    ${row_count - 2}
        ${td}=    Get WebElement    xpath=//tr[td[text()='${i}']]
        Log To Console    Dragging row ${i}.
        Drag And Drop Row    ${td}    ${target_table}
    END

Drag And Drop Row
    [Arguments]    ${source}    ${target}
    Drag And Drop    ${source}    ${target}
    Log To Console    Successfully dragged ${source} to ${target}.





