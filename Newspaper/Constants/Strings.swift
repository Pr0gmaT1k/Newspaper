// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Auth {
    /// todos los derechos reservados Jumpittlabs 2019
    internal static let copyright = L10n.tr("Localizable", "auth.copyright")
    /// Ingresar
    internal static let signIn = L10n.tr("Localizable", "auth.signIn")
    /// Crear cuenta
    internal static let signUp = L10n.tr("Localizable", "auth.signUp")
  }

  internal enum Create {
    /// Detalles
    internal static let addBody = L10n.tr("Localizable", "create.addBody")
    /// Descripción
    internal static let addDescription = L10n.tr("Localizable", "create.addDescription")
    /// Agrega una foto
    internal static let addPhoto = L10n.tr("Localizable", "create.addPhoto")
    /// Crear post
    internal static let addPostButton = L10n.tr("Localizable", "create.addPostButton")
    /// Título
    internal static let addTitle = L10n.tr("Localizable", "create.addTitle")
    /// %u / 1000
    internal static func countBody(_ p1: Int) -> String {
      return L10n.tr("Localizable", "create.countBody", p1)
    }
    /// %u / 100
    internal static func countDescription(_ p1: Int) -> String {
      return L10n.tr("Localizable", "create.countDescription", p1)
    }
    /// Crear post
    internal static let title = L10n.tr("Localizable", "create.title")
  }

  internal enum Details {
    /// Post
    internal static let title = L10n.tr("Localizable", "details.title")
  }

  internal enum Feed {
    /// Agregar
    internal static let addPost = L10n.tr("Localizable", "feed.addPost")
    internal enum Header {
      /// Mi feed
      internal static let title = L10n.tr("Localizable", "feed.header.title")
    }
  }

  internal enum Profile {
    /// Cerrar sesión
    internal static let closeSession = L10n.tr("Localizable", "profile.closeSession")
    /// RUT
    internal static let dni = L10n.tr("Localizable", "profile.dni")
    /// Correo electrónico
    internal static let email = L10n.tr("Localizable", "profile.email")
    /// Nombre y apellido
    internal static let names = L10n.tr("Localizable", "profile.names")
    /// Perfil
    internal static let profile = L10n.tr("Localizable", "profile.profile")
  }

  internal enum Registered {
    /// Cuenta creada
    internal static let accountCreated = L10n.tr("Localizable", "registered.accountCreated")
    /// Comenzar
    internal static let start = L10n.tr("Localizable", "registered.start")
  }

  internal enum Signin {
    /// Correo electrónico
    internal static let email = L10n.tr("Localizable", "signin.email")
    /// Contraseña
    internal static let password = L10n.tr("Localizable", "signin.password")
    /// Ingresar
    internal static let signIn = L10n.tr("Localizable", "signin.signIn")
  }

  internal enum Signup {
    /// Correo electrónico
    internal static let email = L10n.tr("Localizable", "signup.email")
    /// RUT
    internal static let idNumber = L10n.tr("Localizable", "signup.IDNumber")
    /// Nombre
    internal static let name = L10n.tr("Localizable", "signup.name")
    /// Contraseña
    internal static let password = L10n.tr("Localizable", "signup.password")
    /// Crear cuenta
    internal static let signUp = L10n.tr("Localizable", "signup.signUp")
    /// Apellido
    internal static let surname = L10n.tr("Localizable", "signup.surname")
  }

  internal enum Users {
    internal enum Cell {
      /// Correo electrónico
      internal static let email = L10n.tr("Localizable", "users.cell.email")
      /// Miembro desde %@
      internal static func memberSince(_ p1: String) -> String {
        return L10n.tr("Localizable", "users.cell.memberSince", p1)
      }
      /// Nombre y apellido
      internal static let names = L10n.tr("Localizable", "users.cell.names")
    }
  }
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
