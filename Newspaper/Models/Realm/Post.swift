/* DO NOT EDIT | Generated by gyro */

import RealmSwift
import Foundation

final class Post: Object {

  enum Attributes: String {
    case id = "id" /* Primary Key */
    case body = "body"
    case created_at = "created_at"
    case postDescription = "postDescription"
    case title = "title"
    case updated_at = "updated_at"
    case user_id = "user_id"
  }

  let id = RealmOptional<Int64>() /* Primary Key */
  @objc dynamic var body: String?
  @objc dynamic var created_at: String?
  @objc dynamic var postDescription: String?
  @objc dynamic var title: String?
  @objc dynamic var updated_at: String?
  let user_id = RealmOptional<Int64>()

  override static func primaryKey() -> String? {
    return "id"
  }

}
