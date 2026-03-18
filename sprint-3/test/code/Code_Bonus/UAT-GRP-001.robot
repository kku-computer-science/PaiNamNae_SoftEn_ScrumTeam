*** Settings ***
Documentation     การชำระเงินแบบกลุ่ม (Group Payment)
Library           SeleniumLibrary
Suite Setup       Open Browser To Main Page
Suite Teardown    Close Browser

*** Variables ***
${URL}            http://csse4369.cpkku.com/
${BROWSER}        Chrome
${DELAY}          0.5
${PASSENGER_USER}    PASSENGER_SP3_UAT
${PASSENGER_PASS}    PASSENGERpassword
${SLIP_PATH}      ${EXECDIR}/slip_mock.jpg

*** Test Cases ***
เปิดหน้าชำระเงินแบบกลุ่ม
    [Documentation]    เปิดหน้าชำระเงินพร้อมรายชื่อผู้ร่วมเดินทาง
    Login As Passenger    ${PASSENGER_USER}    ${PASSENGER_PASS}
    Open Payment Modal
    Wait Until Page Contains    จ่ายแทนผู้ร่วมเดินทาง    timeout=10s
    # ปิด Modal เพื่อไม่ให้ค้างไปที่ Test ถัดไป
    Click Element      xpath=(//button[.//*[local-name()='path' and contains(@d, 'M6 18L18 6')]])[1]

TC-GRP-01: เลือกจ่ายแทนผู้ร่วมเดินทาง
    [Documentation]    เลือกจ่ายแทนผู้ร่วมเดินทาง ระบบต้องคำนวณยอดเงินรวมได้ถูกต้อง
    Login As Passenger    ${PASSENGER_USER}    ${PASSENGER_PASS}
    Open Payment Modal
    Wait Until Page Contains    จ่ายแทนผู้ร่วมเดินทาง    timeout=10s
    Click Element      xpath=//input[@type='checkbox']
    # ตรวจสอบว่าระบบมีพร้อมเพย์หรือช่องทางให้โอนเงินแสดงขึ้นมา
    Wait Until Page Contains    โอนเงิน    timeout=5s
    # ปิด Modal เพื่อไม่ให้ค้างไปที่ Test ถัดไป
    Click Element      xpath=(//button[.//*[local-name()='path' and contains(@d, 'M6 18L18 6')]])[1]

TC-GRP-03: แจ้งชำระเงินกลุ่มด้วยเงินสด
    [Documentation]    ชำระเงินกลุ่มด้วยเงินสด
    Login As Passenger    ${PASSENGER_USER}    ${PASSENGER_PASS}
    Open Payment Modal
    Wait Until Page Contains    จ่ายแทนผู้ร่วมเดินทาง    timeout=10s
    # Step 0: เลือกจ่ายแทนเพื่อน
    Wait Until Page Contains Element    xpath=(//input[@type='checkbox'])[1]    timeout=5s
    Click Element      xpath=(//input[@type='checkbox'])[1]
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

TC-GRP-02: ชำระเงินกลุ่มด้วยการโอนเงิน
    [Documentation]    เลือกวิธีโอนเงินและแนบสลิป
    Login As Passenger    ${PASSENGER_USER}    ${PASSENGER_PASS}
    Open Payment Modal
    Wait Until Page Contains    จ่ายแทนผู้ร่วมเดินทาง    timeout=10s
    # Step 0: เลือกจ่ายแทนเพื่อน
    Wait Until Page Contains Element    xpath=(//input[@type='checkbox'])[1]    timeout=5s
    Click Element      xpath=(//input[@type='checkbox'])[1]
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

Login As Passenger
    [Arguments]    ${username}    ${password}
    Go To            ${URL}login
    Wait Until Element Is Visible    id=identifier    timeout=10s
    Input Text       id=identifier    ${username}
    Input Text       id=password    ${password}
    Click Element    xpath=//button[contains(., 'เข้าสู่ระบบ')]
    Sleep    3s

Open Payment Modal
    Go To              ${URL}myTrip
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'tab-button') and contains(normalize-space(), 'เสร็จสิ้น')]    timeout=15s
    Click Element      xpath=//button[contains(@class, 'tab-button') and contains(normalize-space(), 'เสร็จสิ้น')]
    Wait Until Element Is Visible    xpath=(//button[contains(normalize-space(),'ชำระเงิน') or contains(normalize-space(),'ส่งสลิปใหม่') or contains(normalize-space(),'แจ้งชำระเงิน')])[1]    timeout=15s
    Click Element      xpath=(//button[contains(normalize-space(),'ชำระเงิน') or contains(normalize-space(),'ส่งสลิปใหม่') or contains(normalize-space(),'แจ้งชำระเงิน')])[1]
