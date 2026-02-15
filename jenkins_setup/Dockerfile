# ใช้ตัวตั้งต้นจาก Official
FROM jenkins/jenkins:lts

# เปลี่ยนเป็น root เพื่อติดตั้งโปรแกรม
USER root

# สั่งติดตั้ง Docker ลงไปใน Image นี้เลย (จะได้ไม่ต้องมาพิมพ์เองทีหลัง)
RUN apt-get update && \
    apt-get install -y docker.io && \
    rm -rf /var/lib/apt/lists/*