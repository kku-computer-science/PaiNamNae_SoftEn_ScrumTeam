# [Sprint 3] - Changelog

บันทึกการเปลี่ยนแปลงของโปรเจกต์บน branch `main` ตั้งแต่วันที่ 5 มีนาคม 2569 เป็นต้นไป

---

## [2026-03-05]

### Jularat387-4 (Prew-kku)
- อัปโหลด Sprint Backlog สำหรับ Sprint 3 ลงในโฟลเดอร์ `sprint-backlog/`

### pichamon395-4
- เพิ่มไฟล์ `USERMANUAL.md` (PBI-16, PBI-bonus) และ `CHANGELOG.md`
- อัปเดต API Testing collection ฉบับสมบูรณ์ (Complete API test collection)
- **Fixed:** แก้ไขบั๊ก Modal ไม่ปิดและค้างหลังจาก Admin ปฏิเสธคำขอลบบัญชีในหน้า `admin/allrequests/index.vue`
- เพิ่ม API testing สำหรับ PBI-bonus (Payment System)

### Kittikorn587-5 (PersonZa)
- ทดสอบ 90-day time machine API บน Production สำเร็จ
- ปรับปรุง API paths และ Response structure ใน Postman collection
- เพิ่ม Response logic สำหรับตรวจสอบ Deletion cron job ใน Postman collection

### Jularat387-4 (Isaac-7262)
- ย้าย Test report ไปยังโฟลเดอร์ `doc/` และเพิ่มเอกสาร UAT PDF
- เปลี่ยนชื่อโฟลเดอร์รายงานผลการทดสอบ Sprint 2 ให้เป็นมาตรฐาน UAT

### Siwawit402-3 (Siwa-dev)
- เพิ่ม UAT Robot tests สำหรับ PBI-bonus และจัดทำเอกสารประกอบระบบการชำระเงินใน `test/Product_Backlog_Items-bonus/uat/`

---

## [2026-03-14]

### Kittikorn587-5 (PersonZa)
- **Feat:** พัฒนาระบบ Multi-step payment flow พร้อมระบบเลือกธนาคารแบบไดนามิก (Dynamic bank selection)
- **Feat:** อัปเดตไฟล์ `docker-compose.yml` เพื่อรองรับการตั้งค่าระบบใหม่
- **Chore:** Revert การเปลี่ยนแปลงที่ไม่ได้ตั้งใจในไฟล์ package และ `auth controller` เพื่อความเสถียรของระบบ

---

## [2026-03-16]

### pichamon395-4
- **Feat:** ปรับปรุง UI ส่วนการชำระเงิน, ใบเสร็จ (Receipt) และหน้า Admin pages
- อัปโหลด Source Code Snapshot ของ Sprint 2 (`sprint-2 code snapshot`)

---

## [2026-03-17]

### pichamon395-4
- เพิ่มระบบ Validation ตรวจสอบเลข PromptPay ให้ครบ 10 หรือ 13 หลักก่อนทำการบันทึกข้อมูลลงระบบ

---

## [2026-03-18] - ปัจจุบัน

### pichamon395-4
- **Chore:** เปลี่ยนชื่อไฟล์ (Rename) และปรับปรุงโครงสร้างไฟล์ภายในโปรเจกต์  
- **Chore:** ปรับปรุง file path เพื่อให้สอดคล้องกับโครงสร้าง Sprint 3  
- **Chore:** ลบไฟล์ที่ไม่จำเป็นออกจากระบบ  
- **Chore:** ย้ายไฟล์ไปยังโฟลเดอร์ `sprint/sprint-3` และอัปเดต `.gitignore`  
- **Chore:** ลบไฟล์ `.DS_Store` ออกจาก git tracking และเพิ่มเข้า `.gitignore`  
- **Docs:** เพิ่มรายชื่อผู้ร่วมพัฒนาใน `README` และปรับโครงสร้างเอกสาร Sprint 3  
- **Feat:** แก้ไข backend และเพิ่ม test cases สำหรับ Payment API  
- **Merge:** รวม pull request #58, #59, #60 และ #61 เข้าสู่ branch `main`  

### Siwawit402-3 (Siwa-dev)
- **Add:** เพิ่มรายงานผลการทดสอบ UAT test report สำหรับ PBI-16 เพื่อเตรียมพร้อมสำหรับการปิด Sprint  
- **Fix:** ลบไฟล์ `UAT_Test_Report_ProductBacklogItem_16.pdf` ที่ซ้ำหรือไม่ถูกต้อง  
- **Merge:** รวม branch `Siwawit402-3` เข้ากับ `main`  

### Kittikorn587-5 (PersonZa)
- **Feat:** สร้าง `Product_Backlog_Items-bonus`  
- **Test:** ทดสอบการออกแบบ API สำหรับ PBI-16  

---

## [2026-03-18] - Planned

### [Planned]
- สรุปผลการดำเนินงาน Sprint 3 (Sprint Review & Retrospective)  
- จัดเตรียมเอกสารส่งมอบงาน (Final Report, UAT, API Documentation)  
- ตรวจสอบความถูกต้องของไฟล์ทั้งหมดบน branch `main` ก่อนส่งงาน  
- ตรวจสอบความสมบูรณ์ของระบบ (System Validation) รอบสุดท้าย  