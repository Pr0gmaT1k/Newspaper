Newspaper iOS
===============
[![Language: Swift 5](https://img.shields.io/badge/Swift-5-red.svg?style=flat-square)](https://swift.org)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/NetworkStack.svg?style=flat-square)](https://cocoapods.org/pods/NetworkStack)
[![CocoaPods](https://img.shields.io/badge/pod-v1.7.5-blue)]()

An incredible technical test.

Building the code
-----------------
1. Install the latest [Xcode developer tools](https://developer.apple.com/xcode/downloads/) from Apple.
1. Install [Pods](https://cocoapods.org/)
    ```shell
    sudo gem install cocoapods
    ```
1. Clone the repository:
    ```shell
    git clone https://github.com/Pr0gmaT1k/Newspaper
    ```
1. Pull in the project dependencies:
    ```shell
    cd Newspaper
    pod install
    ```
1. Open `Newspaper.xcworkspace` in Xcode.


Tools:
-----------------
The `Realm` object and `ObjectMapper` decoder are generated from `Tools/DataModel.xcdatamodel` with Gyro.
Gyro is a tool to generate Realm model classes, for both Android (Java & Kotlin) and iOS/macOS (Swift), from an `.xcdatamodel` file.
1. Install [Gyro](https://github.com/NijiDigital/gyro):
    ```shell
    gem install gyro
    ```    

1. Modify the data model in `Tools/DataModel.xcdatamodel` and then regenerate with gyro:
    ```shell
    ./gyro.sh
    ```

## Networking:
* **[NetworkStack](https://github.com/NijiDigital/NetworkStack):** NetworkStack is an networking library wrapping Alamofire, Rx, OAuth and replay mechanism in a reactive abstract API.
* **[RxSwift](https://github.com/ReactiveX/RxSwift):** Rx is a generic abstraction of computation expressed through Observable<Element> interface. This is a Swift version of Rx.
* **[JWTDecode](https://github.com/auth0/JWTDecode.swift):** This library will help you check JWT payload

## Model & Decode:
* **[RealmSwift](https://github.com/realm/realm-cocoa):** Realm is a mobile database that runs directly inside phones, tablets or wearables. This repository holds the source code for the iOS, macOS, tvOS & watchOS versions of Realm Swift & Realm Objective-C.
* **[ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper):** ObjectMapper is a framework written in Swift that makes it easy for you to convert your model objects (classes and structs) to and from JSON.

## UI:
* **[Reusable](https://github.com/AliSoftware/Reusable):** A Swift mixin to use UITableViewCells, UICollectionViewCells and UIViewControllers in a type-safe way, without the need to manipulate their String-typed reuseIdentifiers.

## Coding Tools:
* **[SwiftLint](https://github.com/realm/SwiftLint):** A tool to enforce Swift style and conventions, loosely based on GitHub's Swift Style Guide.
* **[SwiftGen](https://github.com/SwiftGen/SwiftGen):** SwiftGen is a tool to auto-generate Swift code for resources of your projects, to make them type-safe to use.

