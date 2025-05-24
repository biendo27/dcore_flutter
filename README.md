# Flutter Dcore

Base code for starting a new Flutter project.

## Getting Started

### Prerequisites

- **Flutter SDK:** Ensure that you have Flutter installed. You can download it from the [Flutter website](https://flutter.dev).
- **Dart:** Comes integrated with Flutter, but make sure your environment is set up correctly.
- **IDE:** Use an editor like VS Code or Android Studio that supports Flutter development.

### Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/your_username/flutter_dcore.git
    cd flutter_dcore
    ```

2. **Install Flutter dependencies:**

    ```bash
    flutter pub get
    ```

3. **Reset the project:**

    ```bash
    cmd /c "tools\windows\app\reset_app.bat" 
    ```

    This will reset the project to the initial state, like remove all the build files.

4. **Run the project:**

    Just using VS Code or Android Studio to run the project.
    Everything is set up, you can just run the project.

5. **Setup flavor:**

    1. Open [`flavorizr.yaml`](flavorizr.yaml) file.
    2. In the `instructions` section, add or remove the instructions for the flavor.
    3. In the `app` section, update `name` and `icon`.
    4. In the `android` section, update `applicationId`, `firebase` and `resValues`.
    5. In the `buildConfigFields` section, update `APP_ENVIRONMENT`, `API_BASE_URL`, and `IS_DEBUG`.
    6. In the `ios` section, update `bundleId` and `buildSettings`.
    7. In the `variables` section, update `API_BASE_URL`.
    8. Make sure you update all the variables for each flavor in the [`flavorizr.yaml`](flavorizr.yaml) file.
    9. Run the script.

    ```bash
    dart run flutter_flavorizr
    ```

    This will generate the flavor for the corresponding environment.

6. **Setup app environment variables:**

    1. Open [`.env\.env.dev`](.env/.env.dev) file.
    2. Update the variables for the development environment.
    3. Open [`.env\.env.stg`](.env/.env.stg) file.
    4. Update the variables for the staging environment.
    5. Open [`.env\.env.prod`](.env/.env.prod) file.
    6. Update the variables for the production environment.
    7. Make sure you update all the variables for each flavor in the [`.env\.env.dev`](.env/.env.dev), [`.env\.env.stg`](.env/.env.stg), and [`.env\.env.prod`](.env/.env.prod) files.
   
   This will setup the app environment variables for all environments.

7. **Setup app icon:**

    1. Open [`assets\images`](assets/images) folder.
    2. Replace the `main_icon.png` file with your app icon.
    3. Run the script.

    ```bash
    cmd /c "tools\windows\app\generate_app_icon.bat" 
    ```

    This will generate the app icon for all environments in app.

8. **Configure Firebase:** 

    1. Open [`tools\windows\app\flutterfire_config.bat`](tools/windows/app/flutterfire_config.bat) file.
    2. Replace the `%IOS_BUNDLE_ID%` variable with your app's bundle ID.
    3. Replace the `%ANDROID_PACKAGE%` variable with your app's package name.
    4. Replace the `%PROJECT%` variable with your Firebase project ID.
    5. Run the script.

    ```bash
    cmd /c "tools\windows\app\flutterfire_config.bat %ENV%" 
    ```

    Replace `%ENV%` with `dev`, `stg`, or `prod` to configure the Firebase project for the corresponding environment.

9.  **Build the app apk file:**

    ```bash
    cmd /c "tools\windows\app\build_apk.bat %ENV%" 
    ```

    Replace `%ENV%` with `dev`, `stg`, or `prod` to build the app apk file for the corresponding environment.

10. **Build the app appbundle file:**

    ```bash
    cmd /c "tools\windows\app\build_appbundle.bat %ENV%" 
    ```

    Replace `%ENV%` with `dev`, `stg`, or `prod` to build the app appbundle file for the corresponding environment.

11. **Install the app:**

    ```bash
    cmd /c "tools\windows\app\install_app.bat %ENV%" 
    ```

    Replace `%ENV%` with `dev`, `stg`, or `prod` to install the app for the corresponding environment.

12. **Generate the keystore file:**
    1. Open [`android\key.properties`](android\key.properties) file.
    2. Update keystore information like `storePassword`, `keyPassword`, `keyAlias`, `storeFile`, `keyCN`, `keyOU`, `keyO`, `keyL`, `keyS`, and `keyC`.
    3. Run the script.

    ```bash
    cmd /c "tools\windows\key\generate_keystore.bat" 
    ```

    This will generate the keystore file for the android application.

13. **Run, build, and analyze the iOS app:**

    Just using Android Studio in Mac M1 to run, build, and analyze the iOS app.

    - **Run:** Just run the project in Android Studio in Mac.
    - **Build:** Build the project in Android Studio in Mac.
    - **Analyze:** Analyze the project in Android Studio in Mac.
  
### Development Workflow

- **Hot Reload:** Make use of Flutter's hot reload to see immediate changes while developing.
- **Debugging:** Use your IDE's debugging tools, or run the app in debug mode from the command line (`flutter run --debug`).
- **Testing:** Run unit and widget tests with:

    ```bash
    flutter test
    ```

## Contributing

If you'd like to contribute to Flutter Dcore, please follow these steps:

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/my-feature`).
3. Commit your changes (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature/my-feature`).
5. Open a Pull Request.

Ensure that your code adheres to established Flutter best practices and that all tests pass before submitting your pull request.

## Additional Resources

- **Flutter Documentation:** [Flutter Docs](https://docs.flutter.dev/)
- **Flutter Codelabs:** [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- **Recipes and Guides:** [Flutter Cookbook](https://docs.flutter.dev/cookbook)

## License

This project is licensed under the Apache License, Version 2.0.
You may obtain a copy of the License at:

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.

---

This documentation file provides a clear overview, explains the project structure, guides new users through the setup process, and outlines a contribution workflow. Adjust any sections according to your specific project needs (such as repository URLs, license details, or additional configuration settings).

## Project Structure

The current project is organized to support multiple environments and clean architecture principles, along with Windows-specific build tools:

```
flutter_dcore/
├─ android/
│   ├─ app/
│   │   ├─ build.gradle
│   │   ├─ src/
│   │   │   ├─ dev/
│   │   │   ├─ stg/
│   │   │   └─ prod/
│   │   └─ key.properties
├─ ios/
│   ├─ Runner.xcodeproj/
│   └─ Runner/
│       ├─ Info.plist
│       └─ other_files
├─ lib/
│   ├─ config/
│   │   ├─ di/
│   │   ├─ l10n/
│   │   ├─ routes/
│   │   ├─ services/
│   │   ├─ share/
│   │   └─ themes/
│   ├─ core/
│   │   ├─ constants/
│   │   ├─ helpers/
│   │   └─ utils/
│   └─ src/
│       ├─ data/
│       │   ├─ datasources/
│       │   │   ├─ apis/
│       │   │   └─ sockets/
│       │   ├─ models/
│       │   └─ repositories/
│       ├─ domain/
│       │   ├─ entities/
│       │   ├─ repositories/
│       │   └─ usecases/
│       └─ presentation/
│           ├─ blocs/
│           ├─ pages/
│           └─ widgets/
├─ test/
├─ tools/
│   └─ windows/
│       ├─ app/
│       │   ├─ build_apk.bat
│       │   ├─ build_appbundle.bat
│       │   ├─ flutterfire_config.bat
│       │   ├─ generate_app_icon.bat
│       │   └─ install_app.bat
│       └─ key/
│           └─ generate_keystore.bat
├─ pubspec.yaml
├─ README.md
├─ DOCUMENTATION.md
└─ .env/
    ├─ .env.dev
    ├─ .env.stg
    └─ .env.prod
```

- `lib/config`: Contains configuration files for dependency injection, localization, routes, services, shared constants, and themes.
- `lib/core`: Contains core constants, helpers, and utility classes used throughout the app.
- `lib/src`: Follows the clean architecture pattern with data, domain, and presentation layers.
  - `data`: Contains data sources (APIs and sockets), models, and repository implementations.
  - `domain`: Contains entities, repository interfaces, and use cases.
  - `presentation`: Contains BLoCs, pages, and widgets.
- `test`: Contains unit and widget tests.
- `tools/windows`: Contains Windows-specific tools and scripts.
- `.env`: Contains environment-specific configuration files.

## Services

The project includes several services to handle various functionalities:

- `AppService`: Initializes and configures the app, including error handling, UI responsiveness, and loading states.
- `CameraService`: Handles camera-related operations, such as initializing cameras, requesting permissions, capturing pictures, and recording videos.
- `DeepLinkService`: Handles deep linking functionality.
- `DeviceInfoService`: Retrieves device information and generates a unique device token.
- `FileService`: Handles file-related operations, such as reading, writing, and deleting files, as well as requesting storage permissions.
- `GeolocatorService`: Handles location-related operations, such as requesting location permissions and retrieving the device's current position.
- `HydrateBlocService`: Initializes the hydrated storage for BLoCs.
- `InterceptorService`: Provides interceptors for handling request and response logging, authentication, and error handling.
- `InAppService`: Handles in-app purchases and subscriptions.
- `LocalStoreService`: Provides a key-value storage for persisting data locally.
- `NetworkService`: Configures and creates Dio instances for making API requests.
- `NotificationService`: Handles push notifications and local notifications.

## Dependency Injection

The project leverages [GetIt](https://pub.dev/packages/get_it) and [Injectable](https://pub.dev/packages/injectable) for dependency management.

### Overview

* **lib/config/di/di.dart:** This file serves as the central hub for Dependency Injection. It imports and exports DI-related modules.
* **lib/config/di/app_di_config.dart:** Contains the `AppDI` mixin, which initializes and resets dependencies using the `GetIt.instance`. Call `AppDI.initializeDependencies()` during app startup to register all required services.
* **lib/config/di/network_di.dart:** Manages network-related dependencies, including configurations like the base URL, connection timeouts, authentication tokens, and interceptors. Preconfigured Dio instances for app and third-party API calls are provided here.
* **lib/config/di/route_observer_di.dart:** Registers global keys and custom navigator observers (e.g., `AppRouterObserver`, `HomeRouterObserver`, etc.) to handle route management consistently across the application.

### Usage

Initialize dependency injection by invoking:

```dart
await AppDI.initializeDependencies();
```

This ensures that all dependencies are set up before the app runs.

## Additional Resources

- **Flutter Documentation:** [Flutter Docs](https://docs.flutter.dev/)
- **Flutter Codelabs:** [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- **Recipes and Guides:** [Flutter Cookbook](https://docs.flutter.dev/cookbook)

## License

This project is licensed under the Apache License, Version 2.0.
You may obtain a copy of the License at:

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.

---

This documentation file provides a clear overview, explains the project structure, guides new users through the setup process, and outlines a contribution workflow. Adjust any sections according to your specific project needs (such as repository URLs, license details, or additional configuration settings).
