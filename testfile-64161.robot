*** Settings ***
Library    SeleniumLibrary
Variables  variables.py


*** Variables ***
${URL}        https://obstaclecourse.tricentis.com/Obstacles/64161

*** Test Cases ***
Obstacle course 64161
    OPEN BROWSER  https://obstaclecourse.tricentis.com/Obstacles/64161
    
    Sleep  2
    Click Element  id=generate
    ${ele}    Get WebElement    //*[@id='comboboxTable']/tr/td[2]
    Sleep  1
    #
    Click Element  id=generate
    ${element_text}=    Get Text    //*[text()='order id']/following-sibling::*[1]
    Input Text  locator=offerId   text=${element_text}
    Element Should Contain    xpath=//body    You solved this automation problem.

