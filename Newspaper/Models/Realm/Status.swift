/* DO NOT EDIT | Generated by gyro */

import RealmSwift
import Foundation

final class Status: Object {

  enum Attributes: String {
    case message = "message"
    case status = "status"
  }

  @objc dynamic var message: String?
  let status = RealmOptional<Bool>()

}
