*** Settings ***
Documentation    Demonstrate Robot Framework various applications
Metadata    Version        2.0
Metadata    Author    vchaves
Metadata    Executed By    vchaves

Force Tags    Example

Library    SeleniumLibrary
Library    Collections
Library    ExcelRobot    
Library    OperatingSystem
Library    String
Library    Process

Resource    ../Resouces/resouces.robot

Test Setup    Open Chrome Browser    ${url}    headlesschrome
Test Teardown    Close All Browsers

*** Variables ***
${url}    https://google.com/
${URL01}    https://vctcpune.com/
${URL02}    https://vctcpune.com/selenium/practice.html
${COUNTRY}    Brasil
${USERNAME}    Vinicius
${OUTPUT_DIR}    C:/Users/vinic/PycharmProjects/robot_intro/Reports

*** Test Cases ***
TestElements01
    [Documentation]    Test Case 01 open browser multi-tabs
    [Tags]    OpenVariousWindows

    # Main page
    Go To    ${URL01}
    Title Should Be    Velocity | Best software testing centre in Pune and Mumbai
    Scroll Element Into View    css:a[class^='et_pb_button et_pb_button_0 et_pb_bg_layout_light']
    # Prctice page
    Click Link    https://vctcpune.com/selenium/practice.html
    Switch Window    NEW
    # Open new tab button
    Scroll Element Into View    id:serviceid
    Click Element    xpath=//a[contains(text(), 'Open Tab')]
    Switch Window    NEW
    Title Should Be    Velocity | Best software testing centre in Pune and Mumbai

TestElements02
    [Documentation]    Test Case 02 various page actions
    [Tags]    PerformActions

    # Main page
    Go To    ${URL02}
    # Selection of radio buttons
    Scroll Element Into View    id:serviceid1
    Select Radio Button    radio    Radio1
    # Intup Text to Textbox
    Input Text    id:autocomplete    ${COUNTRY}
    # Select dropdown list
    Select From List By Value    id:dropdown-class-example    option2
    # Select Checkbox
    Select Checkbox    checkBoxOption1
    Select Checkbox    checkBoxOption2
    Select Checkbox    checkBoxOption3
    Sleep    1s
    Unselect Checkbox    checkBoxOption3
    # Enter a username and click on alert button (handle Alert)
    Input Text    name:enter-name    ${USERNAME}
    Click Button    id:alertbtn
    Alert Should Be Present    text=Hello ${USERNAME}, share this practice page and share your knowledge    timeout=2s
    Input Text    name:enter-name    ${USERNAME}
    Click Button    id:confirmbtn
    Alert Should Be Present    text=Hello ${USERNAME}, Are you sure you want to confirm?    timeout=2s
    # Click on hide/show buttons and confirm behavior
    Scroll Element Into View    class:services-div3
    Click Button    id:hide-textbox
    Element Should Not Be Visible  id:displayed-text
    Click Button    id:show-textbox
    Element Should Be Visible  id:displayed-text
    # Hover mouse over
    Scroll Element Into View    class:services-div4
    mouse over    id:mousehover
    Element Should Be Visible    xpath://a[contains(text(),'Top')]
    Element Should Be Visible    xpath://a[contains(text(),'Reload')]

TestElements03
    [Documentation]    Test Case 03 iframe actions
    [Tags]    PerformActions    

    Close Browser
    Open Chrome Browser    ${URL02}    Chrome
    Scroll Element Into View    class:services-div7
    Select Frame    id:courses-iframe
    Wait Until Element Is Visible   xpath://*[@id="top-menu"]/li/*[@href="https://vctcpune.com/courses/"]
    Click Link    https://vctcpune.com/courses/
    Unselect Frame
    Switch Window    title:Practice Page
    Scroll Element Into View    class:services-div1
    Select Checkbox    checkBoxOption2
    Select Checkbox    checkBoxOption3

TestElements04
    [Documentation]    Test Case 04 multi-windows actions
    [Tags]    OpenVariousWindows

    Open Chrome Browser    https://bing.com/    headlesschrome
    switch browser    1
    ${title1}=    get title
    log to console    ${title1}
    switch browser    2
    ${title2}=    get title
    log to console    ${title2}
    ${loc2}=    get location
    log to console    ${loc2}
    switch browser    1
    ${loc1}=    get location
    log to console    ${loc1}
    close all browsers

TestElements05
    [Documentation]    Test Case 05 Screenshot actions
    [Tags]    ScreenshotActions

    Set Selenium Implicit Wait    1s
    Go To    https://opensource-demo.orangehrmlive.com/
    ${"email_txt"}    set variable    identifier:username
    ${"password_txt"}   set variable    identifier:password
    input text    ${"email_txt"}   Admin
    input text    ${"password_txt"}   admin123
    capture element screenshot    class:orangehrm-login-branding    ./Reports/screenshot-logo.png
    capture page screenshot    ./Reports/screenshot-page.png

