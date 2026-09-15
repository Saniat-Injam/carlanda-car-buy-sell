
# 🚗 Carlanda

### *A Modern Car Marketplace — Buy & Sell with Confidence*

A full-featured **Flutter** mobile app covering the complete car-buying journey —  
from authentication & discovery to booking, payment, and real-time delivery tracking.


## 📖 About

**Carlanda** is a cross-platform mobile application for buying and selling cars. Users can browse listings, view detailed car specs, book a car with delivery, calculate costs, and pay — all in one seamless flow. The app also features real-time WebSocket support chat, car delivery tracking, and a full profile management system.

---

## ✨ Core Features

| | Feature | Description |
|:---:|:---|:---|
| 🔐 | **Authentication** | Email/password, Google Sign-In, OTP verification, forgot/reset password |
| 🏠 | **Home & Discovery** | Carousel car listings, featured sections, quick categories |
| 🔍 | **Search** | Real-time car search and filtering |
| ❤️ | **Favorites** | Save and manage wishlist cars |
| 📋 | **Booking Flow** | Details → Delivery Info → Cost Calc → Payment → Success |
| 💳 | **Multi-Payment** | Express pay, Credit/Debit card (Visa/Mastercard), Bank transfer |
| 👤 | **Profile** | Edit info, upload photo, change password, booking history |
| 🔔 | **Notifications** | In-app alerts for bookings and activity |
| 📦 | **Car Tracking** | Track delivery status and view progress |
| 💬 | **Live Chat** | WebSocket support chat with heartbeat & auto-reconnect |
| 🌍 | **Localization** | Multi-language support infrastructure |

---

## 🏗️ Architecture

The project follows a clean **Feature-First** architecture with strict separation of concerns, managed via **GetX**.

```
lib/
├── 🧩 core/
│   ├── bindings/              ← GetX dependency injection
│   ├── common/widgets/        ← Shared reusable UI components
│   ├── models/                ← Shared data models
│   ├── services/
│   │   ├── auth_service.dart          ← Token & session management
│   │   ├── local_storage_service.dart ← SharedPreferences wrapper
│   │   ├── network_caller.dart        ← REST API client (GET/POST/PUT/PATCH/DELETE)
│   │   └── web_socket_service.dart    ← WebSocket + heartbeat + auto-reconnect
│   └── utils/
│       ├── constants/         ← Colors, sizes, URLs, icon paths, enums
│       ├── extensions/        ← Dart extensions (spacing, color)
│       └── logging/           ← Logger helper
│
└── 🚀 features/
    ├── authentication/        ← Login · Sign Up · OTP · Forgot/Reset Password
    ├── details/               ← Car Details · Delivery · Cost Calc · Payment
    ├── favorite/              ← Wishlist management
    ├── home/                  ← Home screen & car listings
    ├── landing/               ← Welcome screen
    ├── notifications/         ← In-app notifications
    ├── onboarding/            ← Onboarding slides
    ├── profile/               ← Settings · Bookings · History · Language
    ├── profile_setup/         ← Profile picture after sign-up
    ├── search/                ← Search & filter
    ├── splash_screen/         ← Splash & auth guard
    ├── support_chat/          ← Real-time WebSocket chat overlay
    ├── track_car/             ← Order tracking & progress
    └── view_cars/             ← Full car browse screen
```

> **Each feature follows:** `binder/` → `controller/` → `data/` → `presentation/(view/ + components/)`

---

## 🛠️ Tech Stack

| Category | Technology |
|:---|:---|
| **Framework** | Flutter 3.x |
| **Language** | Dart 3.x |
| **State Management** | GetX |
| **Authentication** | Firebase Auth · Google Sign-In |
| **HTTP / API** | `http` · `dio` |
| **Real-time** | `web_socket_channel` |
| **Storage** | `shared_preferences` · `flutter_secure_storage` |
| **Media** | `image_picker` · `image_cropper` |
| **UI** | `carousel_slider` · `pinput` · `flutter_svg` · `dotted_border` · `flutter_spinkit` |
| **Fonts** | `google_fonts` |
| **Environment** | `flutter_dotenv` |
| **Localization** | `intl` |
| **Logging** | `logger` |

---

## 📸 App Flow

```
🚀 Splash Screen
     └── 🎯 Onboarding
           └── 🏁 Landing Screen
                 ├── 🔑 Login → OTP → 🏠 Home
                 ├── 📝 Sign Up → OTP → 🖼️ Profile Setup → 🏠 Home
                 └── 🔵 Google Sign-In → 🏠 Home
                       │
                       ├── 🔍 Search Cars
                       ├── 🚘 Car Details → 📦 Delivery → 💰 Cost Calc → 💳 Payment → ✅ Success
                       ├── ❤️  Favorites
                       ├── 🔔 Notifications
                       ├── 📍 Track Car → 📊 View Progress
                       ├── 💬 Support Chat (WebSocket)
                       └── 👤 Profile → Info · Password · Bookings · History · Language
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.8.1` & Dart SDK `^3.8.1`
- Android Studio or VS Code with Flutter extension
- A configured Firebase project (Android + iOS)

### Installation

```bash
# 1. Clone the repo
git clone https://github.com/your-username/carlanda-car-buy-sell.git
cd carlanda-car-buy-sell

# 2. Install packages
flutter pub get

# 3. Create your .env file
echo "BASE_URL=https://your-api-base-url.com" > .env
echo "SOCKET_URL=wss://your-websocket-url.com" >> .env

# 4. Add Firebase config files
#    android/app/google-services.json
#    ios/Runner/GoogleService-Info.plist

# 5. Run
flutter run
```

---

## 🔒 Security

- 🔑 API secrets stored in `.env` — **excluded from git**
- 🛡️ Auth tokens persisted with `flutter_secure_storage`
- 🔥 Firebase config files are **git-ignored**

---

## 👨‍💻 Author

Built with ❤️ using **Flutter**

