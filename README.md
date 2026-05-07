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