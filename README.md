# Smart Travel Expense Manager (SAP S/4HANA)

## Project Overview
The **Smart Travel Expense Manager** is an end-to-end enterprise Fiori application built using the modern **ABAP RESTful Application Programming Model (RAP)**. It allows employees to create, manage, and submit travel expenses, while enabling managers to approve or reject them.

This project was developed entirely in **Eclipse (ABAP Development Tools)** and demonstrates a cloud-ready, clean core approach to modern SAP development.

##  Screenshots

<img width="1916" height="957" alt="fiori ui 3" src="https://github.com/user-attachments/assets/2c6b515a-69ec-4be9-a723-2ecae9d9931e" />
<img width="1907" height="962" alt="fiori ui 2" src="https://github.com/user-attachments/assets/33874d50-c00f-457e-91ea-dd683a5eca22" />
<img width="1912" height="972" alt="fiori ui" src="https://github.com/user-attachments/assets/983d1837-ba02-4bf5-9c2b-14f3251986e7" />
<img width="1917" height="866" alt="eclipse server binding" src="https://github.com/user-attachments/assets/980d5001-3dda-4e84-9bad-7b12754119f2" />


##  Tech Stack & Skills Highlighted
* **Backend:** SAP ABAP (Inline Declarations, Constructor Expressions)
* **Framework:** ABAP RESTful Application Programming Model (RAP - Managed Scenario)
* **Data Modeling:** Core Data Services (CDS Views)
* **API:** OData V4 Service Exposure
* **Frontend:** SAP Fiori Elements (UI Annotations / Metadata Extensions)
* **Environment:** SAP S/4HANA, Eclipse ADT

---

## Key Features
* **Draft Handling (Autosave):** Out-of-the-box draft capabilities allowing users to pause work without losing data before final submission.
* **Custom Business Logic (Actions):** Custom `Approve` and `Reject` actions implemented in the Behavior Implementation (BIL) class.
* **Dynamic UI Control:** The "Approve" and "Reject" buttons are dynamically enabled/disabled based on the current status of the expense (Instance Features).
* **Backend Validations:** Ensures expense amounts are greater than zero before saving.
* **Auto-generated Fiori UI:** Frontend generated dynamically via CDS Metadata Extensions, requiring zero JavaScript.

---

## Architecture (Bottom-Up Approach)
1. **Database Layer:** Transparent tables created via DDL to store active expenses and auto-generated draft tables for work-in-progress data.
2. **Data Model Layer:** `ZI_Expense` (Root Entity) and `ZC_Expense` (Projection View) utilizing Core Data Services for optimized database push-down.
3. **Behavior Layer:** BDEF defining transactional behavior (Create, Update, Delete, Draft Actions) and ABAP classes containing the business logic.
4. **Service Provisioning Layer:** Service Definition and Service Binding exposing the projection view as an OData V4 UI service.

---

## How to Run (Development)
This project is built for **SAP S/4HANA** using **Eclipse ADT**. 
1. Import the ABAP objects into your package using standard ADT deployment.
2. Activate all objects in the bottom-up sequence (Table -> Interface View -> BDEF -> Class -> Projection View -> Metadata -> Service Definition/Binding).
3. Open the `ZUI_EXPENSE_BINDING` Service Binding in Eclipse.
4. Select the `Expense` entity and click **Preview** to launch the Fiori sandbox environment.
