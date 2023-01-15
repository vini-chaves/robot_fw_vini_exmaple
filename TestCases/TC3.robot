*** Settings ***
Documentation    Demonstrate Robot Framework Data Driven Library
Metadata    Version        1.0
Metadata    Author    vchaves
Metadata    Executed By    vchaves

Library    SeleniumLibrary
Library    DataDriver    file_search_strategy=None

Resource    ../Resouces/resouces.robot
Resource    ../Resouces/login_resouces.robot

Suite Setup    Open Chrome Browser    https://admin-demo.nopcommerce.com/    headlesschrome
Suite Teardown    Close All Browsers
Test Setup        Open Login Page
Test Template    Invalid Login

*** Test Case ***        username    password
TC1: Correct User / Empty password    admin@yourstore.com    ${EMPTY}
TC2: Correct User / Wrong password    admin@yourstore.com    admin123
TC3: Wrong User / Correct password    admin123@yourstore.com    admin
TC4: Wrong User / Empty password    admin123@yourstore.com    ${EMPTY}
TC5: Wrong User / Wrong password    admin123@yourstore.com    admin123
    

*** Keywords ***
Invalid Login
    [Arguments]    ${username}    ${password}
    Input username    ${username}
    Input pwd    ${password}
    Click Login Button
    Unsucessful login validation should be visible