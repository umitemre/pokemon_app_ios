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

## About structure of the codebase

This application is built using the Model-View-ViewModel-Coordinator (MVVM-C) architectural pattern. This architectural approach is chosen because it promotes the separation of concerns, making the codebase more modular, maintainable, and testable.

All UI elements are created via storyboard and some of the components are added programatically using UIKit. There are reusable views and base classes to apply rule of DRY.

The codebase is scalable meaning, you can add any features without breaking any parts of the application. 

## Configuration

No need to configure, it's plug-in-play and ready for production.

## Acknowledgments

This app uses the following third-party libraries:

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [AlamofireImage](https://github.com/Alamofire/AlamofireImage)
- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [Reachability](https://github.com/ashleymills/Reachability.swift)

## License

This project is licensed under the MIT License. 
