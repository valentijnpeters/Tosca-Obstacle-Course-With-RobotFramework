*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${WEB_ELEMENT_LOCATOR}    xpath=//div[@id='alerttext']  # Replace with the actual locator

*** Test Cases ***
Extract Amount from Web Element
    OPEN BROWSER  https://obstaclecourse.tricentis.com/Obstacles/81012
    Wait Until Element Is Visible    ${WEB_ELEMENT_LOCATOR}
    
    # Step 1: Get the text from the web element
    ${text}=    Get Text    ${WEB_ELEMENT_LOCATOR}
    
    # Step 2: Use regex to extract the amount (e.g., 1729.23)
    ${amount}=    Get Regexp Matches    ${text}    \\d+\\.\\d+    0
    
    # Step 3: Log or use the extracted amount
    Log    Extracted Amount: ${amount}
    Log To Console  Extracted Amount: ${amount}
    ${amountpuur}=    Set Variable    ${amount}[0]
    
    # Example assertion
    #Should Be Equal As Strings    ${amount}    1729.23
    
    sleep  3
    Input Text   totalamountText   ${amountpuur}
    Element Should Contain    xpath=//body    You solved this automation problem.

# notes: the RegEx of ChatGPT was 3x wrong. the RegEx of DeepSeek was 1st time right.
# DeepSeek had a strange equation that didn't make any sense at all.   
# #Should Be Equal As Strings    ${amount}    1729.23    which means DeepSeek took something too literaly.
# 1+ for DeepSeek (RegEx), 1+ for ChatGPT No strange equation that broke the script.
# +1 for ChatGPT extract the pure value from the list (by forehand)
