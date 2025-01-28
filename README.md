# Project Documentation: Maya App

## Overview

This Flutter project is built with a **Domain-Driven Design (DDD)** architecture and focuses on providing a clean, maintainable, and scalable structure. The project also incorporates a **Maya Seeder**, a custom-built tool inspired by the Laravel Database Seeder, to generate initial data for the app. The seeder creates sample user data and populates a local SQLite database, ensuring you can easily test and run the app without manually adding users.

This documentation will guide you through the project setup, explain the architecture, tools used, and how to get started with the app.

---

## 1. **Domain-Driven Design (DDD) Architecture**

### What is Domain-Driven Design (DDD)?

Domain-Driven Design (DDD) is an approach to software development that emphasizes understanding the core business logic and structuring the application around it. In this project, we've used DDD principles to structure the app in a way that reflects the real-world business problem.

### Project Structure:

- **Domain Layer**: Contains the core business logic and entities that define the app’s functionality. This layer does not depend on any external frameworks or libraries.
  
- **Data Layer**: Handles the app's data management, including fetching and storing data (in this case, using SQLite). It communicates with the domain layer but is agnostic to the app's business logic.
  
- **Presentation Layer**: Responsible for the user interface and state management. In this app, state is managed using **Cubit**, a simpler variant of **Bloc**. The UI layers observe the state and update the view accordingly.

By following DDD, we ensure that our application is modular, testable, and adaptable to changes over time.

---

## 2. **Maya Seeder**

The **Maya Seeder** is a self-made **compiler** tool inspired by the Laravel Database Seeder. It is used to populate the local SQLite database with user data before running the app. This helps developers quickly generate mock data, eliminating the need to manually insert users for testing or development purposes.

### Steps to Use Maya Seeder

1. **Open your terminal**: Navigate to the project directory.

2. **Run Flutter Commands**:
   ```bash
   flutter pub clean && flutter pub get
   ```

3. **Activate Maya Seeder**:
   Use the following command to activate the Maya Seeder tool:
   ```bash
   dart pub global activate --source path .
   ```

4. **Close or Re-run Terminal**: After running the above command, restart your terminal to ensure that the changes take effect.

5. **Check if Maya Seeder Works**: In your terminal, type the word `"maya"` to check if the tool is installed correctly. It should display the following message:
   ```
   Building package executable...
   Built maya:maya.
   A tool for seeding a local SQLite database

   Usage: Database Seeder <command> [arguments]

   Global options:
   -h, --help    Print this usage information.

   Available commands:
     seed   A command to populate the SQLite database with sample user data

   Run "Database Seeder help <command>" for more information about a command
   ```

6. **Seed the Database**: Type the following command in your terminal to generate sample users:
   ```bash
   maya seed
   ```
   After running this, you should see a list of users populated in the terminal.

7. **Pick a User for Login**: Open the file `user_seeder.dart` and from the list of generated users, pick one to use as your login account.

8. **Run the App**:
   - You can now run the app by simply typing:
     ```bash
     flutter run
     ```
   - Alternatively, you can click the play button in **VSCode** to run the app.
   
   *Note*: Flavors were not set up in this app, so it will run with the default flavor (main).

9. **Voila!** You should now be able to use the app.

---

## 3. **Maya Seeder – Self-Made Compiler**

The **Maya Seeder** is a **self-made compiler**, specifically designed to simplify the process of seeding data into the local SQLite database. If you encounter any issues while running the Maya Seeder or need clarification on how it works, feel free to reach out. 

As it is a custom-built tool, you can directly contact me for any troubleshooting or support related to the seeder. I am happy to assist in resolving any issues you may face during its setup or execution.

---

## 4. **Tools Used in the Project**

The following tools and libraries are used in this project to handle various aspects like network requests, state management, dependency injection, and more:

### **Network Requests: Retrofit**

[**Retrofit**](https://pub.dev/packages/retrofit) is a type-safe HTTP client for Dart, which helps make network requests. It integrates with **Dio** and uses annotations to generate boilerplate code for network calls, making the process of fetching data from APIs cleaner and easier to manage.

### **State Management: Cubit (via Bloc)**

For state management, this project uses **Cubit**, a simpler and lighter version of the **Bloc** (Business Logic Component) pattern. Cubit helps manage the app’s state in a predictable way by emitting states that the UI observes.

The **App Cubit** is centralized and reusable, providing a parent for all other cubits in the app. It is set up to simplify dependency injection and allows for easy access to state across the entire application.

You can view the **App Cubit** and **App State** in the files `app_cubit.dart` and `app_state.dart`.

### **Dependency Injection: Get It**

[**Get It**](https://pub.dev/packages/get_it) is a simple service locator for Dart and Flutter. It is used to handle dependency injection in this app, making the code modular and reducing the need to pass dependencies manually across the app. By using **Get It**, we can easily inject services, repositories, and cubits into the various parts of the app.

### **Routing: Go Router**

[**Go Router**](https://pub.dev/packages/go_router) is used for handling routing in the app. It simplifies navigation between screens and supports nested routes, parameters, and guards. This makes it easy to manage complex navigation scenarios while keeping the code clean and readable.

### **Interceptors: Dio**

[**Dio**](https://pub.dev/packages/dio) is a powerful HTTP client for Dart, used in combination with **Retrofit** to make network requests. It supports interceptors, which are useful for adding custom logic to requests or responses, such as adding authentication tokens to headers, logging network activity, or handling errors globally.

### **Logging: CodenicLogger**

[**CodenicLogger**](https://pub.dev/packages/codenic_logger) is a logging library used for tracking app events. It provides an easy-to-use API for logging information, errors, and debugging data. The logger is configured to display relevant information in the console for better development debugging and troubleshooting.

---

## 5. **Custom Error Handlers**

To avoid repetitive error handling code, custom error handlers have been implemented in the app. These handlers are designed to catch and process errors across the app in a clean, centralized way. This minimizes boilerplate code and provides a more maintainable error management system.

---

## 6. **Project Setup Time**

The setup of the app, including the configuration of architecture, tools, dependencies, and the development of the core functionality, took roughly **6-7 hours** from scratch. This time included setting up the environment, implementing the necessary packages, and ensuring the proper flow for user seeding, network requests, and state management.

---

## Conclusion

This Flutter app leverages **Domain-Driven Design (DDD)**, along with a collection of powerful tools and patterns like **Cubit**, **Retrofit**, **Get It**, and more, to create a clean, maintainable, and scalable app. The **Maya Seeder** tool makes it easy to populate a local SQLite database with mock data, streamlining the testing and development process.

Follow the steps outlined in this documentation to get the app running locally and start using it with pre-populated sample data.

**Need Help with Maya Seeder?**  
If you run into any issues with **Maya Seeder** or have questions about using the tool, feel free to reach out to me directly. Since the Maya Seeder is a self-made compiler, I am happy to provide support and troubleshoot any problems you might encounter.



P.S.: Apologies for the lack of design polish and some existing bugs. I'll be addressing them in future updates when I have complete time. Thanks for your understanding! :P