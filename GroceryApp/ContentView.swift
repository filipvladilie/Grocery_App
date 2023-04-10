//
//  ContentView.swift
//  GroceryApp
//
//  Created by Vlad Filip on 23.01.2023.
//

import SwiftUI
import Firebase

struct ContentView: View {
  
  @State private var loginEmail: String = ""
  @State private var loginPassword: String = ""
  @State private var registerEmail: String = ""
  @State private var registerPassword: String = ""
  @State private var showRegisterAlert: Bool = false
  @State private var linkNavigation: Bool = false
  
  var body: some View {
    VStack {
      HStack {
        Text("Login")
        Spacer()
      }
      .padding(.horizontal, 50)
      TextField("", text: $loginEmail)
        .frame(width: 300, height: 30)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(.blue, lineWidth: 1)
        )
      TextField("", text: $loginPassword)
        .frame(width: 300, height: 30)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(.blue, lineWidth: 1)
        )
      Button(action: {
        loginAction()
      }, label: {
        Text("Login")
      })
      .buttonStyle(.borderedProminent)
      
      HStack {
        Text("Register")
        Spacer()
      }
      .padding(.horizontal, 50)
      TextField("", text: $registerEmail)
        .frame(width: 300, height: 30)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(.blue, lineWidth: 1)
        )
      TextField("", text: $registerPassword)
        .frame(width: 300, height: 30)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(.blue, lineWidth: 1)
        )
      Button(action: {
        registerUser()
      }, label: {
        Text("Register")
      })
      .buttonStyle(.borderedProminent)
      .alert("Success", isPresented: $showRegisterAlert, actions: {
        Button("OK", role: .cancel){}
      })
      
      NavigationLink("", destination: GroceryView(), isActive: $linkNavigation)
    }
  }
  
  func registerUser() {
    if registerEmail != "" && registerPassword != "" {
      Auth.auth().createUser(withEmail: registerEmail, password: registerPassword) { user, error in
        if let error {
          print("EEROR REGISTER \(error)")
          return
        }
        showRegisterAlert = true
      }
    }
  }
  
  private func loginAction() {
    if loginEmail != "" && loginPassword != "" {
      Auth.auth().signIn(withEmail: loginEmail, password: loginPassword) { user, error in
        if let error {
          print("ERROR LOGIN \(error)")
          return
        }
        linkNavigation = true
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
