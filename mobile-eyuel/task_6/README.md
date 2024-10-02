# 2024 Project Phase Mobile Tasks - Task 6
## Overview
This project is part of the 2024 Project Phase for mobile development tasks. Task 6 focuses on implementing specific features and functionalities for a mobile application using Flutter. This project is made following Clean Architecture and TDD (Test-Driven Development) principles.

## Table of Contents
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [Technologies and Dependencies](#technologies-and-dependencies)
- [Contributing](#contributing)
- [License](#license)

## Project Structure
```
/2024-project-phase-mobile-tasks
    └── mobile-eyuel
            └── task_6
                    ├── lib
                    ├── test
                    ├── pubspec.yaml
                    └── README.md
```

## Installation
1. **Clone the repository:**
     ```sh
     git clone https://github.com/yourusername/2024-project-phase-mobile-tasks.git
     ```
2. **Navigate to the project directory:**
     ```sh
     cd /Users/joel/Documents/flutter_dev/2024-project-phase-mobile-tasks/mobile-eyuel/task_6
     ```
3. **Install dependencies:**
     ```sh
     flutter pub get
     ```

## Usage
1. **Run the application:**
     ```sh
     flutter run
     ```

## Features

### Auth Features
- **Login**: Allows users to log into the application.
- **Logout**: Allows users to log out of the application.
- **Register**: Allows new users to create an account.
- **Get User**: Retrieves the current user's information.

### Chat Features
- **Initiate Chat**: Starts a new chat with a specified user.
- **View My Chats**: Displays a list of all chats the user is involved in.
- **View My Chat by ID**: Displays a specific chat by its ID.
- **Get Chat Messages**: Retrieves messages from a specific chat.
- **Delete Chat**: Deletes a specific chat.

### Product Features
- **Create Product**: Allows the creation of a new product.
- **Update Product**: Updates an existing product.
- **View All Products**: Retrieves a list of all products.
- **View Single Product**: Retrieves details of a single product by its ID.
- **Delete Product**: Deletes a specific product.

## Technologies and Dependencies
This project uses the following technologies and dependencies:

- **Flutter**: An open-source UI software development kit created by Google for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Cupertino Icons**: A package that provides iOS style icons for use in Flutter applications.

- **dartz**: A functional programming library for Dart that provides functional data structures and combinators.
- **equatable**: A Dart package that helps to implement value equality without needing to explicitly override `==` and `hashCode`.
- **flutter_bloc**: A state management library that helps to implement the BLoC (Business Logic Component) design pattern.
- **get_it**: A simple service locator for Dart and Flutter projects, used for dependency injection.
- **http**: A composable, Future-based library for making HTTP requests in Dart.
- **internet_connection_checker**: A package that checks the status of the internet connection.
- **shared_preferences**: A Flutter plugin for reading and writing simple key-value pairs to persistent storage.
- **bloc_test**: A testing library for the `bloc` package, providing utilities to test BLoC classes.
- **bloc**: A predictable state management library that helps to separate presentation and business logic.
- **cached_network_image**: A Flutter library for loading and caching network images.
- **image_picker**: A Flutter plugin for selecting images from the gallery or taking new pictures with the camera.
- **get**: A Flutter package that provides state management, dependency injection, and route management.
- **shimmer**: A package that provides a shimmer effect to indicate that the content is loading.
- **google_fonts**: A package that allows developers to use fonts from Google Fonts in their Flutter applications.
- **flutter_test**: The core testing framework provided by Flutter for writing unit and widget tests.
- **flutter_lints**: A package that provides recommended lints for Flutter projects to help enforce best practices.
- **build_runner**: A package that provides a concrete way to generate code using Dart's build system.
- **mockito**: A Dart package for creating mock objects in tests.
- **mocktail**: A Dart package for mocking and stubbing in tests, similar to `mockito`.
- **test**: The standard testing framework for Dart, used for writing unit tests, integration tests, and end-to-end tests.

