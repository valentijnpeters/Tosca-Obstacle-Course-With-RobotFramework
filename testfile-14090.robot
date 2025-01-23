*** Settings ***
Library    SeleniumLibrary
Variables  variables.py

*** Variables ***
${URL}        https://obstaclecourse.tricentis.com/Obstacles/14090

*** Test Cases ***
Obstacle course 14090
    OPEN BROWSER  https://obstaclecourse.tricentis.com/Obstacles/14090
    
    Sleep  2
    Click Element  id=generate
    ${ele}    Get WebElement    //*[@id='comboboxTable']/tr/td[2]
    Sleep  1
    # zelfde principe meer
    Click Element  id=generate
    ${row_count}=    Set Variable    5  # Aantal herhalingen (5 keer)
    FOR    ${index}    IN RANGE    2    7  # Dit maakt een bereik van 1 tot 5
        #${ele}=    Get WebElement    //*[@id='comboboxTable']/tr[${index}]/td[2]
        ${ele}=    Get WebElement  //*[table]/table/tr[${index}]/td[2]
        Sleep    1
        Execute Javascript    arguments[0].click();    ARGUMENTS    ${ele}
        ${element_text}=    Get Text    //*[table]/table/tr[${index}]/td[1]
        ${last_letter}=    Evaluate    '${element_text}[-1]'  # Haal het laatste teken op
        Log    The last letter is: ${last_letter}  # Log het laatste teken
        Click Element    //*[table]/table/tr[${index}]/td[2]  # Klik op de cel in de huidige rij
        Press Key    //body    key=${last_letter}  # Druk de laatste letter in
    END
    Click Element  id=submit
    Sleep  10
    Element Should Contain    xpath=//body    You solved this automation problem.

