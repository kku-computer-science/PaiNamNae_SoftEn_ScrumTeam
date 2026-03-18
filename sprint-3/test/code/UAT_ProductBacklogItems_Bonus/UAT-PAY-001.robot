*** Settings ***
Documentation     การชำระเงินสำหรับผู้โดยสารรายบุคคล (Individual Payment)
Library           SeleniumLibrary
Suite Setup       Open Browser To Main Page
Suite Teardown    Close Browser
Test Teardown     Capture On Failure

*** Variables ***
${URL}               http://csse4369.cpkku.com/
${BROWSER}           Chrome
${DELAY}             0.5
${LONG_TIMEOUT}      20s
${PASSENGER_USER}    PASSENGER_SP3_UAT
${PASSENGER_PASS}    PASSENGERpassword
${SLIP_PATH}         ${EXECDIR}/slip_mock.jpg

*** Test Cases ***
เปิดหน้าชำระเงิน
    [Documentation]    หน้าชำระเงินหลังสถานะ "ถึงที่หมายแล้ว" — แสดงตัวเลือกวิธีชำระเงิน
    Login As Passenger    ${PASSENGER_USER}    ${PASSENGER_PASS}
    Open Payment Modal
    Wait Until Page Contains    เลือกวิธีชำระเงิน    timeout=10s
    Page Should Contain    โอนเงิน
    Page Should Contain    เงินสด
    # ปิด Modal เพื่อไม่ให้ค้างไปที่ Test ถัดไป
    Click Element      xpath=(//button[.//*[local-name()='path' and contains(@d, 'M6 18L18 6')]])[1]

TC-PAY-03: [Negative] โอนเงินแต่ไม่แนบสลิป
    [Documentation]    เลือกโอนเงินแต่ไม่แนบสลิป — ระบบต้องเตือนว่าต้องแนบสลิป
    Login As Passenger    ${PASSENGER_USER}    ${PASSENGER_PASS}
    Open Payment Modal
    # Step 1: Select transfer
    Wait Until Page Contains    โอนเงิน    timeout=10s
    Click Element      xpath=//button[contains(., 'โอนเงิน') or .//span[normalize-space()='โอนเงิน']]
    Wait Until Element Is Visible    xpath=//button[contains(., 'ต่อไป') or contains(., 'ดำเนินการต่อ')]    timeout=5s
    Click Element      xpath=//button[contains(., 'ต่อไป') or contains(., 'ดำเนินการต่อ')]
    # Step 2: Select PromptPay
    Wait Until Page Contains    พร้อมเพย์    timeout=10s
    Click Element      xpath=//button[contains(., 'พร้อมเพย์')]
    Wait Until Element Is Visible    xpath=//button[contains(., 'ต่อไป')]    timeout=5s
    Click Element      xpath=//button[contains(., 'ต่อไป')]
    # Step 3: QR page
    Wait Until Page Contains    ข้อมูลการชำระเงิน    timeout=10s
    Wait Until Element Is Visible    xpath=//button[contains(., 'ต่อไป')]    timeout=5s
    Click Element      xpath=//button[contains(., 'ต่อไป')]
    # Step 4: Upload slip (Try to click Next without slip)
    Wait Until Page Contains    อัปโหลดสลิปการโอน    timeout=10s
    Wait Until Element Is Visible    xpath=//button[contains(., 'ต่อไป')]    timeout=5s
    Click Element      xpath=//button[contains(., 'ต่อไป')]
    # Assert toaster or similar
    Wait Until Page Contains    กรุณาแนบสลิป    timeout=10s
    # Close modal
    Click Element      xpath=(//button[.//*[local-name()='path' and contains(@d, 'M6 18L18 6')]])[1]

TC-PAY-02: แจ้งชำระเงินด้วยเงินสด
    [Documentation]    เลือกวิธีเงินสดและยืนยันการชำระเงิน
    Login As Passenger    ${PASSENGER_USER}    ${PASSENGER_PASS}
    Open Payment Modal
    # Step 1: Select cash
    Wait Until Page Contains    เงินสด    timeout=10s
    Click Element      xpath=//button[contains(., 'เงินสด') or .//span[normalize-space()='เงินสด']]
    Wait Until Element Is Visible    xpath=//button[contains(., 'ต่อไป') or contains(., 'ดำเนินการต่อ')]    timeout=5s
    Click Element      xpath=//button[contains(., 'ต่อไป') or contains(., 'ดำเนินการต่อ')]
    # Step 3: Cash detail
    Wait Until Page Contains    ชำระด้วยเงินสดกับคนขับโดยตรง    timeout=10s
    Wait Until Element Is Visible    xpath=//button[contains(., 'ต่อไป')]    timeout=5s
    Click Element      xpath=//button[contains(., 'ต่อไป')]
    # Step 5: Confirm
    Wait Until Element Is Visible    xpath=//button[contains(., 'ยืนยันการชำระเงิน')]    timeout=10s
    Click Element      xpath=//button[contains(., 'ยืนยันการชำระเงิน')]
    Wait Until Page Contains    รอคนขับยืนยัน    timeout=15s

TC-PAY-01: ชำระเงินด้วยการโอนเงิน + แนบสลิป
    [Documentation]    เลือกวิธีโอนเงิน, แนบสลิป และส่งข้อมูล
    Login As Passenger    ${PASSENGER_USER}    ${PASSENGER_PASS}
    Open Payment Modal
    # Step 1: Select transfer
    Wait Until Page Contains    โอนเงิน    timeout=10s
    Click Element      xpath=//button[contains(., 'โอนเงิน') or .//span[normalize-space()='โอนเงิน']]
    Wait Until Element Is Visible    xpath=//button[contains(., 'ต่อไป') or contains(., 'ดำเนินการต่อ')]    timeout=5s
    Click Element      xpath=//button[contains(., 'ต่อไป') or contains(., 'ดำเนินการต่อ')]
    # Step 2: Select PromptPay
    Wait Until Page Contains    พร้อมเพย์    timeout=10s
    Click Element      xpath=//button[contains(., 'พร้อมเพย์')]
    Wait Until Element Is Visible    xpath=//button[contains(., 'ต่อไป')]    timeout=5s
    Click Element      xpath=//button[contains(., 'ต่อไป')]
    # Step 3: QR page
    Wait Until Page Contains    ข้อมูลการชำระเงิน    timeout=10s
    Wait Until Element Is Visible    xpath=//button[contains(., 'ต่อไป')]    timeout=5s
    Click Element      xpath=//button[contains(., 'ต่อไป')]
    # Step 4: Upload slip
    Wait Until Page Contains    อัปโหลดสลิปการโอน    timeout=10s
    Execute Javascript    (function(){const el=document.querySelector('input[type=file]'); if(el){el.classList.remove('hidden'); el.style.display='block'; el.style.visibility='visible';}})();
    Choose File        xpath=//input[@type='file']    ${SLIP_PATH}
    Wait Until Element Is Visible    xpath=//button[contains(., 'ต่อไป')]    timeout=5s
    Click Element      xpath=//button[contains(., 'ต่อไป')]
    # Step 5: Confirm
    Wait Until Element Is Visible    xpath=//button[contains(., 'ยืนยันการชำระเงิน')]    timeout=10s
    Click Element      xpath=//button[contains(., 'ยืนยันการชำระเงิน')]
    Wait Until Page Contains    รอคนขับยืนยัน    timeout=15s

*** Keywords ***
Open Browser To Main Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Open Payment Modal
    [Documentation]    เปิดหน้าชำระเงินสำหรับทริปที่อยู่ในสถานะ "ถึงที่หมายแล้ว"
    Go To              ${URL}myTrip
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'tab-button') and contains(normalize-space(), 'เสร็จสิ้น')]    timeout=15s
    Click Element      xpath=//button[contains(@class, 'tab-button') and contains(normalize-space(), 'เสร็จสิ้น')]
    Wait Until Element Is Visible    xpath=(//button[contains(normalize-space(),'ชำระเงิน') or contains(normalize-space(),'ส่งสลิปใหม่') or contains(normalize-space(),'แจ้งชำระเงิน')])[1]    timeout=15s
    Click Element      xpath=(//button[contains(normalize-space(),'ชำระเงิน') or contains(normalize-space(),'ส่งสลิปใหม่') or contains(normalize-space(),'แจ้งชำระเงิน')])[1]

Login As Passenger
    [Arguments]    ${username}    ${password}
    Go To            ${URL}login
    Wait Until Element Is Visible    id=identifier    timeout=10s
    Input Text       id=identifier    ${username}
    Input Text       id=password    ${password}
    Wait Until Element Is Visible    xpath=//button[@type='submit']    timeout=10s
    Click Element    xpath=//button[@type='submit']
    Sleep    3s

Capture On Failure
    Run Keyword If    '${TEST_STATUS}' == 'FAIL'    Capture Page Screenshot

Login As Driver
    [Arguments]    ${username}    ${password}
    Go To            ${URL}login
    Wait Until Element Is Visible    id=identifier    timeout=10s
    Input Text       id=identifier    ${username}
    Input Text       id=password    ${password}
    Wait Until Element Is Visible    xpath=//button[@type='submit']    timeout=10s
    Click Element    xpath=//button[@type='submit']
    Sleep    3s
