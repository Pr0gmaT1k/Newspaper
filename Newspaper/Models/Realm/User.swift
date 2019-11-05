/* DO NOT EDIT | Generated by gyro */

import RealmSwift
import Foundation

final class User: Object, Decodable {
  private enum Keys: String, CodingKey {
    case id = "id"/* Primary Key */
    case created_at = "created_at"
    case dni = "dni"
    case email = "email"
    case lastname = "lastname"
    case name = "name"
    case password_digest = "password_digest"
    case updated_at = "updated_at"

    }

  @objc dynamic var id: Int64 = 0 /* Primary Key */
  @objc dynamic var created_at: String?
  @objc dynamic var dni: String?
  @objc dynamic var email: String?
  @objc dynamic var lastname: String?
  @objc dynamic var name: String?
  @objc dynamic var password_digest: String?
  @objc dynamic var updated_at: String?

  override static func primaryKey() -> String? {
    return "id"
  }




  convenience required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    let id = try container.decode(Int64.self, forKey: .id) /* Primary Key */
    let created_at = try? container.decode(String?.self, forKey: .created_at)
    let dni = try? container.decode(String?.self, forKey: .dni)
    let email = try? container.decode(String?.self, forKey: .email)
    let lastname = try? container.decode(String?.self, forKey: .lastname)
    let name = try? container.decode(String?.self, forKey: .name)
    let password_digest = try? container.decode(String?.self, forKey: .password_digest)
    let updated_at = try? container.decode(String?.self, forKey: .updated_at)
    self.init(id: id, created_at: created_at, dni: dni, email: email, lastname: lastname, name: name, password_digest: password_digest, updated_at: updated_at)
  }

  convenience init(id: Int64, created_at: String?, dni: String?, email: String?, lastname: String?, name: String?, password_digest: String?, updated_at: String?) {
    self.init()
    self.id = id
    self.created_at = created_at
    self.dni = dni
    self.email = email
    self.lastname = lastname
    self.name = name
    self.password_digest = password_digest
    self.updated_at = updated_at

  }
}
