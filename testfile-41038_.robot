*** Settings ***
Library    SeleniumLibrary
Variables  variables.py

*** Variables ***
${URL}        https://obstaclecourse.tricentis.com/Obstacles/41038


*** Test Cases ***
Click On Right Side Of Element
    Open Browser    https://obstaclecourse.tricentis.com/Obstacles/41038   Chrome
    Maximize Browser Window
    Wait Until Element Is Visible    id=halfButton

    # Use JavaScript to calculate the right-side click position and trigger the click
    Execute JavaScript    var element = document.getElementById('halfButton'); var rect = element.getBoundingClientRect(); var x = rect.right - 1; var y = (rect.top + rect.bottom) / 2; element.dispatchEvent(new MouseEvent('click', {clientX: x, clientY: y, bubbles: true}));
    sleep  2
     Element Should Contain    xpath=//body    You solved this automation problem.
    Close Browser



