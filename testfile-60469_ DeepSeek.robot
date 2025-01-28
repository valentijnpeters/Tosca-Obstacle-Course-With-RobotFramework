*** Settings ***
Library    SeleniumLibrary
Library    CustomPythonLibrary.py  WITH NAME    CustomLib
Variables  variables.py

*** Variables ***
${URL}            https://obstaclecourse.tricentis.com/Obstacles/60469
${TARGET}         //div[@id='to']
${DRAGGABLE}      xpath=//*[@id='toscabot']
${VERIFICATION_LOCATOR}  //body
${VERIFICATION_TEXT}     Good job!
${RUN_STATUS}  {empty}

*** Test Cases ***
Drag And Drop With Failsafe Test
    Open Browser    ${URL}    Chrome
    Wait Until Element Is Visible  ${TARGET}
    Run Drag And Drop With Failsafe    ${DRAGGABLE}    ${TARGET}    ${VERIFICATION_LOCATOR}    ${VERIFICATION_TEXT}

*** Keywords ***
Run Drag And Drop With Failsafe
    [Arguments]    ${draggable}    ${target}    ${verification_locator}    ${verification_text}
    ${status}    Run Keyword And Return Status    Drag And Drop With Verification    ${draggable}    ${target}    ${verification_locator}    ${verification_text}
    Run Keyword If    '${status}' == 'False'    Run Custom Drag And Drop Method    ${draggable}    ${target}    ${verification_locator}    ${verification_text}
    Element Should Contain    ${verification_locator}    ${verification_text}

    #RBFW Domain Specific Language
Drag And Drop With Verification
    [Arguments]    ${draggable}    ${target}    ${verification_locator}    ${verification_text}
    Drag And Drop    ${draggable}    ${target}
    Element Should Contain    ${verification_locator}    ${verification_text}

    #Custom .py library
Run Custom Drag And Drop Method
    [Arguments]    ${draggable}    ${target}    ${verification_locator}    ${verification_text}
    CustomLib.custom_drag_and_drop_with_failsafe    ${draggable}    ${target}    ${verification_locator}    ${verification_text}
    Element Should Contain    ${verification_locator}    ${verification_text}
