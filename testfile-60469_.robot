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
    # Probeer eerst de standaard methode in Robot Framework
    Run Drag And Drop With Failsafe    ${DRAGGABLE}    ${TARGET}    ${VERIFICATION_LOCATOR}    ${VERIFICATION_TEXT}

*** Keywords ***
Run Drag And Drop With Failsafe
    [Arguments]    ${draggable}    ${target}    ${verification_locator}    ${verification_text}
    # Probeer eerst de standaard Robot Framework drag-and-drop
    Run Keyword And Ignore Error    Drag And Drop With Verification    ${draggable}    ${target}    ${verification_locator}    ${verification_text}
    # Als dat faalt, roep dan de Python methode aan
    Run Keyword If    '${RUN_STATUS}' == 'FAIL'    Run Custom Drag And Drop Method    ${draggable}    ${target}    ${verification_locator}    ${verification_text}
    # Verifieer de tekst na het uitvoeren van een van de methoden
    Element Should Contain    ${verification_locator}    ${verification_text}

Drag And Drop With Verification
    [Arguments]    ${draggable}    ${target}    ${verification_locator}    ${verification_text}
    # Standaard robotframework drag-and-drop
    Drag And Drop    ${draggable}    ${target}
    # Controleer of de tekst aanwezig is
    Element Should Contain    ${verification_locator}    ${verification_text}

Run Custom Drag And Drop Method
    [Arguments]    ${draggable}    ${target}    ${verification_locator}    ${verification_text}
    # Roep de Python-functie aan als de standaard robotframework methode faalt
    CustomLib.custom_drag_and_drop_with_failsafe    ${draggable}    ${target}    ${verification_locator}    ${verification_text}
    # Verifieer opnieuw de tekst na het uitvoeren van de Python-methode
    Element Should Contain    ${verification_locator}    ${verification_text}
