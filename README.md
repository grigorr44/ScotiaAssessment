## Overview

The app loads transactions from the provided `transaction-list.json` file, displays them in a transaction list, and shows additional information on a details screen.

The project uses a feature-based structure for the transaction flow and separates networking, services, models, view models, views, navigation, resources, and shared utilities.

## Requirements Covered

✅ Display a list of transactions  
✅ Show merchant name, description, and amount in the list  
✅ Open a transaction details screen when a transaction is selected  
✅ Show credit/debit transaction status on the details screen  
✅ Show account information and amount on the details screen  
✅ Show an expandable/collapsible tooltip  
✅ Close the details screen and return to the transaction list  
✅ Load the provided local JSON file instead of making a real API call  
✅ Add unit tests where useful  

## Assessment Note

### If given more time, I would improve the following areas:

### 1. Move hard-coded strings

Some UI text is currently hard-coded in views and view models. I would move these strings into a centralized constants file or localization files. This would make the project easier to maintain and prepare for future localization.

### 2. Improve error handling and retry behavior

The current error handling is simple.
Next, I would add a better error state UI with a retry action.

### 3. Improve dependency injection

The app already uses protocols for services and networking, which makes the main logic testable. With more time, I would centralize dependency creation using a small dependency container. I would also consider a lightweight third-party dependency injection library to keep object creation and feature wiring more consistent.

### 4. Make `TransactionTooltipView` reusable

`TransactionTooltipView` is currently built for this transaction details screen.

If this type of tooltip is needed in other parts of the app, I would make it generic by passing title, details, icon, and action text as configurable properties.


## Tech Stack

- Swift
- SwiftUI
- Observation
- Swift Testing

## Project Structure

```text
ScotiaAssessment
├── Features
│   └── Transactions
│       ├── Models
│       │   ├── DTO
│       │   ├── Transaction.swift
│       │   └── TransactionType.swift
│       ├── ViewModels
│       │   ├── TransactionListViewModel.swift
│       │   └── TransactionDetailsViewModel.swift
│       └── Views
│           ├── TransactionList
│           └── TransactionDetails
├── navigation
│   ├── AppRoute.swift
│   └── Router.swift
├── networking
│   ├── NetworkClient.swift
│   └── NetworkError.swift
├── resources
│   ├── Assets.xcassets
│   └── transaction-list.json
├── Services
│   └── TransactionService.swift
└── Utilities
    ├── Constants
    └── Extensions