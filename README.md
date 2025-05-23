# project_promise

"project_promise" is a Flutter application designed to streamline and digitize the operations of granite businesses. It focuses on modernizing order taking, automating billing processes, and simplifying tax evaluations. This application aims to help granite businesses improve efficiency, reduce paperwork, and gain better control over their financial data.

```
Please note: This project is currently under active development and may not yet be fully stable or feature-complete.
```

## Technologies Used

This project leverages the following technologies:

-   **Flutter**: For building a cross-platform mobile application from a single codebase.
-   **Dart**: The programming language used for Flutter development.
-   **Appwrite**: Backend as a Service (BaaS) for managing database, authentication, and other backend functionalities.

## Getting Started

Follow these steps to set up and run the project:

1.  **Prerequisites**: Make sure you have the Flutter SDK installed and configured on your system. You can verify your installation by running `flutter doctor`.
2.  **Clone the Repository**:
    ```bash
    git clone <YOUR_REPOSITORY_URL> 
    ```
    Replace `<YOUR_REPOSITORY_URL>` with the actual URL of this repository.
3.  **Navigate to Project Directory**:
    ```bash
    cd project_promise
    ```
4.  **Install Dependencies**: Run the following command in the project root to fetch all required packages:
    ```bash
    flutter pub get
    ```
5.  **Run the Application**: Connect a device or start an emulator, then execute:
    ```bash
    flutter run
    ```

### Troubleshooting Common Setup Issues

If you encounter problems during setup, here are some common issues and their solutions:

*   **Flutter SDK not found**:
    *   **Solution**: Ensure the Flutter SDK is installed correctly and that its `bin` directory is added to your system's PATH environment variable. Verify by running `flutter doctor`.
*   **Dependency Conflicts**:
    *   **Solution**: Try running `flutter pub upgrade` to update dependencies to their latest compatible versions. If issues persist, inspect `pubspec.yaml` for version constraint conflicts and manually adjust them if necessary.
*   **Platform-Specific Issues (Android/iOS)**:
    *   **Solution**: Run `flutter doctor -v` for a detailed diagnostic report. This can help identify issues related to the Android toolchain, Xcode setup (for iOS), or connected devices. Ensure all platform-specific requirements mentioned by `flutter doctor` are met. For Android, check `android/build.gradle` and `android/app/build.gradle` files for configurations. For iOS, ensure CocoaPods are installed and updated (`pod install`, `pod repo update` from the `ios` directory).
*   **Appwrite Configuration**:
    *   **Solution**: This project uses Appwrite for its backend. Ensure you have an Appwrite instance running and that the endpoint and project ID in `lib/groups/constants.dart` are correctly configured to point to your Appwrite project. Refer to the "Database API Configuration (Appwrite)" section for more details on Appwrite setup.

## Features

This project includes the following features to help granite businesses manage their operations effectively:

-   **Digital Order Taking**:
    -   Easily capture customer orders with all necessary details, reducing manual errors and paperwork.
    -   Orders are securely saved to the cloud, ensuring data integrity and accessibility.
    -   ![Order Entry Screenshot](assets/1.png)

-   **Automated PDF Billing**:
    -   Generate professional PDF invoices with a single click, pre-filled with order details, customer information, and your business branding.
    -   Simplifies the billing process and provides customers with clear and accurate invoices.
    -   ![Billing Screenshot](assets/4.png)

-   **Anytime, Anywhere Data Access**:
    -   Access your order history, customer database, and billing records from any device (mobile, tablet, desktop) at any time.
    -   Cloud synchronization ensures your data is always up-to-date across all platforms.
    -   ![Data Access Screenshot](assets/2.png)

-   **Tax Evaluation Support**:
    -   Streamline your tax evaluation process by maintaining organized digital records of all sales and transactions.
    -   Easily filter and export data needed for tax reporting, reducing manual effort and potential for errors.


## Database API Configuration (Appwrite)

For security and privacy, specific API keys, endpoint details, and other sensitive credentials for the original development database have been removed from this project.

This project uses **Appwrite** as its Backend as a Service (BaaS) for functionalities like database storage, user authentication, and more. To connect the application to your own Appwrite instance, you will need to configure the following details in the `lib/groups/constants.dart` file:

1.  **Endpoint**: Set `APPWRITE_ENDPOINT` to the API endpoint of your Appwrite server.
    *   Example: `static const String APPWRITE_ENDPOINT = 'https://cloud.appwrite.io/v1';` or your self-hosted endpoint.
2.  **Project ID**: Set `APPWRITE_PROJECT_ID` to your Appwrite project's ID.
    *   Example: `static const String APPWRITE_PROJECT_ID = 'YOUR_PROJECT_ID';`
3.  **Database ID**: Set `APPWRITE_DATABASE_ID` to the ID of the database you've created within your Appwrite project for this application.
    *   Example: `static const String APPWRITE_DATABASE_ID = 'YOUR_DATABASE_ID';`
