# BMI Calculator Flutter App

A modern and intuitive BMI (Body Mass Index) calculator built with Flutter. This application provides a user-friendly interface to calculate BMI based on height, weight, age, and gender. It also offers personalized health advice based on the results.

## ✨ Features

*   **Gender Selection**: Choose between male and female for more accurate calculations.
*   **Height and Weight Input**: Interactive sliders and value adjusters for easy input.
*   **Age Input**: Simple adjuster for age.
*   **BMI Calculation**: Instant BMI calculation.
*   **Result Screen**: A detailed result screen with the calculated BMI, category (underweight, normal, overweight, obese), and color-coded feedback.
*   **Health Advice**: Personalized health tips based on the BMI result.
*   **Share Result**: Functionality to share the BMI result as an image.
*   **Responsive Design**: Adapts to different screen sizes using `flutter_screenutil`.
*   **Smooth Animations**: Engaging animations for a better user experience.

## 📱 Screenshots



## 🛠️ Tech Stack

*   **Framework**: Flutter
*   **Language**: Dart
*   **Key Packages**:
    *   flutter_screenutil: For responsive UI.
    *   screenshot: To capture the result screen.
    *   share_plus: To share the captured result.

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You need to have the Flutter SDK installed on your machine.

*   Flutter Installation Guide

### Installation

1.  Clone the repository:
    ```sh
    git clone https://github.com/your-username/bmi-calculator.git
    ```
    (Replace with your actual repository URL)

2.  Navigate to the project directory:
    ```sh
    cd bmi
    ```

3.  Install dependencies:
    ```sh
    flutter pub get
    ```

4.  Run the app:
    ```sh
    flutter run
    ```

## 📂 Project Structure

The project follows a feature-first structure to keep the code organized and maintainable.

```
lib/
├── core/
│   └── app_colors.dart      # Centralized color palette
├── feature/
│   └── bmi/
│       ├── logic/
│       │   └── calculator.dart  # BMI calculation logic
│       ├── screens/
│       │   ├── bmi_input_screen.dart # Main input screen
│       │   └── bmi_result_screen.dart # Result display screen
│       └── widgets/             # Reusable widgets for the BMI feature
└── main.dart                # App entry point
```

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.