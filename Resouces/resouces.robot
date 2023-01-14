*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    Collections

Documentation    Robot Framework Resouces Keywords

*** Keywords ***

Open Chrome Browser
    [Arguments]     ${url}    ${browser}=Chrome
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --incognito
    ${list}=    create list    enable-logging
    Call Method    ${chrome_options}    add_experimental_option    excludeSwitches    ${list}
    # Run Keyword If    os.sep == '/'    Create Webdriver    Chrome    vini-test    chrome_options=${chrome_options}    executable_path=C:\Users\vinic\anaconda3\Scripts\chromedriver.exe
    # ...    ELSE    Create Webdriver    Chrome    vini-test    chrome_options=${chrome_options}
    Open Browser    ${url}    ${browser}    options=${chrome_options}
    Set Window Position    -1080    -1080
    Maximize Browser Window