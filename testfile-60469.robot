*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}            https://obstaclecourse.tricentis.com/Obstacles/60469
${SOURCE_XPATH}   //div[@id='from']  # Replace with the actual source element XPath
${TARGET_XPATH}   //div[@id='to']    # Replace with the actual target element XPath
${DRAGGABLE_ID}   toscabot            # The ID of the element to drag

*** Test Cases ***
Drag And Drop Test
    Open Browser    ${URL}    chrome
    ${source}=    Get WebElement    ${SOURCE_XPATH}
    ${target}=    Get WebElement    ${TARGET_XPATH}
    ${draggable}=    Get WebElement    id=${DRAGGABLE_ID}
    
    # Perform drag and drop using the source and target
    Drag And Drop    ${draggable}    ${target}
   
    Sleep  3
    Element Should Contain    xpath=//body    You solved this automation problem.

