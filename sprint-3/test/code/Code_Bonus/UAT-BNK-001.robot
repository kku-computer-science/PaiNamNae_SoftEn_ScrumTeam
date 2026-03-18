*** Settings ***
Documentation     การจัดการข้อมูลบัญชีธนาคาร (Bank Account Management)
Library           SeleniumLibrary
Suite Setup       Open Browser To Main Page
Suite Teardown    Close Browser

*** Variables ***
${URL}            http://csse4369.cpkku.com/
${BROWSER}        Chrome
${DELAY}          0.5
${DRIVER_USER}    DRIVER_SP3_UAT
${DRIVER_PASS}    DRIVERpassword
${BANK_NAME}      ธนาคารกสิกรไทย
${ACC_NO}         1234567890
${ACC_NAME}       นาย ทดสอบ ขับขี่

*** Test Cases ***
เข้าสู่หน้าข้อมูลการรับเงิน
    [Documentation]    ล็อกอินในฐานะผู้ขับขี่และไปที่เมนูข้อมูลการรับเงิน
    Login As Driver    ${DRIVER_USER}    ${DRIVER_PASS}
    Go To              ${URL}profile/payment-info
    Wait Until Page Contains    ข้อมูลการรับเงิน    timeout=10s
    Sleep    1s

TC-BNK-01: เพิ่มบัญชีธนาคารใหม่
    [Documentation]    เพิ่มข้อมูลบัญชีธนาคารใหม่
    # ปุ่ม "เพิ่มบัญชี" หรือ "เพิ่มบัญชีธนาคาร" (กรณียังไม่มีบัญชี)
    Wait Until Element Is Visible    xpath=//button[contains(normalize-space(), 'เพิ่มบัญชี')]    timeout=10s
    Click Element      xpath=//button[contains(normalize-space(), 'เพิ่มบัญชี')]
    Sleep    1s
    # เปิด dropdown เลือกธนาคาร: ปุ่ม "เลือกธนาคาร" อยู่ในส่วน Custom Bank Dropdown
    Wait Until Element Is Visible    xpath=//button[contains(normalize-space(), 'เลือกธนาคาร')]    timeout=10s
    Click Element      xpath=//button[contains(normalize-space(), 'เลือกธนาคาร')]
    Sleep    1s
    # เลือก ธนาคารกสิกรไทย จากรายการใน dropdown (เป็น button ข้างใน <li>)
    Wait Until Element Is Visible    xpath=//span[normalize-space()='${BANK_NAME}']/ancestor::button    timeout=10s
    Click Element      xpath=//span[normalize-space()='${BANK_NAME}']/ancestor::button
    Sleep    0.5s
    # กรอกเลขที่บัญชี
    Wait Until Element Is Visible    xpath=//input[@placeholder='เช่น 123-4-56789-0']    timeout=10s
    Input Text         xpath=//input[@placeholder='เช่น 123-4-56789-0']    ${ACC_NO}
    # กรอกชื่อบัญชี
    Input Text         xpath=//input[@placeholder='ชื่อ-นามสกุล ตามบัญชีธนาคาร']    ${ACC_NAME}
    # กดปุ่ม "เพิ่มบัญชี" ใน Modal footer
    # ข้อความจริงใน modal footer button คือ "เพิ่มบัญชี" (ไม่ใช่ "เพิ่มบัญชีธนาคาร")
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'border-t')]//button[contains(normalize-space(), 'เพิ่มบัญชี')]    timeout=10s
    Click Element      xpath=//div[contains(@class, 'border-t')]//button[contains(normalize-space(), 'เพิ่มบัญชี')]
    Wait Until Page Contains    เพิ่มสำเร็จ    timeout=10s
    Wait Until Page Contains    เพิ่มบัญชีธนาคารแล้ว    timeout=10s
    Sleep    2s

TC-BNK-02: แก้ไขข้อมูลบัญชีธนาคาร
    [Documentation]    แก้ไขข้อมูลบัญชีที่เพิ่มไป
    Wait Until Element Is Visible    xpath=//button[@title='แก้ไข']    timeout=10s
    Click Element      xpath=//button[@title='แก้ไข']
    Sleep    1s
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อ-นามสกุล ตามบัญชีธนาคาร']    timeout=10s
    Clear Element Text    xpath=//input[@placeholder='ชื่อ-นามสกุล ตามบัญชีธนาคาร']
    Input Text         xpath=//input[@placeholder='ชื่อ-นามสกุล ตามบัญชีธนาคาร']    ${ACC_NAME} แก้ไข
    # ปุ่ม "บันทึกการแก้ไข" ใน Modal footer
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'border-t')]//button[contains(normalize-space(), 'บันทึกการแก้ไข')]    timeout=10s
    Click Element      xpath=//div[contains(@class, 'border-t')]//button[contains(normalize-space(), 'บันทึกการแก้ไข')]
    Wait Until Page Contains    บันทึกสำเร็จ    timeout=10s
    Wait Until Page Contains    แก้ไขบัญชีธนาคารแล้ว    timeout=10s
    Sleep    2s

TC-BNK-03: ลบบัญชีธนาคาร
    [Documentation]    ลบบัญชีธนาคารออกจากระบบ
    Wait Until Element Is Visible    xpath=//button[@title='ลบ']    timeout=10s
    Click Element      xpath=//button[@title='ลบ']
    Wait Until Page Contains    ลบบัญชีธนาคาร    timeout=10s
    Sleep    1s
    # ปุ่มยืนยันลบอยู่ใน ConfirmModal: ข้อความจริงคือ "ลบบัญชี" (confirm-text="ลบบัญชี")
    Wait Until Element Is Visible    xpath=//button[normalize-space()='ลบบัญชี']    timeout=10s
    Click Element      xpath=//button[normalize-space()='ลบบัญชี']
    Wait Until Page Contains    ลบสำเร็จ    timeout=10s
    Wait Until Page Contains    ลบบัญชีธนาคารแล้ว    timeout=10s
    Sleep    2s
    Wait Until Page Does Not Contain    ${ACC_NO}

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
