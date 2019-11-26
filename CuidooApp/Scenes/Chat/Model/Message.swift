//
//  Message.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 13/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import MessageKit

class Message: MessageType {
    var kind: MessageKind
    
    //Necessário para o protocolo MessageType
    let sender: SenderType
    var messageId: String {
      return id ?? UUID().uuidString
    }
    let sentDate: Date
    
    let id: String?
    let content: String //isso aqui é o kind.text
    
    var image: UIImage? = nil
    var downloadURL: URL? = nil
    
    init(content: String) {
        sender = Sender(id: LoggedUser.shared.user!.uid, displayName: LoggedUser.shared.user!.name)
        self.content = content
        self.kind = MessageKind.text(content)
        sentDate = Date()
        id = nil
    }
    
//    init(image: UIImage) {
//      sender = Sender(id: "666", displayName: "Julio Trocar depois")
//      self.image = image
//        self.kind = MessageKind.photo(MediaItem(image))
//      content = ""
//      sentDate = Date()
//      id = nil
//    }
    
    init?(document: QueryDocumentSnapshot) {
      let data = document.data()
        
      guard let sentDate = data["created"] as? Timestamp else {
        return nil
      }
        
      guard let senderID = data["senderID"] as? String else {
        return nil
      }
      guard let senderName = data["senderName"] as? String else {
        return nil
      }
      
      id = document.documentID
      
      self.sentDate = sentDate.dateValue()
      sender = Sender(id: senderID, displayName: senderName)
      
      if let content = data["content"] as? String {
        self.kind = MessageKind.text(content)
        self.content = content
        downloadURL = nil
      } else if let urlString = data["url"] as? String, let url = URL(string: urlString) {
        self.kind = MessageKind.text("Deu erro! Guardou uma URL, verificar!")
        downloadURL = url
        content = ""
      } else {
        return nil
      }
    }
} // end class Message 

extension Message: DatabaseRepresentation {
    var representation: [String : Any] {
        var rep: [String : Any] = [
          "created": sentDate,
          "senderID": sender.senderId,
          "senderName": sender.displayName
        ]
        
        if let url = downloadURL {
          rep["url"] = url.absoluteString
        } else {
          rep["content"] = content
        }
        
        return rep
    }
} // end extension Message: DatabaseRepresentation

//É necessário para cumprir o protocolo Equatable
extension Message: Comparable {
  
  static func == (lhs: Message, rhs: Message) -> Bool {
    return lhs.id == rhs.id
  }
  
  static func < (lhs: Message, rhs: Message) -> Bool {
    return lhs.sentDate < rhs.sentDate
  }
  
} // end extension Message: Comparable
