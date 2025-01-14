*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${URL}        https://obstaclecourse.tricentis.com/Obstacles/24499
${VALUE_TO_COUNT}    {empty}
${count}=    0

*** Test Cases ***
Obstacle course 94441 / and counting
    # TODO: deze een andere keer oppakken, loop er op vast.
    OPEN BROWSER  https://obstaclecourse.tricentis.com/Obstacles/24499
    
    Sleep  2
    ${VALUE_TO_COUNT}=    Get Text    xpath=//*[@id='typeThis']
    Click Element  xpath=//*[@id='autocomplete']/following-sibling::*
  
    Press Keys  xpath=//ul[@class='select2-selection__rendered']   ${VALUE_TO_COUNT}
    ${count}=    Get Element Count    xpath=//select/option[contains(text(), '${VALUE_TO_COUNT}')]

    
    # ${dropdown_items}=    Get WebElements   xpath=//ul[@class='select2-selection__rendered']  # Pas deze XPath aan op basis van de structuur van je dropdown
    # Log To Console  dropdown items zijn: ${dropdown_items}
    # ${dropdown_items_list}=    Evaluate    ${dropdown_items}.split("\\n")  # Split tekst in een lijst per regel

    # FOR    ${item}    IN    @{dropdown_items_list}
    #     ${value_to_count_prefix}=    Evaluate    '${VALUE_TO_COUNT}'[:3]  # Eerste 3 letters van VALUE_TO_COUNT
    #     ${item_prefix}=    Evaluate    '${item}'[:3]  # Eerste 3 letters van de regel
    #     Run Keyword If    '${value_to_count_prefix}' == '${item_prefix}'    Set Variable    ${count}    ${count + 1}
    # END

    Log To Console    Waarde "${VALUE_TO_COUNT}" komt ${count} keer voor in de dropdown.

    Input Text  xpath=//*[@id='entryCount']  text=${count}
    Sleep  3
    Element Should Contain    xpath=//body    You solved this automation problem.

