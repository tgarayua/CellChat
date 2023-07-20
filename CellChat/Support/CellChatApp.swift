//
//  CellChatApp.swift
//  CellChat
//
//  Created by Thomas Garayua on 7/19/23.
//

import SwiftUI
import Firebase

@main
struct CellChatApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
