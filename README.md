# 🛍️ Sairon - Production E-commerce Application

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![BLoC](https://img.shields.io/badge/State_Management-BLoC-02569B?style=for-the-badge)
![Architecture](https://img.shields.io/badge/Architecture-Clean_Architecture-6DB33F?style=for-the-badge)

**A scalable and production-ready mobile e-commerce application built with Flutter.**

[🌐 Website](https://saironstore.ir/) • 
[📱 Cafebazaar](https://cafebazaar.ir/app/ir.saironstore.app) • 

</div>

---

## 📌 Overview

Sairon is a real-world e-commerce application developed with a focus on scalability, maintainability, and performance.  
The project follows Clean Architecture principles and uses BLoC for predictable state management.

This repository represents a production-grade mobile commerce solution including authentication, cart management, order flow, and push notifications.

---

## 🏗 Architecture

The project follows **Clean Architecture** with strict layer separation:

```
lib/
 ├── core/
 ├── features/
 │    ├── auth/
 │    ├── home/
 │    ├── cart/
 │    ├── product/
 │    └── profile/
 └── main.dart
```

### Layers

- **Presentation Layer**
  - UI (Widgets)
  - BLoC / Cubit
- **Domain Layer**
  - Entities
  - UseCases
  - Repository contracts
- **Data Layer**
  - Models
  - Repository implementations
  - Remote & Local data sources

This structure ensures:
- High testability
- Low coupling
- Clear separation of concerns
- Easy feature scaling

---

## 🛠 Tech Stack

| Category | Technologies |
|----------|-------------|
| Framework | Flutter |
| Language | Dart |
| State Management | BLoC / Cubit |
| Networking | Dio (REST API) |
| Architecture | Clean Architecture |
| Local Storage | Hive, Shared Preferences |
| Notifications | Firebase Cloud Messaging |
| Dependency Injection | get_it |
| Design | Material 3 |

---

## 🚀 Core Features

- JWT Authentication (Login / Register)
- Product Listing with Pagination
- Advanced Product Search
- Persistent Shopping Cart
- Wishlist Management
- Order Submission Flow
- Push Notifications (FCM)
- Dark / Light Theme Support

---

## 📸 Screenshots

> Add real screenshots here for better portfolio presentation.

```
assets/screenshots/home.png
assets/screenshots/product.png
assets/screenshots/cart.png
```

---

## ⚙️ Getting Started

### Prerequisites

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0

### Installation

```bash
git clone https://github.com/MrPouyaSaad/sairon.git
cd sairon
flutter pub get
flutter run
```

---

## 🎯 Why This Project Matters

This project demonstrates:

- Real-world API integration
- Production-level architecture
- Scalable feature-based structure
- Clean separation of business logic
- Maintainable state management using BLoC

---

## 👨‍💻 Developer

**Pouya Sadeghzadeh**  
Flutter Developer  

GitHub: https://github.com/MrPouyaSaad  
Email: Mr.PouyaSadeghzadeh@gmail.com  

---

© 2025 Sairon
