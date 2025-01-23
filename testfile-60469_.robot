*** Settings ***
Library    SeleniumLibrary
Library    CustomPythonLibrary.py  WITH NAME    CustomLib
Variables  variables.py

*** Variables ***
${URL}            https://obstaclecourse.tricentis.com/Obstacles/60469
${SOURCE_XPATH}   //div[@id='from']
${TARGET_XPATH}   //div[@id='to']
${DRAGGABLE_ID}   //*[@id='toscabot']

*** Test Cases ***
Drag And Drop Test
    Open Browser    ${URL}
    Wait Until Element Is Visible  ${SOURCE_XPATH}
    Wait Until Element Is Visible  ${TARGET_XPATH}
    
    ${source}=    Get WebElement    ${SOURCE_XPATH}
    ${target}=    Get WebElement    ${TARGET_XPATH}
    ${draggable}=    Get WebElement    ${DRAGGABLE_ID}

    # Call the custom function with two arguments
    CustomLib.custom_drag_and_drop    ${draggable}    ${target}

    Sleep  3
    Element Should Contain    xpath=//body    You solved this automation problem.






