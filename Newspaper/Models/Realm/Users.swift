/* DO NOT EDIT | Generated by gyro */

import RealmSwift
import Foundation

final class Users: Object, Decodable {
  private enum Keys: String, CodingKey {
    case status = "status"
    case users = "users"

    }

  let status = RealmOptional<Bool>()
  let users = List<User>()




  convenience required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    let status = try? container.decode(Bool?.self, forKey: .status)
    let users = try container.decode([User].self, forKey: .users)
    self.init(status: status, users: users)
  }

  convenience init(status: Bool?, users: [User]) {
    self.init()
    self.status.value = status
    self.users.append(objectsIn: users)

  }
}
