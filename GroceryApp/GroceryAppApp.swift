//
//  GroceryAppApp.swift
//  GroceryApp
//
//  Created by Vlad Filip on 23.01.2023.
//

import SwiftUI
import Firebase

@main
struct GroceryAppApp: App {
  @Environment(\.scenePhase) var scenePhase
  init() {
    FirebaseApp.configure()
  }
  
  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
          .onChange(of: scenePhase) { newPhase in
            
            if newPhase == .background {
              do {
                try Auth.auth().signOut()
              }
              catch {
                print("ERRR")
              }
            }
          }
      }
    }
  }
}
