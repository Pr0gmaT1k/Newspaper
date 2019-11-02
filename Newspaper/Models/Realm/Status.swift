/* DO NOT EDIT | Generated by gyro */

import RealmSwift
import Foundation

final class Status: Object, Decodable {
  private enum Keys: String, CodingKey {
  case message = "message"
  case status = "status"

  }


  @objc dynamic var message: String?
  let status = RealmOptional<Bool>()




  convenience required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    let message = try container.decode(String?.self, forKey: .message)
    let status = try container.decode(Bool?.self, forKey: .status)
    self.init(message: message, status: status)
  }

  convenience init(message: String?, status: Bool?) {
    self.init()
    self.message = message
    self.status.value = status

  }
}
