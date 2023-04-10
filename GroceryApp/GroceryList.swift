//
//  GroceryList.swift
//  GroceryApp
//
//  Created by Vlad Filip on 29.01.2023.
//

import Foundation

class GroceryList: Hashable {
  var title: String
  var groceryItems: [GroceryItem] = []
  
  init(title: String) {
    self.title = title
  }
  
  init?(_ dictionary: [String: Any]) {
    guard let title = dictionary["title"] as? String else {
      return nil
    }
    
    self.title = title
    let groceryItemsDictionary = dictionary["groceryItems"] as? [JSONDictionary]
    
    if let dictionary = groceryItemsDictionary {
      self.groceryItems = dictionary.compactMap(GroceryItem.init)
    }
  }
  
  func toDictionary() -> [String: Any] {
    return ["title": self.title, "groceryItems": self.groceryItems.map({
      return $0.toDictionary()
    })]
  }
  
  static func == (lhs: GroceryList, rhs: GroceryList) -> Bool {
    return (lhs.title == rhs.title && lhs.groceryItems == rhs.groceryItems)
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(title)
    hasher.combine(groceryItems)
  }
}
