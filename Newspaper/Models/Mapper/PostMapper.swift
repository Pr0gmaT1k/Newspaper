/* DO NOT EDIT | Generated by gyro */

import ObjectMapper

extension Post: Mappable {

  // MARK: Initializers
  convenience init?(map: Map) {
    self.init()
  }

  // MARK: Mappable
  func mapping(map: Map) {
    // MARK: Attributes
    self.id.value <- map["id"]
    self.body <- map["body"]
    self.created_at <- map["created_at"]
    self.postDescription <- map["description"]
    self.title <- map["title"]
    self.updated_at <- map["updated_at"]
    self.user_id.value <- map["user_id"]
  }
}