*** Settings ***
Library    SeleniumLibrary
Library    String
Library    OperatingSystem
Library    Process
Library    pyperclip

*** Variables ***
${BROWSER}    Chrome
${URL}        https://obstaclecourse.tricentis.com/Obstacles/45618
${STRING}     ${EMPTY}

*** Test Cases ***
Obstacle course 45618
    Open Browser    ${URL}    Chrome
    Wait Until Element Is Visible    id=lblGenerated
    Click Element    id=generated
    Sleep  1
    # Perform CTRL+A and CTRL+C to copy text to clipboard
    Press Keys    id=generated    CTRL+A
    Sleep  2
    Press Keys    id=generated    CTRL+C
    # Get Clipboard Text
    Get Clipboard Text
    Log To Console    Generated String: ${STRING}
    
    # Extract parts from the string
    ${first_part}=    Get First Part    ${STRING}
    ${second_part}=    Get Second Part    ${STRING}
    ${third_part}=    Get Third Part    ${STRING}
    
    # Set the extracted values to the respective labels
    Input Text    id=lblFirstNumber    ${first_part}
    Input Text    id=lblSecondNumber    ${second_part}
    Input Text    id=lblThirdNumber    ${third_part}

    # Optionally log the results for verification
    Log    First Part: ${first_part}
    Log    Second Part: ${second_part}
    Log    Third Part: ${third_part}
    
    Close Browser

*** Keywords ***
Get First Part
    [Arguments]    ${string}
    ${match}=    Evaluate    re.search(r'(\d+)', '${string}', modules=re)
    Run Keyword If    ${match} is None    Fail    No match found for first part in: ${string}
    Return From Keyword    ${match.group(1)}

Get Second Part
    [Arguments]    ${string}
    ${match}=    Evaluate    re.search(r'(\d+).*?(\d+)', '${string}', modules=re)
    Run Keyword If    ${match} is None    Fail    No match found for second part in: ${string}
    Return From Keyword    ${match.group(2)}

Get Third Part
    [Arguments]    ${string}
    ${match}=    Evaluate    re.search(r'(\d+).*?(\d+).*?(\d+)', '${string}', modules=re)
    Run Keyword If    ${match} is None    Fail    No match found for third part in: ${string}
    Return From Keyword    ${match.group(3)}

Get Clipboard Text
    ${clipboard_text}=    Evaluate    pyperclip.paste()    modules=pyperclip
    Log    ${clipboard_text}
    Log To Console    ${clipboard_text}
    Set Variable    ${STRING}    ${clipboard_text}
    Return From Keyword    ${clipboard_text}
