*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn

Resource    ../Resouces/resouces.robot

*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/

*** Test Cases ***
LoginTest
    [Documentation]    Test Case to demonstrate robot Framework various applications

    Open Chrome Browser
    Set Selenium Implicit Wait    1s
    Go To    ${URL}
    Title Should Be    OrangeHRM
    ${"email_txt"}    set variable    identifier:username
    ${"password_txt"}   set variable    identifier:password
    element should be visible    ${"email_txt"}
    element should be enabled    ${"email_txt"}
    element should be visible    ${"password_txt"}
    element should be enabled    ${"password_txt"}
    input text    ${"email_txt"}   Admin
    input text    ${"password_txt"}   admin123
    click element    css:div[class^='oxd-form-actions orangehrm-login-action']
    Element Text Should Be    css:h6[class*='oxd-topbar-header-breadcrumb-module']    Dashboard
    Sleep    2s
    Close Browser