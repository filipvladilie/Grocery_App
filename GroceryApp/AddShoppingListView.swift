//
//  AddShoppingListView.swift
//  GroceryApp
//
//  Created by Vlad Filip on 23.01.2023.
//

import SwiftUI
import Firebase

struct AddShoppingListView: View {
  @Environment(\.dismiss) var dismiss
  @Binding var shoppingList: [GroceryList]
  @State private var shoppingListElement: String = ""
  var saveGrocery: (String) -> Void
  private var rootRef: DatabaseReference
  
  init(shoppingList: Binding<[GroceryList]>, saveGrocery: @escaping (String) -> Void) {
    self._shoppingList = shoppingList
    self.rootRef = Database.database().reference()
    self.saveGrocery = saveGrocery
  }
  
  var body: some View {
    VStack {
      HStack {
        Button(action: {
          dismiss()
        }, label: {
          Text("Cancel")
        })
        .buttonStyle(.bordered)
        .padding(.leading, 10)
        Spacer()
        Text("Add ShoppingList")
          .font(.title2)
          .fontWeight(.bold)
        Spacer()
        Button(action: {
          shoppingList.append(GroceryList(title: shoppingListElement))
          saveGrocery(shoppingListElement)
          dismiss()
        }, label: {
          Text("Save")
        })
        .buttonStyle(.bordered)
        .padding(.trailing, 10)
      }
      .frame(maxWidth: .infinity)
      .background(.green)
      .foregroundColor(.white)
      
      TextField("", text: $shoppingListElement)
        .frame(width: 300, height: 30)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(.blue, lineWidth: 1)
        )
      
      Spacer()
    }
  }
}

struct AddGroceryItemView: View {
  @Environment(\.dismiss) var dismiss
  @Binding var shoppingGroceryItem: GroceryList
  @State private var shoppingListElement: String = ""
  private var rootRef: DatabaseReference
  var saveGrocery: (String) -> Void
  
  init(shoppingList: Binding<GroceryList>,saveGrocery: @escaping (String) -> Void) {
    self._shoppingGroceryItem = shoppingList
    self.rootRef = Database.database().reference()
    self.saveGrocery = saveGrocery
  }
  
  var body: some View {
    VStack {
      HStack {
        Button(action: {
          dismiss()
        }, label: {
          Text("Cancel")
        })
        .buttonStyle(.bordered)
        .padding(.leading, 10)
        Spacer()
        Text(shoppingGroceryItem.title)
          .font(.title2)
          .fontWeight(.bold)
        Spacer()
        Button(action: {
          self.shoppingGroceryItem.groceryItems.append(GroceryItem(title: shoppingListElement))
          saveGrocery(shoppingGroceryItem.title)
          dismiss()
        }, label: {
          Text("Save")
        })
        .buttonStyle(.bordered)
        .padding(.trailing, 10)
      }
      .frame(maxWidth: .infinity)
      .background(.green)
      .foregroundColor(.white)
      
      TextField("", text: $shoppingListElement)
        .frame(width: 300, height: 30)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(.blue, lineWidth: 1)
        )
      
      Spacer()
    }
  }
  
}
