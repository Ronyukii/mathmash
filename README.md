# MathMash

**MathMash** is a Flutter-based e-learning mobile application designed to support **Form 1 high school students** in learning **Modern Mathematics**.

The application aims to make mathematics learning more accessible and engaging through digital learning materials, guided practice activities, quizzes, and progress tracking.

## Project Objectives

- Provide digital learning materials for Form 1 Modern Mathematics.
- Help students practise mathematical concepts through interactive activities.
- Allow students to check their understanding through quizzes and assessments.
- Provide feedback and a way to monitor learning progress.

## Planned Learning Features

| Feature | Description |
|---|---|
| Lessons | Browse learning materials organized by chapter and topic. |
| Practice | Answer topic-based exercises and receive feedback. |
| Quizzes | Complete quizzes to assess understanding. |
| Progress | View completed lessons and quiz performance. |

*These are planned features; functionality will be implemented progressively during development.*

## Technology Stack

- **Framework:** Flutter
- **Programming language:** Dart
- **Version control:** Git and GitHub
- **Development tools:** Visual Studio Code and/or Android Studio

## Getting Started

### Prerequisites

Install the following before running the project:

- Flutter SDK
- Android Studio or Visual Studio Code
- An Android emulator or a physical Android device

Check your Flutter installation:

```bash
flutter doctor
```

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/USERNAME/MathMash.git
   ```

2. Open the project directory:

   ```bash
   cd MathMash
   ```

3. Install the project dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application:

   ```bash
   flutter run
   ```

Replace `USERNAME` with the GitHub account or organization that owns the repository.

### Testing on Devices (Android)

1. Navigate to mathmash folder and open cmd,

   ```bash
   flutter devices
   ```

2. If your device appears, you can run

   ```bash
   flutter run
   ```

3. For a standalone installation package, run

   ```bash
   flutter build apk --release
   ```

   Your apk will be generated at: build/app/outputs/flutter-apk/app-release.apk

   You can also install it directly through ADB:

   ```bash
   adb install build/app/outputs/flutter-apk/app-release.apk
   ```


## Project Structure

```text
lib/
├── app/                 # App configuration and navigation
├── data/                # Initial or locally stored learning content
├── models/              # Data models for lessons, questions and progress
├── screens/             # Main application screens
│   ├── home/
│   ├── lessons/
│   ├── practice/
│   ├── quizzes/
│   └── progress/
├── services/            # Data access and application services
├── theme/               # App colors and visual styling
├── utils/               # Shared helper functions
├── widgets/             # Reusable UI components
│   ├── common/
│   └── navigation/
└── main.dart            # Application entry point

assets/
├── fonts/
├── icons/
└── images/

test/                    # Automated tests
```

## Development Workflow

1. Pull the latest changes from `main`.
2. Create a branch for your task, for example:

   ```bash
   git checkout -b feature/lesson-screen
   ```

3. Make and test your changes.
4. Commit with a descriptive message:

   ```bash
   git add .
   git commit -m "Add lesson screen structure"
   ```

5. Push your branch and open a Pull Request to `main`.

Do not commit generated build files, local machine configuration, signing keys, API keys, or other secrets.

## Project Status

**Status:** Initial project setup and application structure.

Features and learning content are subject to development.

## Development Team

Add the project members and their roles here.

## License

To be decided.
