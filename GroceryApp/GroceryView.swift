//
//  GroceryView.swift
//  GroceryApp
//
//  Created by Vlad Filip on 23.01.2023.
//

import SwiftUI
import Firebase

struct GroceryView: View {
  
  @State private var showShoppingList: Bool = false
  @State private var shoppingList: [GroceryList] = []
  @State private var shoppingElement: String = ""
  @State private var e: GroceryList = .init(title: "")
  @State private var isItemActive = false
  
  let user: User? = Auth.auth().currentUser
  
  private var rootRef: DatabaseReference
  
  init() {
    self.rootRef = Database.database().reference()
    print("USER EMAIL \(user?.emailWithoutSpecialCharacters)")
  }
  
  var body: some View {
    VStack {
      HStack {
        Text("Grocery")
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
      
      List(self.shoppingList, id: \.self) { element in
        Text(element.title)
          .swipeActions(allowsFullSwipe: false) {
            Button(action: {
              removeRef(element.title)
            }, label: {
              Text("Delete")
            })
            .tint(.red)
          }
          .onTapGesture {
            e = element
            isItemActive = true
          }
      }
      
      NavigationLink("", destination: GroceryItemView(groceryItem: $e, saveGrocery: self.saveGrocery), isActive: $isItemActive)
      
    }
    .onAppear {
      populateShoppingList()
    }
    .sheet(isPresented: $showShoppingList, content: {
      AddShoppingListView(shoppingList: $shoppingList, saveGrocery: self.saveGrocery)
    })
    .navigationBarBackButtonHidden(true)
  }
  
  func saveGrocery(title: String) {
    if let groceryindex = self.shoppingList.firstIndex(where: { $0.title == title }){
      if let user = user {
        let userRef = self.rootRef.child(user.emailWithoutSpecialCharacters)
        let shoppingListRef = userRef.child(title)
        shoppingListRef.setValue(shoppingList[groceryindex].toDictionary())
      }
     
    }
  }
  
  func removeRef(_ title: String) {
    if let index = self.shoppingList.firstIndex(where: { $0.title == title }) {
      self.shoppingList.remove(at: index)
      let childNode = self.rootRef.child(title)
      childNode.removeValue()
    }
  
  }
  
  private func populateShoppingList() {
    if let user = user {
      var tempArray:[GroceryList] = []
    
      self.rootRef.child(user.emailWithoutSpecialCharacters).observe(.value) { snapshot  in
        self.shoppingList.removeAll()
        for child in snapshot.children {
          let snap = child as! DataSnapshot
          let dict = snap.value as! [String: Any]
          if let result = GroceryList(dict) {
            print("RESULT: \(result)")
            tempArray.append(result)
          }
        }
        let transition = Set(tempArray)
        shoppingList = Array(transition)
      }
    }
  }
}

struct GroceryView_Previews: PreviewProvider {
  static var previews: some View {
    GroceryView()
  }
}

extension User {
  var emailWithoutSpecialCharacters: String {
    guard let email = email else {
      fatalError("Unable to access the email for the user")
    }
    let returnEmail = email.removeSpecialCharacthers()
    return returnEmail
  }
}

extension String {
  func removeSpecialCharacthers() -> String {
    var returnString = self
    let removeCharacters: Set<Character> = [".", "@"]
    returnString.removeAll(where: { removeCharacters.contains($0) } )
    return returnString
  }
}
