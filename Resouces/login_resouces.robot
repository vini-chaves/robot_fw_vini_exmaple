*** Settings ***
Documentation    Robot Framework various Data Driven test example
Library    SeleniumLibrary
Library    BuiltIn
Library    Collections

Resource    ../Resouces/resouces.robot

*** Variables ***
${LOGIN_URL}    https://admin-demo.nopcommerce.com/

*** Keywords ***
Open Login Page
    Go to    ${LOGIN_URL}
Input Username
    [Arguments]    ${username}
    input text    id:Email   ${username}
Input PWD
    [Arguments]    ${pwd}
    input text    id:Password   ${pwd}
Click Login Button
    Click Button    xpath://button[@class="button-1 login-button"]
Click Logout Link
    Click link    /logout
Unsucessful login validation should be visible
    Page should contain    Login was unsuccessful.
Dashboad page should be visible
    Page should contain    xpath://h1[contains(text(),'Dashboard')]

