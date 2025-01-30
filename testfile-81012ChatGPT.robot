*** Settings ***
Library    SeleniumLibrary
Variables  variables.py
Library    String

*** Variables ***
${URL}        https://obstaclecourse.tricentis.com/Obstacles/81012
${ELEMENT_LOCATOR}  xpath=//*[@id='alerttext']

*** Test Cases ***
Obstacle course 12952
    OPEN BROWSER  https://obstaclecourse.tricentis.com/Obstacles/81012

    Wait Until Element Is Visible  xpath=//*[@id='alerttext']
    
    ${full_text}    Get Text    ${ELEMENT_LOCATOR}
    Log To Console   ${full_text}
    ${amount_list}    Get Regexp Matches    ${full_text}    [0-9]+(\.[0-9]+)?
    ${amount}    Set Variable    ${amountlist}[0]  # Extract first match
    Log    Extracted amount: ${amount}
    Log To Console  Extracted amount is: ${amount}
        # Step 2: Remove dollar sign if present
    ${amount_without_dollarsign}    Replace String    ${amount}    $    ${EMPTY}
    Log To Console   Extracted amount (cleaned): ${amount_without_dollarsign}
    sleep  3
    Input Text   totalamountText   ${amount_without_dollarsign}
    Element Should Contain    xpath=//body    You solved this automation problem.
