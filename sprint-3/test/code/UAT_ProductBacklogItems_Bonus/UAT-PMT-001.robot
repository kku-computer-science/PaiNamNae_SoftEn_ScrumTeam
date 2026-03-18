*** Settings ***
Documentation     ทดสอบการบันทึกข้อมูลช่องทางรับเงิน Prompt Pay ของผู้ขับขี่
Library           SeleniumLibrary
Suite Setup       Open Browser To Main Page
Suite Teardown    Close Browser

*** Variables ***
${URL}            http://csse4369.cpkku.com/
${BROWSER}        Chrome
${DELAY}          0.5
${DRIVER_USER}    DRIVER_SP3_UAT
${DRIVER_PASS}    DRIVERpassword
${PROMPTPAY_PHONE}    0812345678
${PROMPTPAY_CITIZEN}  1100000000000
${PROMPTPAY_INVALID}  081234567

*** Test Cases ***
เข้าสู่หน้าข้อมูลการรับเงิน
    [Documentation]    ล็อกอินเข้าสู่ระบบและเข้าสู่หน้าข้อมูลการรับเงิน
    Login As Driver    ${DRIVER_USER}    ${DRIVER_PASS}
    Go To              ${URL}profile/payment-info
    Wait Until Page Contains    ข้อมูลการรับเงิน    timeout=10s
    Wait Until Element Is Visible    xpath=//input[@placeholder='เบอร์โทรศัพท์ หรือ เลขบัตรประชาชน']    timeout=10s

TC-PMT-01: บันทึกด้วยเบอร์โทรศัพท์
    [Documentation]    กรอกเบอร์โทรศัพท์ 10 หลัก และบันทึก
    Clear Element Text    xpath=//input[@placeholder='เบอร์โทรศัพท์ หรือ เลขบัตรประชาชน']
    Input Text         xpath=//input[@placeholder='เบอร์โทรศัพท์ หรือ เลขบัตรประชาชน']    ${PROMPTPAY_PHONE}
    # ปุ่มบันทึก PromptPay: text จริงคือ "บันทึก" หรือ "กำลังบันทึก..." อยู่ภายในส่วน PromptPay section
    # ใช้ locator ที่เจาะจงเข้า section PromptPay ผ่าน heading h2
    Wait Until Element Is Visible    xpath=//div[.//h2[normalize-space()='PromptPay']]//button[contains(normalize-space(), 'บันทึก')]    timeout=10s
    Click Element      xpath=//div[.//h2[normalize-space()='PromptPay']]//button[contains(normalize-space(), 'บันทึก')]
    Wait Until Page Contains    บันทึกสำเร็จ    timeout=10s
    Wait Until Page Contains    อัปเดตหมายเลข PromptPay แล้ว    timeout=10s
    Sleep    2s

TC-PMT-02: บันทึกด้วยบัตรประชาชน
    [Documentation]    ลบเบอร์โทรศัพท์เดิมออก กรอกเลขบัตรประชาชน 13 หลัก
    Clear Element Text    xpath=//input[@placeholder='เบอร์โทรศัพท์ หรือ เลขบัตรประชาชน']
    Input Text         xpath=//input[@placeholder='เบอร์โทรศัพท์ หรือ เลขบัตรประชาชน']    ${PROMPTPAY_CITIZEN}
    Wait Until Element Is Visible    xpath=//div[.//h2[normalize-space()='PromptPay']]//button[contains(normalize-space(), 'บันทึก')]    timeout=10s
    Click Element      xpath=//div[.//h2[normalize-space()='PromptPay']]//button[contains(normalize-space(), 'บันทึก')]
    Wait Until Page Contains    บันทึกสำเร็จ    timeout=10s
    Wait Until Page Contains    อัปเดตหมายเลข PromptPay แล้ว    timeout=10s
    Sleep    2s

TC-PMT-03: [Negative] กรอกข้อมูลไม่ครบถ้วน
    [Documentation]    กรอกเบอร์โทรศัพท์แค่ 9 ตัว
    Clear Element Text    xpath=//input[@placeholder='เบอร์โทรศัพท์ หรือ เลขบัตรประชาชน']
    Input Text         xpath=//input[@placeholder='เบอร์โทรศัพท์ หรือ เลขบัตรประชาชน']    ${PROMPTPAY_INVALID}
    Wait Until Element Is Visible    xpath=//div[.//h2[normalize-space()='PromptPay']]//button[contains(normalize-space(), 'บันทึก')]    timeout=10s
    Click Element      xpath=//div[.//h2[normalize-space()='PromptPay']]//button[contains(normalize-space(), 'บันทึก')]
    # error message แสดงด้านล่าง input
    Wait Until Page Contains    กรุณากรอกเลข PromptPay ให้ครบ 10 หลัก    timeout=10s

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
    Wait Until Element Is Visible    xpath=//button[@type='submit']    timeout=10s
    Click Element    xpath=//button[@type='submit']
    Sleep    3s
