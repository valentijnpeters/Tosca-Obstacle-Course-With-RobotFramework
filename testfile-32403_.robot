*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Variables  variables.py

*** Variables ***
${URL}        https://obstaclecourse.tricentis.com/Obstacles/32403

*** Test Cases ***
Obstacle course 32403
    OPEN BROWSER  ${URL}
    Wait Until Element Is Visible  xpath=//*[@id='no1']
    
    ${no1}    Get Text    xpath=//*[@id='no1']
    Log To Console  ${no1}
    
    ${no2}    Get Text    xpath=//*[@id='no2']
    Log To Console  ${no2}
    
    ${symbol1}    Get Text    xpath=//*[@id='symbol1']
    Log To Console  ${symbol1}
    
    ${no1_float}    Convert To Number    ${no1}
    ${no2_float}    Convert To Number    ${no2}
    
    # Perform the operation based on the symbol
    Run Calculation    ${symbol1}    ${no1_float}    ${no2_float}

    Element Should Contain    xpath=//body    You solved this automation problem.

*** Keywords ***
Run Calculation
    [Arguments]    ${symbol}    ${no1}    ${no2}
    Run Keyword If    '${symbol}' == '+'    Sum    ${no1}    ${no2}
    Run Keyword If    '${symbol}' == '-'    Subtract    ${no1}    ${no2}
    Run Keyword If    '${symbol}' == '*'    Multiply    ${no1}    ${no2}
    Run Keyword If    '${symbol}' == '/'    Divide    ${no1}    ${no2}

Sum
    [Arguments]    ${no1}    ${no2}
    ${result}    Evaluate    ${no1} + ${no2}
    Log To Console    The result of addition is: ${result}

    Input Text    xpath=//*[@id='result']    ${result}

Subtract
    [Arguments]    ${no1}    ${no2}
    ${result}    Evaluate    ${no1} - ${no2}
    Log To Console    The result of subtraction is: ${result}

    Input Text    xpath=//*[@id='result']    ${result}

Multiply
    [Arguments]    ${no1}    ${no2}
    ${result}    Evaluate    ${no1} * ${no2}
    Log To Console    The result of multiplication is: ${result}

    Input Text    xpath=//*[@id='result']    ${result}

Divide
    [Arguments]    ${no1}    ${no2}
    ${result}    Evaluate    ${no1} / ${no2}
    Log To Console    The result of division is: ${result}

    Input Text    xpath=//*[@id='result']    ${result}

