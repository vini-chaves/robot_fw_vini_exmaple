*** Settings ***
Documentation    Demonstrate Robot Framework Data Driven
Metadata    Version        1.0
Metadata    Author    vchaves
Metadata    Executed By    vchaves

Force Tags    DataDrivenTest

Library    SeleniumLibrary
Librayy    Datadriven

Resource    ../Resouces/resouces.robot
Resource    ../Resouces/login_resouces.robot

Test Setup    Open Chrome Browser    ${url}    Chrome
Test Teardown    Close All Browsers

*** Variables ***

*** Test Case ***

*** Keyvalues ***
