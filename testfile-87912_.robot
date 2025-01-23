*** Settings ***
Library    SeleniumLibrary
Library    String
Variables  variables.py

*** Variables ***
${URL}        https://obstaclecourse.tricentis.com/Obstacles/87912
${BOOKS_ID}   books
${BOOK_TITLE}  Testing Computer Software

*** Test Cases ***
Grab ISBN For Testing Computer Software
    [Setup]    Open Browser    ${URL}    ${BROWSER}
    Wait Until Element Is Visible    xpath=//*[@id='loadbooks']    timeout=10
    Click Element    xpath=//*[@id='loadbooks']
    Wait Until Element Is Visible    id=${BOOKS_ID}    timeout=10
    ${isbn}=    Get ISBN Directly    ${BOOK_TITLE}
    Input Text    id=isbn    ${isbn}
    Element Should Contain    xpath=//body    You solved this automation problem.

*** Keywords ***
Get ISBN Directly
    [Arguments]    ${book_title}
    ${books_text}=    Execute Javascript    return document.getElementById("${BOOKS_ID}").value;
    ${pattern}=    Evaluate    r'<title>{}</title>.*?<isbn>([0-9\-]+)</isbn>'.format(${book_title})
    ${matches}=    Get Regexp Matches    ${books_text}    ${pattern}
    Run Keyword Unless    ${matches}    Fail    ISBN not found for '${book_title}'
    Return From Keyword    ${matches[0][0]}





