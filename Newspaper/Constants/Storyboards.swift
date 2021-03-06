// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum Auth: StoryboardType {
    internal static let storyboardName = "Auth"

    internal static let authVC = SceneType<Newspaper.AuthVC>(storyboard: Auth.self, identifier: "AuthVC")

    internal static let registeredVC = SceneType<Newspaper.RegisteredVC>(storyboard: Auth.self, identifier: "RegisteredVC")

    internal static let signInVC = SceneType<Newspaper.SignInVC>(storyboard: Auth.self, identifier: "SignInVC")

    internal static let signUpVC = SceneType<Newspaper.SignUpVC>(storyboard: Auth.self, identifier: "SignUpVC")
  }
  internal enum Feed: StoryboardType {
    internal static let storyboardName = "Feed"

    internal static let createPostVC = SceneType<Newspaper.CreatePostVC>(storyboard: Feed.self, identifier: "CreatePostVC")

    internal static let detailsPostVC = SceneType<Newspaper.DetailsPostVC>(storyboard: Feed.self, identifier: "DetailsPostVC")

    internal static let feedVC = SceneType<Newspaper.FeedVC>(storyboard: Feed.self, identifier: "FeedVC")

    internal static let profileVC = SceneType<Newspaper.ProfileVC>(storyboard: Feed.self, identifier: "ProfileVC")

    internal static let tabBarVC = SceneType<Newspaper.TabBarVC>(storyboard: Feed.self, identifier: "TabBarVC")

    internal static let usersVC = SceneType<Newspaper.UsersVC>(storyboard: Feed.self, identifier: "UsersVC")
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

private final class BundleToken {}
