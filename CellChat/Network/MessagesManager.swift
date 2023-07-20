//
//  MessagesManager.swift
//  CellChat
//
//  Created by Thomas Garayua on 7/19/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class MessagesManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageID = ""
    let db = Firestore.firestore()
    
    init() {
        getMessages()
    }
    
    func getMessages() {
        db.collection("messages").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching documents", error.localizedDescription)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents:", error?.localizedDescription ?? "nil")
                return
            }
            
            self.messages = documents.compactMap { document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding document into message:", error.localizedDescription)
                    return nil
                }
            }
            
            self.messages.sort { $0.timestamp < $1.timestamp }
            
            if let id = self.messages.last?.id {
                self.lastMessageID = id
            }
        }
    }
    
    func sendMessage(text: String) {
        do {
            let newMessage = Message(id: "\(UUID())", text: text, received: false, timestamp: Date())
            try db.collection("messages").document().setData(from: newMessage)
        } catch {
            print("Error adding message to Firestore:", error.localizedDescription)
        }
    }
}
