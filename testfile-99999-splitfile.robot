*** Settings ***
Library    SeleniumLibrary
Library    CustomAction1.py  # Import the custom actions file
Library    CustomAction2.py  # Import the custom actions file
Library    CustomActionsIntegrated.py
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

    # Access the location array using indexes for x and y
    ${click_x}=    Set Variable    ${location}[0]
    ${click_y}=    Set Variable    ${location}[1]

    # Scroll to make the click area visible
    Execute JavaScript    window.scrollTo(0, ${click_y} - 200);
    #Sleep    1s

    # Draw the red dot using the custom keyword
    Draw Red Dot    ${click_x}    ${click_y}
    #Sleep    1s

    # Click the page at the specified coordinates using the custom keyword
    #Click Page At Coordinates  ${click_x}    ${click_y}
    #Sleep    1s
    
    #combined
    Draw Dot and Click At Coordinates   ${click_x}  ${click_y}
    #Draw Dot and Click At Coordinates  ${click_x}  ${click_y}

    # Wait for the page to respond before proceeding
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