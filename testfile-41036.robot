*** Settings ***
Library    SeleniumLibrary
Variables  variables.py

*** Variables ***
${URL}        https://obstaclecourse.tricentis.com/Obstacles/41036

*** Test Cases ***
Grab Numbers From Table
    Open Browser  ${URL}  ${BROWSER}
    Wait Until Element Is Visible  xpath=//*[@id='randomTable']
    ${number_1}=  Get Text  xpath=//*[@id='randomTable']/tr[1]/td[1]
    ${number_2}=  Get Text  xpath=//*[@id='randomTable']/tr[1]/td[2]
    ${number_3}=  Get Text  xpath=//*[@id='randomTable']/tr[1]/td[3]
    ${number_4}=  Get Text  xpath=//*[@id='randomTable']/tr[2]/td[1]
    ${number_5}=  Get Text  xpath=//*[@id='randomTable']/tr[2]/td[2]
    ${number_6}=  Get Text  xpath=//*[@id='randomTable']/tr[2]/td[3]
    ${number_7}=  Get Text  xpath=//*[@id='randomTable']/tr[3]/td[1]
    ${number_8}=  Get Text  xpath=//*[@id='randomTable']/tr[3]/td[2]
    ${number_9}=  Get Text  xpath=//*[@id='randomTable']/tr[3]/td[3]
    Log  The numbers are: ${number_1}, ${number_2}, ${number_3}, ${number_4}, ${number_5}, ${number_6}, ${number_7}, ${number_8}, ${number_9}

    ${text}=  Get Text  xpath=//*[@id='lblAmount']
    Log    The text is: ${text}

    # Extract the number manually
    ${start_index}=  Evaluate    '''${text}'''.find('"') + 1
    ${end_index}=    Evaluate    '''${text}'''.find('"', ${start_index})
    ${number}=       Evaluate    '''${text}'''[${start_index}:${end_index}]
    Log              The extracted number is: ${number}

    ${numbers}=  Create List    ${number_1}    ${number_2}    ${number_3}    ${number_4}    ${number_5}    ${number_6}    ${number_7}    ${number_8}    ${number_9}
    
    ${result}=  Run Keyword If    '${number}' in ${numbers}    Set Variable    True    ELSE    Set Variable    False
    Log        The result is: ${result}
    
    Input Text  xpath=//*[@id='resulttext']    ${result}
    Sleep  2
    Close Browser
