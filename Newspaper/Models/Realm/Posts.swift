/* DO NOT EDIT | Generated by gyro */

import RealmSwift
import Foundation

final class Posts: Object, Decodable {

  enum Attributes: String {
    case status = "status"
  }

  enum Relationships: String {
    case posts = "posts"
  }

  let status = RealmOptional<Bool>()
  var posts = List<Post>()

}
