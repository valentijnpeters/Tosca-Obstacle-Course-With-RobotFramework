*** Settings ***
Library    SeleniumLibrary
Variables  variables.py

*** Variables ***
${URL}        https://obstaclecourse.tricentis.com/Obstacles/99999

*** Test Cases ***
Visueel Klikken Onder Submit
    Open Browser    ${URL}   Chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//*[@id='submit']

    # Get element's position using JavaScript
    ${location}=    Execute JavaScript
    ...    var rect = document.evaluate("//*[@id='submit']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.getBoundingClientRect();
    ...    return [rect.left + (rect.width / 2) + 132, rect.top + window.scrollY + 130];

    ${click_x}=    Set Variable    ${location}[0]
    ${click_y}=    Set Variable    ${location}[1]

    # Scroll to make the click area visible
    Execute JavaScript    window.scrollTo(0, ${click_y} - 200);
    Sleep    1s

    # Draw a red circle at the click location (just for debugging purposes)
    Execute JavaScript
    ...    var marker = document.createElement('div');
    ...    marker.style.position = 'absolute';
    ...    marker.style.left = '${click_x}px';
    ...    marker.style.top = '${click_y}px';
    ...    marker.style.width = '20px';
    ...    marker.style.height = '20px';
    ...    marker.style.backgroundColor = 'red';
    ...    marker.style.borderRadius = '50%';
    ...    marker.style.zIndex = '9999';
    ...    marker.style.pointerEvents = 'none';
    ...    marker.style.border = '2px solid black';
    ...    document.body.appendChild(marker);

    # Wait a bit so you can see the dot
    Sleep    1s

    # Scroll again to ensure the element is fully visible in the viewport
    Execute JavaScript    window.scrollTo(0, ${click_y} - 200);
    Sleep    1s

    # Click at the exact location (Now with improved visibility)
    Click Element At Coordinates    xpath=//*[@id='submit']    132    130

    # Wait for the page to respond before proceeding
    Sleep    1s

    # Scroll down to bring up more content (if required)
    Press Keys  //body       PAGE_DOWN
    Sleep    2s

    # Ensure overlay2 is visible (if needed)
    #Execute JavaScript    document.getElementById('textfield').scrollIntoView()

    # Input text in the text field
    Input Text  xpath=//*[@id='textfield']  Tosca
    Sleep    1s

    # Drag overlay2 down
    #Drag And Drop By Offset    id=overlay2    0    100
    Sleep    2s
    
    # Click the submit button again
    Click Element   xpath=//*[@id='submit'] 

    # Validate success message
    Element Should Contain    xpath=//body    You solved this automation problem.



