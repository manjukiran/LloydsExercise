# Lloyds-Exercise

Lloyds-Exercise is a modern iOS application built using the MVVM-C (Model-View-ViewModel-Coordinator) architecture to provide a scalable and maintainable structure for the codebase, including navigation. This README file provides an overview of the app's architecture, networking setup, coordination, and testing practices.

## Table of Contents
- [Architecture Overview](#architecture-overview)
- [Network Requests](#network-requests)
- [Mocked Network Requests](#mocked-network-requests)
- [Coordinator and Navigation](#coordinator-and-navigation)
- [Localization](#localization)
- [Unit Tests](#unit-tests)
- [UI Tests](#ui-tests)

## Architecture Overview

The app follows the MVVM-C architecture, an extension of the MVVM pattern that adds a Coordinator layer for handling navigation and flow control. This structure separates responsibilities as follows:

- **Model:** Represents the app's data and business logic.
- **View:** Displays the UI elements and receives user interactions.
- **ViewModel:** Mediates between the Model and View, handling UI logic, network calls and data presentation.
- **Coordinator:** Manages navigation and app flow, making it more centralized and maintainable.

## Network Requests

The app utilizes injectable classes to manage network requests. There are two separate mockable mechanisms shown. Firstly via the URLProtocol registration method and secondly via the stubbed URL session method. This approach enhances testability and flexibility by enabling easy swapping of networking implementations. The networking layer is designed to handle API calls efficiently and robustly.

To perform a network request:

1. Inject an instance of the network service class , `URLDataFetching` into your ViewModel.
2. Utilize the service's methods to send requests and receive responses asynchronously.

## Mocked Network Requests

The app supports mocked network requests for testing purposes.

### Unit Tests

For unit tests, the mocking is achieved by creating mock versions of the network service classes that simulate API responses without making actual network calls. This ensures isolated and repeatable tests.

To use mocked network requests:

1. Create a mock network service class that conforms to the same protocol as the actual service i.e `NetworkMockUtility` class.
2. Override the methods to return predefined responses or errors.
3. Inject the mock service into your ViewModel during testing.

### UI Tests

For UI tests, the mocking is achieved by registering a separate class that acts as a data provider by adhering to the `URLProtocol` protocol. We register this in the app by checking for a `--uiTesting` flag and swapping out the default URL session with the custom session that uses the `URLProtocol` adherent custom class.

To use mocked network requests:

1. Pass the `--uiTesting` flag in the app launch argument.
2. Add the url and the mock payload to the app launch environment variable in the `[url: payload]` key/value format.
3. The app should be able to swap the 

#### UITestingSupport package
I have created a separate UITestingSupport swift package to help with the mocking of the network request instead of keeping within the app.


## Coordinator and Navigation

The MVVM-C architecture introduces the Coordinator layer to manage navigation within the app. Coordinators handle transitions between different view controllers, making navigation logic more organized and testable.

To implement navigation using the Coordinator pattern:

1. Create a coordinator for each distinct flow in your app.
2. Inject a coordinator as the flow delegate into your ViewModel
3. Use the view model's interaction functions to trigger navigation to other screens or modules.

## Localization

The app supports both English and French languages.

## Unit Tests

Unit tests remain crucial for maintaining code quality and preventing regressions, just like in the MVVM pattern. The app includes unit tests that cover various components, including Models, ViewModels, and utility functions.

To run unit tests:

1. Open the Xcode project.
2. Select the "Product" menu, then choose "Test" or use the shortcut (Cmd + U).

Example unit tests are located in the `Lloyds-ExerciseTests` target and organized within the project's directory structure.

## UI Tests

UI tests still validate the app's behavior from the user's perspective. These tests interact with the app's UI elements to ensure that the app functions as expected.

To run UI tests:

1. Open the Xcode project.
2. Select the "Product" menu, then choose "Test" or use the shortcut (Cmd + U) while the appropriate scheme is selected.

Example UI tests are located in the `Lloyds-ExerciseUITests` target and organized within the project's directory structure.

## Conclusion

Lloyds-Exercise app follows the MVVM-C architecture, incorporating injectable classes, network requests, mocked network requests, coordination for navigation, unit tests, and UI tests. This structure ensures a maintainable, testable, and well-structured codebase, contributing to the overall quality of the app.
