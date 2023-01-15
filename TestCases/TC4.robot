*** Settings ***
Documentation    Demonstrate Robot Framework Data Driven Library
Metadata    Version        1.0
Metadata    Author    vchaves
Metadata    Executed By    vchaves

Library    SeleniumLibrary
Library    DataDriver    TestData/LoginData.xlsx    sheet_name=Sheet1

Resource    ../Resouces/resouces.robot
Resource    ../Resouces/login_resouces.robot

Suite Setup    Open Chrome Browser    https://admin-demo.nopcommerce.com/
Suite Teardown    Close All Browsers

Test Setup        Open Login Page
Test Template    Invalid Login

*** Test Case ***
TestCase Invalid Login using: ${username} / ${password}

*** Keywords ***
Invalid Login
    [Arguments]    ${username}    ${password}
    Input username    ${username}
    Input pwd    ${password}
    Click Login Button
    Unsucessful login validation should be visible