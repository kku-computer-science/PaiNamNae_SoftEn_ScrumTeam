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
- **Feat:** แก้ไข backend และเพิ่ม test cases สำหรับ Payment API
- **Docs:** เพิ่มรายชื่อผู้ร่วมพัฒนาใน `README` และจัดโครงสร้าง Sprint 3
- **Chore:** ลบ `.DS_Store` ออกจาก git tracking และเพิ่มลงใน `.gitignore`
- **Chore:** ย้ายไฟล์ที่ค้างอยู่ใน `sprint/sprint-3` ไปที่ `sprint-3` และอัปเดต `.gitignore`
- **Chore:** เพิ่ม test code และ test data สำหรับ Payment API (PBI-bonus)
- **Chore:** เปลี่ยนชื่อไฟล์และ file path ให้สอดคล้องกับโครงสร้าง Sprint 3
- **Chore:** ลบไฟล์และโฟลเดอร์ที่ไม่จำเป็นออกจากระบบ

### Kittikorn587-5
- **Feat:** สร้างโฟลเดอร์ `Product_Backlog_Items-bonus` พร้อมไฟล์ที่เกี่ยวข้อง
- **Test:** ทดสอบการออกแบบ API สำหรับ PBI-16
- **Docs:** เพิ่มไฟล์ `testReportAPI.pdf` สำหรับ PBI-16

### Siwawit402-3
- **Add:** เพิ่มรายงานผลการทดสอบ UAT test report และ UAT test data สำหรับ PBI-16
- **Fix:** ลบไฟล์ `UAT_Test_Report_ProductBacklogItem_16.pdf` และ `UAT_Test_Data_ProductBacklogItem_16.pdf` ที่ซ้ำหรือไม่ถูกต้อง

### Ammika356-3
- **Docs:** อัปโหลด ADAPT-blueprint สำหรับ PBI-16 และ PBI-bonus
- **Chore:** เปลี่ยนชื่อไฟล์ ADAPT-blueprint ให้ระบุชื่อ PBI อย่างชัดเจน (เพิ่ม `(bonus)` ต่อท้าย)
- **Chore:** ลบไฟล์ ADAPT-blueprint เก่าที่ไม่มีชื่อ PBI ออก

### Bunyasak604-1
- **Docs:** เพิ่มไฟล์ `CHANGELOG.md` และ `USER MANUAL.md` สำหรับ Sprint 3

### Jularat387-4
- **Docs:** อัปโหลดรูป sprint backlog สำหรับ Sprint 3

---