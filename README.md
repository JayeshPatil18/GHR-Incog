<div align="left">
  <h1>GHR Incog 🚀 - Flutter App</h1>
  <a href="https://play.google.com/store/apps/details?id=com.apps.confession">
    <img alt="Play Store" src="https://img.shields.io/badge/Google_Play-34A853?style=for-the-badge&logo=google-play&logoColor=white" style="margin-left: 10px;">
  </a>
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" style="margin-left: 10px;">
  <img alt="Dart" src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" style="margin-left: 10px;">
  <img alt="Firebase" src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" style="margin-left: 10px;">
  <a href="https://github.com/JayeshPatil18/GHR-Icog">
    <img alt="GitHub" src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" style="margin-left: 10px;">
  </a>
</div>
</br>

Welcome to **GHR Incog**, the ultimate platform for fearless college conversations. Unlock the power of anonymous expression with GHR Incog! Tailored for G. H. Raisoni College of Engineering and Management, Pune, this mobile application redefines how college students communicate.

</br>

*Available on Play Store.* [Click here](https://play.google.com/store/apps/details?id=com.apps.confession)

![Available](https://github.com/JayeshPatil18/GHR-Icog/blob/master/ghr-incog.png)

## Description

**GHR Incog** empowers your voice and embraces anonymity. This platform is designed for college students to share their thoughts and opinions without revealing their identity. With a focus on G. H. Raisoni College of Engineering and Management, Pune, it enables students to engage in open and honest conversations.

## Features

- **Search Posts and Users**: Find specific posts and users quickly with robust search functionality.
- **Anonymous Profile**: Maintain your anonymity while expressing your thoughts.
- **Post and Comment**: Share your experiences and engage with others through posts and comments.
- **Leaderboard**: Discover the most active contributors in our community.
- **Get Posts from College Students**: View posts shared by fellow college students.

## Technology Used

- **Flutter**: For a seamless, beautiful cross-platform mobile application.
- **Dart**: For a flutter, dart language used to build UI and Logic.
- **Firebase**: Ensuring robust and scalable backend services including authentication, database, and cloud storage.
- **Node.js**: For backend REST API services to maintain user records.

## Project Structure

We follow a clean architecture approach to ensure a scalable and maintainable codebase. Below is an overview of our project structure:

```plaintext
lib
│
├── constants
│   ├── utils
│   ├── routes
│
├── features
│   ├── authentication
│   │   ├── data
│   │   │   └── repository
│   │   ├── domain
│   │   │   └── entities
│   │   ├── presentation
│   │       ├── bloc
│   │       ├── provider
│   │       ├── pages
│   │       └── widgets
│   │
│   ├── post
│       ├── data
│       │   └── repository
│       ├── domain
│       │   └── entities
│       ├── presentation
│           ├── bloc
│           ├── provider
│           ├── pages
│           └── widgets
```

## Getting Started

To get started with **Review House**, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/JayeshPatil18/GHR-Incog.git

1. **Install dependencies**:
   ```bash
   flutter pub get

1. **Run applicatoin**:
   ```bash
   flutter run
