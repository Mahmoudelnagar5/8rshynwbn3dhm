# 💰 Expense Tracker

A beautiful and intuitive Flutter application for tracking your personal finances. Manage your income and expenses with ease, visualize your financial data, and stay on top of your budget.

![Flutter Version](https://img.shields.io/badge/Flutter-3.10+-blue.svg)
![Dart Version](https://img.shields.io/badge/Dart-3.0+-blue.svg)
![Firebase](https://img.shields.io/badge/Firebase-Cloud%20Firestore-orange.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

---

## 📱 Features

### 🔐 Authentication
- **Email & Password Authentication** - Secure sign-up and sign-in with Firebase Auth
- **Email Verification** - Verify your email before accessing the app
- **Persistent Login** - Stay logged in across app restarts

### 💳 Transaction Management
- **Add Transactions** - Quickly add income or expense entries
- **Edit Transactions** - Modify existing transactions easily
- **Delete Transactions** - Remove unwanted entries with swipe-to-delete
- **Transaction Categories** - Separate income and expenses

### 📊 Financial Insights
- **Balance Overview** - Real-time balance calculation
- **Income Summary** - Track total earnings
- **Expense Summary** - Monitor total spending
- **Filter Options** - View All, Income only, or Expenses only

### 🎨 User Experience
- **Onboarding Flow** - Welcome screens for first-time users
- **Splash Screen** - Branded app launch experience
- **Smooth Animations** - Enhanced UI with animate_do package
- **Responsive Design** - Works on phones and tablets
- **Bottom Sheets** - Intuitive forms for adding/editing transactions

---

## 🏗️ Architecture

This app follows **Clean Architecture** principles with:

```
lib/
├── core/                    # Shared utilities and widgets
│   ├── functions/          # Helper functions (snackbars, bottom sheets)
│   └── widgets/            # Reusable UI components
├── features/               # Feature-based modules
│   ├── auth/              # Authentication feature
│   │   ├── presentation/
│   │   │   ├── view/      # UI screens (Sign In, Sign Up, Verification)
│   │   │   └── view_model/# AuthCubit - State management
│   ├── home/              # Home/Dashboard feature
│   │   ├── data/
│   │   │   ├── models/    # TransactionItem model
│   │   │   └── repo/      # Transactions repository
│   │   ├── presentation/
│   │   │   ├── view/      # Home screen, Add/Edit sheets
│   │   │   ├── view_model/# TransactionsCubit
│   │   │   └── widgets/   # UI components
│   ├── onboarding/        # Onboarding feature
│   └── splash/           # Splash screen feature
├── firebase_options.dart  # Firebase configuration
└── main.dart             # App entry point
```

### State Management
- **Flutter Bloc (Cubit)** - For predictable state management
- **AuthCubit** - Handles authentication states
- **TransactionsCubit** - Manages transaction data and UI states

### Local Storage
- **Hive** - Fast, lightweight local database for:
  - Transaction data persistence
  - User authentication status
  - App settings

### Backend
- **Firebase Authentication** - User authentication
- **Cloud Firestore** - User data storage

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ^3.10.1
- Dart SDK ^3.0.0
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Mahmoudelnagar5/-.git
   cd expense_tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Email/Password authentication
   - Enable Cloud Firestore
   - Download `google-services.json` for Android and place it in `android/app/`
   - Download `GoogleService-Info.plist` for iOS and place it in `ios/Runner/`
   - Run:
     ```bash
     flutterfire configure
     ```

4. **Generate Hive adapters**
   ```bash
   flutter packages pub run build_runner build
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

---

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `firebase_core` | ^4.4.0 | Firebase core functionality |
| `firebase_auth` | ^6.1.4 | Authentication |
| `cloud_firestore` | ^6.1.2 | Cloud database |
| `flutter_bloc` | ^9.1.1 | State management |
| `hive` | ^2.2.3 | Local database |
| `hive_flutter` | ^1.1.0 | Hive Flutter integration |
| `flutter_slidable` | ^4.0.3 | Swipe actions |
| `smooth_page_indicator` | ^1.1.0 | Onboarding indicators |
| `animate_do` | ^4.2.0 | Animations |
| `device_preview` | ^1.3.1 | Responsive testing |

---

## 📸 Screenshots

### Splash & Onboarding
<p align="center">
  <img src="assets/screenshots/splash.png" width="200" alt="Splash Screen"/>
  <img src="assets/screenshots/onboarding1.png" width="200" alt="Onboarding 1"/>
  <img src="assets/screenshots/onboarding2.png" width="200" alt="Onboarding 2"/>
</p>

### Authentication
<p align="center">
  <img src="assets/screenshots/signin.png" width="200" alt="Sign In"/>
  <img src="assets/screenshots/signup.png" width="200" alt="Sign Up"/>
  <img src="assets/screenshots/email_verify.png" width="200" alt="Email Verification"/>
</p>

### Home & Transactions
<p align="center">
  <img src="assets/screenshots/home.png" width="200" alt="Home Screen"/>
  <img src="assets/screenshots/add_transaction.png" width="200" alt="Add Transaction"/>
  <img src="assets/screenshots/edit_transaction.png" width="200" alt="Edit Transaction"/>
</p>

---

## 🔮 Future Enhancements

- [ ] **Data Export** - Export transactions to CSV/PDF
- [ ] **Charts & Graphs** - Visual expense analytics
- [ ] **Budget Goals** - Set monthly spending limits
- [ ] **Categories** - Custom transaction categories
- [ ] **Recurring Transactions** - Auto-repeat entries
- [ ] **Dark Mode** - Theme switching
- [ ] **Multi-language** - Internationalization support
- [ ] **Cloud Sync** - Backup to cloud storage

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Mahmoud Elnagar**

- GitHub: [@Mahmoudelnagar5](https://github.com/Mahmoudelnagar5)

---

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) - UI toolkit
- [Firebase](https://firebase.google.com/) - Backend services
- [Hive](https://hivedb.dev/) - Local database
- [Flutter Bloc](https://bloclibrary.dev/) - State management

---

<div align="center">
  <p>Made with ❤️ using Flutter</p>
</div>
