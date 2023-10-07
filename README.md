# Pokémon iOS App

This is an iOS app that uses the Pokémon TCG API to search for and display information about pokemon cards that are created by various artists.

## Features

- Search for pokemon cards using a HP
- View card details, including the name, hp, image, and the artist
- Long press to a card to save it in favorites, or simply click star icon in the card detail page
- See you recently viewed cards (last 10)

## Requirements

- iOS 13.0 or later
- Xcode 14.0 or later
- Swift 5.0 or later

## Installation

1. Clone the repository.
2. Open the `Pokemon App.xcodeproj` file in Xcode.
3. Build and run the app in the Xcode simulator or on a physical device.

## About structure of the codebase

- **✅ Design Pattern:** This application is built using the Model-View-ViewModel-Coordinator (MVVM-C) architectural pattern. This architectural approach is chosen because it promotes the separation of concerns, making the codebase more modular, maintainable, and testable. All UI elements are created via storyboard and some of the components are added programatically using UIKit. There are reusable views and base classes to apply rule of DRY.

- **✅ Scalability**: The codebase is scalable meaning, you can add any features without breaking any parts of the application.

- **✅ Testability**: The code is testable. By being created with seperation of concepts and using dependency injection techniques, that makes the project easily testable. I've also added some example unit tests. Feel free to increase the number of tests.

## Configuration

No need to configure, it's plug-in-play and ready for production. 🚀

## Acknowledgments

This app uses the following third-party libraries:

- [Alamofire](https://github.com/Alamofire/Alamofire): This is the library that is used for making HTTP(s) requests to backend that is used to fetch information about cards and their details. This library makes the connecting to back-end services easy and fast.
- [AlamofireImage](https://github.com/Alamofire/AlamofireImage): This is the library that is used to fetch images from internet and apply to a `UIImageView`. This is used for displaying images of cards. 
- [RxSwift](https://github.com/ReactiveX/RxSwift): This library is used to create observer-subscriber pattern to apply base concept of MVVM. With the help of this library, the view controller or any subscriber can be notified of any changes made in the viewmodel.
- [Reachability](https://github.com/ashleymills/Reachability.swift): The app needs an active internet connection to function. A cache mechanism is not applied to the app as the main function of the app is searching cards. So while the application is booting, an active internet connection is checked.

## License

This project is licensed under the MIT License. 
