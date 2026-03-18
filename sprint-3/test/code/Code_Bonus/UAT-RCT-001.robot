*** Settings ***
Documentation     การดูและดาวน์โหลดใบเสร็จรับเงิน — UAT-RCT-001
Library           SeleniumLibrary
Suite Setup       Open Browser To Main Page
Suite Teardown    Close Browser

*** Variables ***
${URL}          http://csse4369.cpkku.com/
${BROWSER}      Chrome
${DELAY}        0.5
${PASS_USER}    PASSENGER_SP3_UAT
${PASS_PASS}    PASSENGERpassword

*** Test Cases ***
เข้าสู่หน้าการเดินทางของฉันในฐานะผู้โดยสาร
    [Documentation]    ล็อกอินและไปที่หน้าการเดินทาง เพื่อดูใบเสร็จ
    Login As Passenger    ${PASS_USER}    ${PASS_PASS}
    Go To              ${URL}myTrip
    Wait Until Page Contains    การเดินทางของฉัน    timeout=10s
    Sleep    1s

TC-RCT-01: กรองดู Trip ที่ชำระสำเร็จแล้ว (แท็บ "เสร็จสิ้น")
    [Documentation]    คลิก tab "เสร็จสิ้น" เพื่อแสดงเฉพาะ trip ที่ payment = VERIFIED
    Wait Until Element Is Visible    xpath=//button[contains(normalize-space(), 'เสร็จสิ้น')]    timeout=10s
    Click Element      xpath=//button[contains(normalize-space(), 'เสร็จสิ้น')]
    Sleep    1s
    Wait Until Element Is Visible    xpath=//div[contains(@class,'trip-card')]    timeout=10s

TC-RCT-02: กดปุ่ม "ดูใบเสร็จ" เพื่อเปิด Receipt Modal
    [Documentation]    กดปุ่ม "ดูใบเสร็จ" บน trip ที่ paymentStatus = VERIFIED
    Wait Until Element Is Visible    xpath=//button[contains(normalize-space(),'ดูใบเสร็จ')]    timeout=10s
    Click Element      xpath=//button[contains(normalize-space(),'ดูใบเสร็จ')]
    Sleep    1s
    # ตรวจ Receipt Modal เปิดขึ้น — มีข้อความ "ใบเสร็จรับเงิน"
    Wait Until Page Contains    ใบเสร็จรับเงิน    timeout=10s

TC-RCT-03: ตรวจสอบข้อมูลผู้ให้บริการและลูกค้าในใบเสร็จ
    [Documentation]    ตรวจสอบส่วน "ผู้ให้บริการ" และ "ลูกค้า" แสดงผลครบถ้วน
    Wait Until Element Is Visible    xpath=//p[contains(normalize-space(),'ผู้ให้บริการ')]    timeout=10s
    Wait Until Element Is Visible    xpath=//p[contains(normalize-space(),'ลูกค้า')]    timeout=10s
    # ตรวจว่ามีชื่อแสดง (class font-semibold text-gray-900)
    ${provider_name}=    Get Text    xpath=(//p[contains(@class,'font-semibold') and contains(@class,'text-gray-900')])[1]
    Should Not Be Empty    ${provider_name}    msg=ไม่พบชื่อผู้ให้บริการในใบเสร็จ
    Sleep    1s

TC-RCT-04: ตรวจสอบตารางรายการค่าโดยสารและยอดรวม
    [Documentation]    ตรวจสอบว่าตาราง "รายการ" มี "ค่าโดยสาร" และ "จำนวนเงินรวมทั้งสิ้น"
    Wait Until Page Contains    ค่าโดยสาร    timeout=10s
    Wait Until Page Contains    จำนวนเงินรวมทั้งสิ้น    timeout=10s
    # ตรวจว่าราคา (฿) ปรากฏในตาราง
    Wait Until Element Is Visible    xpath=//td[contains(normalize-space(),'฿')]    timeout=10s
    Sleep    1s

TC-RCT-05: ตรวจสอบวิธีชำระเงินที่แสดงในใบเสร็จ
    [Documentation]    ตรวจสอบว่า checkbox "เงินสด" หรือ "โอนเงิน" ถูกติ๊กถูกต้อง
    # ตรวจหา input checkbox ที่ disabled ในส่วนวิธีชำระ
    ${cash_checked}=    Run Keyword And Return Status
    ...    Page Contains Element    xpath=//input[@type='checkbox' and @disabled]
    Should Be True    ${cash_checked}    msg=ไม่พบข้อมูลวิธีชำระเงินในใบเสร็จ
    Sleep    1s

TC-RCT-06: กดปุ่ม "ดาวน์โหลด" เพื่อดาวน์โหลดใบเสร็จเป็น PNG
    [Documentation]    กดปุ่ม "ดาวน์โหลด" และตรวจว่าไม่เกิด error
    Wait Until Element Is Visible
    ...    xpath=//button[contains(normalize-space(),'ดาวน์โหลด')]    timeout=10s
    Click Element
    ...    xpath=//button[contains(normalize-space(),'ดาวน์โหลด')]
    Sleep    5s
    # ตรวจว่า modal ยังคงอยู่ (ไม่ถูกปิด) หมายความว่าดาวน์โหลดสำเร็จโดยไม่ error
    Page Should Contain    ใบเสร็จรับเงิน

TC-RCT-07: กดปุ่ม "ปิด" เพื่อปิด Receipt Modal
    [Documentation]    ปิด modal และตรวจสอบว่ากลับมาที่หน้า myTrip ปกติ
    Wait Until Element Is Visible
    ...    xpath=//button[contains(normalize-space(),'ปิด')]    timeout=10s
    Click Element    xpath=//button[contains(normalize-space(),'ปิด')]
    Sleep    1s
    # ตรวจว่า modal ถูกปิด — ไม่ควรพบข้อความ "ใบเสร็จรับเงิน" อีกต่อไป
    Page Should Not Contain Element
    ...    xpath=//p[contains(@class,'text-green-700') and contains(normalize-space(),'ใบเสร็จรับเงิน')]

*** Keywords ***
Open Browser To Main Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Login As Passenger
    [Arguments]    ${username}    ${password}
    Go To              ${URL}login
    Wait Until Element Is Visible    id=identifier    timeout=10s
    Input Text         id=identifier    ${username}
    Input Text         id=password      ${password}
    Wait Until Element Is Visible    xpath=//button[@type='submit']    timeout=10s
    Click Element      xpath=//button[@type='submit']
    Sleep    3s
