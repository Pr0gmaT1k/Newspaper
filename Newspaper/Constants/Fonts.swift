// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
  internal typealias Font = NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
  internal typealias Font = UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum Prompt {
    internal static let black = FontConvertible(name: "Prompt-Black", family: "Prompt", path: "Prompt-Black.ttf")
    internal static let blackItalic = FontConvertible(name: "Prompt-BlackItalic", family: "Prompt", path: "Prompt-BlackItalic.ttf")
    internal static let bold = FontConvertible(name: "Prompt-Bold", family: "Prompt", path: "Prompt-Bold.ttf")
    internal static let boldItalic = FontConvertible(name: "Prompt-BoldItalic", family: "Prompt", path: "Prompt-BoldItalic.ttf")
    internal static let extraBold = FontConvertible(name: "Prompt-ExtraBold", family: "Prompt", path: "Prompt-ExtraBold.ttf")
    internal static let extraBoldItalic = FontConvertible(name: "Prompt-ExtraBoldItalic", family: "Prompt", path: "Prompt-ExtraBoldItalic.ttf")
    internal static let extraLight = FontConvertible(name: "Prompt-ExtraLight", family: "Prompt", path: "Prompt-ExtraLight.ttf")
    internal static let extraLightItalic = FontConvertible(name: "Prompt-ExtraLightItalic", family: "Prompt", path: "Prompt-ExtraLightItalic.ttf")
    internal static let italic = FontConvertible(name: "Prompt-Italic", family: "Prompt", path: "Prompt-Italic.ttf")
    internal static let light = FontConvertible(name: "Prompt-Light", family: "Prompt", path: "Prompt-Light.ttf")
    internal static let lightItalic = FontConvertible(name: "Prompt-LightItalic", family: "Prompt", path: "Prompt-LightItalic.ttf")
    internal static let medium = FontConvertible(name: "Prompt-Medium", family: "Prompt", path: "Prompt-Medium.ttf")
    internal static let mediumItalic = FontConvertible(name: "Prompt-MediumItalic", family: "Prompt", path: "Prompt-MediumItalic.ttf")
    internal static let regular = FontConvertible(name: "Prompt-Regular", family: "Prompt", path: "Prompt-Regular.ttf")
    internal static let semiBold = FontConvertible(name: "Prompt-SemiBold", family: "Prompt", path: "Prompt-SemiBold.ttf")
    internal static let semiBoldItalic = FontConvertible(name: "Prompt-SemiBoldItalic", family: "Prompt", path: "Prompt-SemiBoldItalic.ttf")
    internal static let thin = FontConvertible(name: "Prompt-Thin", family: "Prompt", path: "Prompt-Thin.ttf")
    internal static let thinItalic = FontConvertible(name: "Prompt-ThinItalic", family: "Prompt", path: "Prompt-ThinItalic.ttf")
    internal static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraBold, extraBoldItalic, extraLight, extraLightItalic, italic, light, lightItalic, medium, mediumItalic, regular, semiBold, semiBoldItalic, thin, thinItalic]
  }
  internal static let allCustomFonts: [FontConvertible] = [Prompt.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  internal func font(size: CGFloat) -> Font! {
    return Font(font: self, size: size)
  }

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    let bundle = Bundle(for: BundleToken.self)
    return bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension Font {
  convenience init!(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

private final class BundleToken {}
