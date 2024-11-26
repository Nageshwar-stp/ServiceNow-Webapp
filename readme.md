# Project Name: ServiceNow

## Software Requirements:

1. Java 8
2. MySQL Database
3. JSP and Servlet
4. Tomcat 9
5. NetBeans IDE (with Java EE)
6. Operating System: Windows/Mac/Linux

---

## Installation

### 1. Direct Execution

1. **Install Java 8** (with JSP and Servlet)
2. **Install Tomcat 9**
3. Place the `ServiceNow.war` file in the following directory:
<Directory of Tomcat installation>\apache-tomcat-9.0.33\webapps
4. Include all the required dependencies.
5. Open your web browser and type:
localhost:8080/ServiceNow

Then press Enter.

---

### 2. Using NetBeans IDE

1. **Install Java 8** (with JSP and Servlet)
2. **Install Tomcat 9**
3. **Install NetBeans IDE**
4. Install the **Java EE plugin** in NetBeans IDE
5. Open the `ServiceNow` project in NetBeans
6. Setup **Tomcat Server** in NetBeans
7. Click **Clean and Build**
8. Run the project
9. Open your web browser and type:
localhost:8080/ServiceNow

Then press Enter.

---

## Database Setup

For the execution of the project, you need to set up the MySQL database with the following credentials:

- **User:** servicenow_user
- **Database:** service_now
- **Password:** servicenow1234

For more connection details, check the `ServiceNow/src/java/database/DatabaseConnection.java` file.

---

## Live Demo of Project

- Visit [http://servicenow.ga](http://servicenow.ga)
- Or visit the demo server at: [http://44.194.192.185:8080/ServiceNow](http://44.194.192.185:8080/ServiceNow)

---

## Demo Credentials

### 1. For Admin:
- **Username:** admin
- **Password:** admin

### 2. For Employee:
- **Username:** employee
- **Password:** employee

### 3. For Support:
- **Username:** support
- **Password:** support
