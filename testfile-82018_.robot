*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}              https://obstaclecourse.tricentis.com/Obstacles/82018
${INSTRUCTIONS}     css:div.instructions
${SUCCESS_TEXT}     You solved this automation problem.

*** Test Cases ***

Follow Dynamic Instructions
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Sleep  1
    Click Element  id=start
    Wait Until Element Is Visible    ${INSTRUCTIONS}
    
    # Wait for "Prepare for the start!" text
    WHILE    True
        ${text}=    Get Text    ${INSTRUCTIONS}
        Log    Current text: ${text}
        Run Keyword If    '${text}' == 'Prepare for the start!'    Exit For Loop
        Sleep    1
    END
    
    # Once "Prepare for the start!" is found, check for "Go left!" or "Go right!"
    WHILE    True
        ${text}=    Get Text    ${INSTRUCTIONS}
        Log    Current instruction: ${text}
        
        Run Keyword If    '${text}' == 'Go left!'    Press Key    //body    LEFT
        Run Keyword If    '${text}' == 'Go right!'   Press Key    //body    RIGHT
        
        # Check if neither "Go left!" nor "Go right!" appears, exit the loop
        ${instruction_text}=    Get Text    xpath=//*[@id='text']
        Run Keyword If    '${instruction_text}' not contains 'LEFT' and '${instruction_text}' not contains 'RIGHT'    Exit For Loop
        
        Sleep    1
    END
    
    Log    Successfully followed instructions!
    Close Browser



