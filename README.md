# 🎓 Online Course Enrollment System

A comprehensive web-based course enrollment system built with Java, demonstrating advanced Java programming concepts including Collections Framework, JDBC, Servlets, JSP, and Swing GUI.

[![Java](https://img.shields.io/badge/Java-11+-orange.svg)](https://www.oracle.com/java/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

# 📑 Table of Contents

- Features
- Technologies Used
- Architecture
- Prerequisites
- Installation
- Usage
- Project Structure
- Java Concepts Demonstrated
- Database Schema
- API Endpoints
- Testing
- License
- Author

---

# ✨ Features

## 👨‍🎓 Student Features
- 📚 Browse available courses with seat availability
- ✅ Enroll in courses online
- 📊 View enrollment history
- 🔍 Filter available courses
- 💰 View course fees and instructor details

## 👨‍💼 Admin Features
- ➕ Add students and courses
- 📋 View all student and course records
- 🌐 Web-based admin panel
- 🖥️ Swing GUI for offline management

## ⚙️ System Features
- 🚫 Prevent duplicate enrollments
- 🎯 Eligibility verification based on semester
- 💺 Automatic seat management
- 🔒 Secure database queries using PreparedStatement
- ⚡ Fast searching using HashMap

---

# 🛠️ Technologies Used

| Technology | Purpose | Version |
|------------|---------|---------|
| Java | Core Programming Language | 11+ |
| JDBC | Database Connectivity | Built-in |
| Servlets | Request Handling | Jakarta EE |
| JSP | Dynamic Web Pages | 2.3+ |
| Swing | Desktop GUI | Built-in |
| MySQL | Relational Database | 8.0+ |
| Apache Tomcat | Servlet Container | 10.x |

---

# 🏗️ Architecture

The project follows a **3-Tier Architecture**:

```text
Presentation Layer
(JSP Pages + Swing GUI)

        ↓

Business Logic Layer
(Servlets + EnrollmentManager)

        ↓

Data Access Layer
(JDBC + DatabaseConnection)

        ↓

Database
(MySQL)

---

# 🗄️ Database Schema

## Students Table

| Column | Type |
|--------|------|
| student_id | VARCHAR |
| name | VARCHAR |
| email | VARCHAR |
| semester | INT |
| department | VARCHAR |

---

## Courses Table

| Column | Type |
|--------|------|
| course_id | VARCHAR |
| course_name | VARCHAR |
| instructor | VARCHAR |
| total_seats | INT |
| available_seats | INT |
| fees | DOUBLE |

---

## Enrollments Table

| Column | Type |
|--------|------|
| enrollment_id | INT |
| student_id | VARCHAR |
| course_id | VARCHAR |
| enrollment_date | TIMESTAMP |
| status | VARCHAR |

---

# 🔌 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | / | Home Page |
| GET | /courses | View Courses |
| POST | /process-enroll | Enroll Student |
| GET | /my-enrollments | View Enrollments |
| GET | /admin | Admin Panel |

---

# 🧪 Testing

## Sample Test Data

### Students
- 4AL23CS023 - Arpita Gavi
- 4AL23CS001 - Rahul Kumar
- 4AL23CS002 - Priya Sharma

### Courses
- CS501 - Advanced Java Programming
- CS502 - Database Management Systems
- CS503 - Web Technologies
- CS505 - Machine Learning Basics

---

# 📄 License

This project is licensed under the MIT License.

---

# 👤 Author

## Arpita Gavi
- USN: 4AL23CS023
- Department: Computer Science and Engineering
- Course: Advanced Java Programming
- Institution: Alva's Institute of Engineering and Technology

---

# 🙏 Acknowledgments

- Oracle Java Documentation
- Jakarta EE Documentation
- MySQL Documentation
- Apache Tomcat

---

# 🔮 Future Enhancements

- User authentication
- Payment integration
- Email notifications
- Mobile application support
- PDF report generation
- REST API integration

---

# 🎓 Project Ownership & Academic Information

**This project has been created as a Course Assignment Work.**

| | |
|---|---|
| Course | Advanced Java (BCS613D) |
| Created By | Arpita Gavi |
| USN | 4AL23CS023 |
| Department | Computer Science and Engineering |
| Institution | Alva's Institute of Engineering and Technology |

---

© 2024 Arpita Gavi - Course Assignment for Advanced Java (BCS613D)

Alva's Institute of Engineering and Technology, Computer Science and Engineering Department