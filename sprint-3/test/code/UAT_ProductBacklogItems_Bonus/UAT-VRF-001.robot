*** Settings ***
Documentation     การยืนยันหลักฐานและการอัปเดตสถานะการเดินทาง (Payment Verification)
Library           SeleniumLibrary
Suite Setup       Open Browser To Main Page
Suite Teardown    Close Browser

*** Variables ***
${URL}            http://csse4369.cpkku.com/
${BROWSER}        Chrome
${DELAY}          0.5
${DRIVER_USER}    DRIVER_SP3_UAT
${DRIVER_PASS}    DRIVERpassword

*** Test Cases ***
เปิดหน้ายืนยันการชำระเงิน
    [Documentation]    ล็อกอินในฐานะคนขับและตรวจสอบการชำระเงิน
    Login As Driver    ${DRIVER_USER}    ${DRIVER_PASS}
    Go To              ${URL}myRoute
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'tab-button') and contains(normalize-space(), 'เส้นทางของฉัน')]    timeout=15s
    Click Element      xpath=//button[contains(@class, 'tab-button') and contains(normalize-space(), 'เส้นทางของฉัน')]
    Wait Until Element Is Visible    xpath=(//button[contains(., 'ยืนยันการชำระเงิน')])[1]    timeout=15s
    Click Element      xpath=(//button[contains(., 'ยืนยันการชำระเงิน')])[1]
    Wait Until Page Contains    ตรวจสอบการชำระเงิน    timeout=10s
    # Close modal
    Click Element      xpath=(//button[.//*[local-name()='path' and contains(@d, 'M6 18L18 6')]])[1]

TC-VRF-03: [Negative] ปฏิเสธหลักฐานการชำระเงิน
    [Documentation]    ตรวจสอบสลิปแล้วไม่ถูกต้อง กดยกเลิก/ปฏิเสธ
    Login As Driver    ${DRIVER_USER}    ${DRIVER_PASS}
    Open Driver Payment Modal For Slip
    Wait Until Element Is Visible    xpath=(//button[@title='สลิปไม่ถูกต้อง'])[1]    timeout=10s
    Click Element      xpath=(//button[@title='สลิปไม่ถูกต้อง'])[1]
    Wait Until Element Is Visible    xpath=//select    timeout=5s
    Select From List By Label    xpath=//select    ยอดเงินไม่ถูกต้อง
    Click Element      xpath=//button[contains(., 'ยืนยันการปฏิเสธ')]
    Wait Until Page Contains    แจ้งผู้โดยสาร    timeout=10s
    # Close modal
    Click Element      xpath=(//button[.//*[local-name()='path' and contains(@d, 'M6 18L18 6')]])[1]

TC-VRF-01: ยืนยันการรับเงินโอน
    [Documentation]    ตรวจสอบรูปสลิปแล้วกดยืนยันการรับเงิน
    Login As Driver    ${DRIVER_USER}    ${DRIVER_PASS}
    Open Driver Payment Modal For Slip
    Wait Until Element Is Visible    xpath=(//label[contains(., 'สลิปถูกต้อง')])[1]    timeout=10s
    Click Element      xpath=(//label[contains(., 'สลิปถูกต้อง')])[1]
    Click Element      xpath=//button[contains(., 'ยืนยันการรับเงิน')]
    Wait Until Page Contains    ยืนยันแล้ว    timeout=10s
    ${is_readonly}=    Run Keyword And Return Status    Wait Until Page Contains    ชำระเงินครบทั้งหมดแล้ว    timeout=3s
    Run Keyword If    ${is_readonly}    Click Element    xpath=//button[contains(., 'ปิด')]
    ...    ELSE    Click Element    xpath=(//button[.//*[local-name()='path' and contains(@d, 'M6 18L18 6')]])[1]

TC-VRF-02: ยืนยันการรับเงินสด
    [Documentation]    กดติ๊กรับเงินสดแล้วและยืนยันการรับเงิน
    Login As Driver    ${DRIVER_USER}    ${DRIVER_PASS}
    Open Driver Payment Modal For Cash
    Wait Until Element Is Visible    xpath=(//label[contains(., 'รับเงินสดแล้ว')])[1]    timeout=10s
    Click Element      xpath=(//label[contains(., 'รับเงินสดแล้ว')])[1]
    Click Element      xpath=//button[contains(., 'ยืนยันการรับเงิน')]
    Wait Until Page Contains    ยืนยันแล้ว    timeout=10s
    ${is_readonly}=    Run Keyword And Return Status    Wait Until Page Contains    ชำระเงินครบทั้งหมดแล้ว    timeout=3s
    Run Keyword If    ${is_readonly}    Click Element    xpath=//button[contains(., 'ปิด')]
    ...    ELSE    Click Element    xpath=(//button[.//*[local-name()='path' and contains(@d, 'M6 18L18 6')]])[1]

TC-VRF-04: ตรวจสอบสถานะการเดินทางเป็น "เสร็จสิ้น"
    [Documentation]    ตรวจสอบสถานะหลังกดยืนยันว่าขึ้นเสร็จสิ้นแล้ว
    Login As Driver    ${DRIVER_USER}    ${DRIVER_PASS}
    Go To              ${URL}myRoute
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'tab-button') and contains(normalize-space(), 'เส้นทางของฉัน')]    timeout=15s
    Click Element      xpath=//button[contains(@class, 'tab-button') and contains(normalize-space(), 'เส้นทางของฉัน')]
    Sleep    1s
    Wait Until Page Contains    เสร็จสิ้น    timeout=10s

*** Keywords ***
Open Browser To Main Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Login As Driver
    [Arguments]    ${username}    ${password}
    Go To            ${URL}login
    Wait Until Element Is Visible    id=identifier    timeout=10s
    Input Text       id=identifier    ${username}
    Input Text       id=password    ${password}
    Click Element    xpath=//button[contains(., 'เข้าสู่ระบบ')]
    Sleep    3s

Open Driver Payment Modal For Slip
    Go To              ${URL}myRoute
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'tab-button') and contains(normalize-space(), 'เส้นทางของฉัน')]    timeout=15s
    Click Element      xpath=//button[contains(@class, 'tab-button') and contains(normalize-space(), 'เส้นทางของฉัน')]
    FOR    ${i}    IN RANGE    1    6
        ${btn_exists}=    Run Keyword And Return Status    Element Should Be Visible    xpath=(//button[contains(., 'ยืนยันการชำระเงิน')])[${i}]
        Exit For Loop If    not ${btn_exists}
        Click Element      xpath=(//button[contains(., 'ยืนยันการชำระเงิน')])[${i}]
        ${has_slip}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=(//button[@title='สลิปไม่ถูกต้อง'])[1]    timeout=2s
        Return From Keyword If    ${has_slip}
        Click Element      xpath=(//button[.//*[local-name()='path' and contains(@d, 'M6 18L18 6')]])[1]
        Sleep    1s
    END
    Fail    Could not find any trip with a slip to verify

Open Driver Payment Modal For Cash
    Go To              ${URL}myRoute
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'tab-button') and contains(normalize-space(), 'เส้นทางของฉัน')]    timeout=15s
    Click Element      xpath=//button[contains(@class, 'tab-button') and contains(normalize-space(), 'เส้นทางของฉัน')]
    FOR    ${i}    IN RANGE    1    6
        ${btn_exists}=    Run Keyword And Return Status    Element Should Be Visible    xpath=(//button[contains(., 'ยืนยันการชำระเงิน')])[${i}]
        Exit For Loop If    not ${btn_exists}
        Click Element      xpath=(//button[contains(., 'ยืนยันการชำระเงิน')])[${i}]
        ${has_cash}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=(//label[contains(., 'รับเงินสดแล้ว')])[1]    timeout=2s
        Return From Keyword If    ${has_cash}
        Click Element      xpath=(//button[.//*[local-name()='path' and contains(@d, 'M6 18L18 6')]])[1]
        Sleep    1s
    END
    Fail    Could not find any trip with pending cash verification
