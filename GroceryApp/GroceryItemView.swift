//
//  GroceryItemView.swift
//  GroceryApp
//
//  Created by Vlad Filip on 24.01.2023.
//

import SwiftUI
import Firebase

struct GroceryItemView: View {
  @State private var showShoppingList: Bool = false
  @Binding private var shoppingList: GroceryList
  private var rootRef: DatabaseReference
  var saveGrocery: (String) -> Void
  
  init(groceryItem: Binding<GroceryList>, saveGrocery: @escaping (String) -> Void) {
    self._shoppingList = groceryItem
    self.rootRef = Database.database().reference()
    self.saveGrocery = saveGrocery
  }

    var body: some View {
      VStack {
        HStack {
          Spacer()
          Text(shoppingList.title)
            .padding(.leading, 10)
          Spacer()
          Button(action: {
            showShoppingList = true
          }, label: {
            Image(systemName: "plus")
            
          })
          .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity)
        .background(.green)
        .font(.title)
        .fontWeight(.bold)
        .foregroundColor(.white)
        Spacer()
        
        List(shoppingList.groceryItems, id: \.self) { element in
          Text(element.title)
        }
      }
      .sheet(isPresented: $showShoppingList, content: {
        AddGroceryItemView(shoppingList: $shoppingList, saveGrocery: self.saveGrocery)
      })
    }
}
