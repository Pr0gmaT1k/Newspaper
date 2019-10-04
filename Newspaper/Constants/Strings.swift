// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// todos los derechos reservados Jumpittlabs 2019
  internal static let copyright = L10n.tr("Localizable", "Copyright")
  /// Cuenta creada
  internal static let cratedAccount = L10n.tr("Localizable", "CratedAccount")
  /// Correo electrónico
  internal static let email = L10n.tr("Localizable", "Email")
  /// RUT
  internal static let idNumber = L10n.tr("Localizable", "IDNumber")
  /// Nombre
  internal static let name = L10n.tr("Localizable", "Name")
  /// Contraseña
  internal static let password = L10n.tr("Localizable", "Password")
  /// Ingresar
  internal static let signIn = L10n.tr("Localizable", "SignIn")
  /// Crear cuenta
  internal static let signUp = L10n.tr("Localizable", "SignUp")
  /// Comenzar
  internal static let start = L10n.tr("Localizable", "Start")
  /// Apellido
  internal static let surname = L10n.tr("Localizable", "Surname")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