4.  **Collection IDs**: You will need to define constants for each collection you use in your Appwrite database. This project typically requires collections for:
    *   Orders: e.g., `static const String COLLECTION_ORDERS_ID = 'YOUR_ORDERS_COLLECTION_ID';`
    *   Customers: e.g., `static const String COLLECTION_CUSTOMERS_ID = 'YOUR_CUSTOMERS_COLLECTION_ID';`
    *   Products/Services: e.g., `static const String COLLECTION_PRODUCTS_ID = 'YOUR_PRODUCTS_COLLECTION_ID';`
    *   (Add any other collections your specific setup uses)

**Example structure in `lib/groups/constants.dart`:**
```dart
// lib/groups/constants.dart

class AppwriteConstants {
  static const String APPWRITE_ENDPOINT = 'YOUR_APPWRITE_ENDPOINT'; // e.g., 'https://cloud.appwrite.io/v1'
  static const String APPWRITE_PROJECT_ID = 'YOUR_PROJECT_ID';
  static const String APPWRITE_DATABASE_ID = 'YOUR_DATABASE_ID'; // e.g., 'granite_business_db' or your preferred DB name

  // Collection IDs
  static const String COLLECTION_ORDERS_ID = 'YOUR_ORDERS_COLLECTION_ID'; // e.g., 'orders'
  static const String COLLECTION_CUSTOMERS_ID = 'YOUR_CUSTOMERS_COLLECTION_ID'; // e.g., 'customers'
  // Add other collection IDs as needed
}
```
Ensure your Appwrite project has these databases and collections created with appropriate attributes and permissions for the application to function correctly.

## Owner Information (for PDF Bills)

Specific business owner details (name, mobile number, address, etc.) have been removed from the `lib/groups/owner_info.dart` file for privacy.

To ensure generated PDF invoices and other documents correctly display your business information, you must populate the `OwnerInfo` class within this file.

Open `lib/groups/owner_info.dart` and update the placeholder values with your actual business details.

**Class structure in `lib/groups/owner_info.dart`:**
```dart
// lib/groups/owner_info.dart

class OwnerInfo {
  final String name = "YOUR BUSINESS NAME";
  final String mobileNumber = "YOUR BUSINESS MOBILE NUMBER";
  final String address = "YOUR BUSINESS ADDRESS";
  final String gstin = "YOUR GSTIN (if applicable)"; // Example of an additional relevant field
  // Add any other details you want to include in your bills
}
```
Make sure to replace the placeholder strings (e.g., `"YOUR BUSINESS NAME"`) with your actual information. This data will be used globally throughout the app wherever owner information is required, especially in PDF generation.

## Contributing to Project Promise

We are thrilled you're interested in contributing to Project Promise! Your help is valuable in making this application better for everyone. Whether you're fixing a bug, proposing a new feature, or improving documentation, your contributions are welcome.

To ensure a smooth collaboration, please review the following guidelines.

### Reporting Bugs

If you encounter a bug, please help us by reporting it. Good bug reports are essential for us to understand and fix the issue quickly.

1.  **Check Existing Issues**: Before submitting a new bug report, please search the existing issues on our GitHub repository to see if the bug has already been reported. If it has, you can add any additional information you have to the existing issue.
2.  **Provide Detailed Information**: When submitting a bug report, please include the following:
    *   A clear and descriptive title.
    *   Steps to reproduce the bug: Be as specific as possible.
    *   What you expected to happen.
    *   What actually happened, including any error messages.
    *   Your environment details: Flutter version, operating system, device information (if applicable).
3.  **Submit the Report**: Create a new issue on the GitHub repository, labeling it as a "bug".

### Suggesting Enhancements

We welcome suggestions for new features or improvements to existing ones!

1.  **Check Existing Suggestions**: Before submitting a new suggestion, please look through the existing issues (you can filter by "enhancement" or "feature request" labels) to see if someone else has already suggested something similar.
2.  **Explain Your Idea Clearly**:
    *   Provide a clear and descriptive title for your suggestion.
    *   Explain the use case: Why would this enhancement be useful to users?
    *   Provide as many details as possible about how the feature might work or how an existing one could be improved. Mockups or examples are welcome.
3.  **Submit Your Suggestion**: Create a new issue on the GitHub repository, labeling it as an "enhancement" or "feature request".

### Making Code Contributions (Pull Requests)

If you'd like to contribute code to fix a bug or implement an enhancement:

1.  **Fork the Repository**: Create your own fork of the `project_promise` repository.
2.  **Create a New Branch**: For each new feature or bug fix, create a descriptively named branch from the `main` (or `develop`, if applicable) branch.
    *   Example: `git checkout -b feature/new-billing-option` or `git checkout -b fix/order-entry-crash`
3.  **Make Your Changes**: Write your code, ensuring it follows the project's coding style and includes relevant tests if applicable.
4.  **Commit Your Changes**: Make clear, concise commit messages.
5.  **Push to Your Fork**: Push your changes to your forked repository.
    *   Example: `git push origin feature/new-billing-option`
6.  **Submit a Pull Request (PR)**: Open a pull request from your branch in your fork to the `main` (or `develop`) branch of the original `project_promise` repository.
    *   In your PR description, clearly explain the changes you've made and link to any relevant issues (e.g., "Closes #123" or "Fixes #456").
7.  **Address Feedback**: We will review your PR and may suggest changes. Please be open to feedback and make any necessary adjustments.

We appreciate your effort and look forward to your contributions!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