TestElements06
    [Documentation]    Test Case 06 Mouse actions
    [Tags]    MouseActions

    # Right click action
    Go To    https://swisnl.github.io/jQuery-contextMenu/demo.html
    open context menu    xpath://span[contains(text(),'right click me')]
    sleep    3

    #Double click action
    #double click element    xpath://span[contains(text(),'right click me')]
    #sleep    3

    # Drag and drop
    go to    http://www.dhtmlgoodies.com/scripts/drag-drop-custom/demo-drag-drop-3.html

    FOR    ${i}     IN RANGE    1    8
        drag and drop    id:box${i}    id:box10${i}
    END
    sleep    3

TestElements07
    [Documentation]    Test Case 07 Get Liks actions and Excel write action
    [Tags]    GetLiksPlusExcel    robot:skip

    ${OUTPUT_EXCEL}    set variable    out.xlsx
    ${DOWNLOAD_DIR}    set variable    C:/Users/vinic/PycharmProjects/robot_intro/Resouces/Download
    #Creates directory if it not exists
    Create Directory    ${OUTPUT_DIR}
    Create Directory    ${DOWNLOAD_DIR}
    Empty Directory    ${DOWNLOAD_DIR}
    #Removes previos out.xlsx file form output ditectory if exists
    @{files}=    List Files In Directory	${OUTPUT_DIR}	${OUTPUT_EXCEL}
    IF    "${OUTPUT_EXCEL}" in @{files}
        Remove File    ${OUTPUT_DIR}/${OUTPUT_EXCEL}
    END
    #Creates new out.xlsx file for this new run at the test case
    Open Excel To Write    ${OUTPUT_DIR}/${OUTPUT_EXCEL}
    #Write excel header line
    Write To Cell By Name    Sheet    A1    Country_Name
    Write To Cell By Name    Sheet    B1    URL
    Write To Cell By Name    Sheet    C1    File_Path
    #Go to web page to get the page info
    Go to    https://en.wikipedia.org/wiki/Gallery_of_sovereign_state_flags
    # Count number of liks on the page
    ${AllLiksCount}=    Get Element Count    xpath://div[@class="gallerytext"]/p/a
    log to console    ${AllLiksCount}

    #Loops all the elements of intrest and write in the output excel file
    FOR      ${i}    IN RANGE    1    ${AllLiksCount}+1
        ${LinkText}=    get text    xpath:(//div[@class="gallerytext"]/p/a)[${i}]
        ${LinkText}=    Replace String    ${LinkText}    ,    ${EMPTY}
        ${loc}=    Evaluate    ${i} + ${1}
        Write To Cell By Name    Sheet    A${loc}    ${LinkText}

        ${LinkName}=  Split String    ${LinkText}    ${SPACE}    max_split=10
        ${FileName}=    Evaluate    "_".join(${LinkName})
        ${image_url}=  Get Element Attribute  (//div[@class='thumb']/div/a/img)[${i}]  src
        Write To Cell By Name    Sheet    B${loc}    ${image_url}
        Write To Cell By Name    Sheet    C${loc}    ${FileName}.png
        log to console    ${LinkText} - ${image_url}
        ${command}    set variable    curl -o ${DOWNLOAD_DIR}/${FileName}.png ${image_url} --ssl-no-revoke
        Run Process    ${command}    shell=True
    END
    # Save excel and exit
    Save Excel

TestElements08
    [Documentation]    Test Case 08 HTML Table actions
    [Tags]    HTMLTable

    Go to    ${URL02}
    ${rows}=    Get Element Count    xpath://table[@id='product']/tbody/tr
    ${cols}=    Get Element Count    xpath://table[@id='product']/tbody/tr[1]/th
    log to console    rows: ${rows}, columns: ${cols}
    # Verify element from the table
    # Columns Validation
    table column should contain    xpath://table[@id='product']    1    Instructor
    table column should contain    xpath://table[@id='product']    2    Course
    table column should contain    xpath://table[@id='product']    3    Price
    # Row validation
    ${row4}=    set variable    Appium (Selenium) - Mobile Automation Testing from Scratch
    table row should contain    xpath://table[@id='product']    4    ${row4}
    # Cell validation
    table cell should contain    xpath://table[@id='product']    4    2    ${row4}
    # Header validation
    table header should contain    xpath://table[@id='product']    Price

    ${RESPONSE_LIST}=    create list
    # Read data from the table
    FOR    ${i}    IN RANGE  1  ${rows}+1
        FOR  ${j}  IN RANGE  1  ${cols}+1
            IF    ${i}==1
                ${elementText}=    get text    xpath://table[@id='product']/tbody/tr[${i}]/th[${j}]
#                log to console    ${elementText}
            ELSE
                ${elementText}=    get text    xpath://table[@id='product']/tbody/tr[${i}]/td[${j}]
#                log to console    ${elementText}
                IF    ${j}==3
                    ${elementText}=    convert to number    ${elementText}
                    Append To List    ${RESPONSE_LIST}    ${elementText}
                END
            END
        END
    END
    ${sum} =    Evaluate    sum(map(float, ${RESPONSE_LIST}))
    log to console    ${RESPONSE_LIST} sum is: ${sum}

*** Keywords ***



