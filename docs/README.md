# P2P Loan Platform Architect Design Document

## Components Diagram

![Components Diagram](/arch.uml.png)

## Work Flow Process

### Borrow Order Process

![Borrow Order Process](http://java.oriente.com.ph/activiti_image_server/proxy?src=http://dev.orienteexpress.com/BorrowOrderProcess.bpmn)

### Invest Order Process

![Invest Order Process](http://java.oriente.com.ph/activiti_image_server/proxy?src=http://dev.orienteexpress.com/InvestOrderProcess.bpmn)

### Lend Order Process

![Lend Order Process](http://java.oriente.com.ph/activiti_image_server/proxy?src=http://dev.orienteexpress.com/LendOrderProcess.bpmn)

### Loan Process

![Loan Order Process](http://java.oriente.com.ph/activiti_image_server/proxy?src=http://dev.orienteexpress.com/LoanProcess.bpmn)

### Repay Order Process

![Repay Order Process](http://java.oriente.com.ph/activiti_image_server/proxy?src=http://dev.orienteexpress.com/RepayOrderProcess.bpmn)

### Transaction(Txn) Order Process

![Txn Order Process](http://java.oriente.com.ph/activiti_image_server/proxy?src=http://dev.orienteexpress.com/TxnOrderProcess.bpmn)

## Core Database Schema

![ER Diagram](/db.uml.png)

## Usage

start local server to preview and edit plantuml file.

```
npm build

npm start

homepage visit: http://localhost:8181/
```
