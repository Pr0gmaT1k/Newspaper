/* DO NOT EDIT | Generated by gyro */

import RealmSwift
import Foundation

final class Users: Object, Decodable {

  enum Attributes: String {
    case status = "status"
  }

  enum Relationships: String {
    case users = "users"
  }

  let status = RealmOptional<Bool>()
    var users = List<User>()

}
