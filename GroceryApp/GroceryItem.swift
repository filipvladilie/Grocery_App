//
//  GroceryItem.swift
//  GroceryApp
//
//  Created by Vlad Filip on 29.01.2023.
//

import Foundation

typealias JSONDictionary = [String: Any]

class GroceryItem: Hashable {
  var title: String
  
  init(title: String) {
    self.title = title
  }
  
  init?(dictionary: JSONDictionary) {
    guard let title = dictionary["title"] as? String else {
      return nil
    }
    self.title = title
  }
  
  func toDictionary() -> [String:Any] {
    return ["title":self.title]
  }
  
  static func == (lhs: GroceryItem, rhs: GroceryItem) -> Bool {
    return (lhs.title == rhs.title)
  }
  
  public func hash(into hasher: inout Hasher) {
    return hasher.combine(title)
  }
}
