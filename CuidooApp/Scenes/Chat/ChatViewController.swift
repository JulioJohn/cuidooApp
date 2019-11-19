//
//  ChatViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 13/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit
import Firebase
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController, MessageInputBarDelegate {

    //private let user: User
    private let channel: Channel! = nil
    
    //Mensagens
    private var messages: [Message] = []
    private var messageListener: ListenerRegistration?
    
    //Banco de dados
    private let database = Firestore.firestore()
    private var reference: CollectionReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Caminho em que o chat está sendo armazenado
        reference = database.collection(["channels", "1", "Chat"].joined(separator: "/"))
        
        navigationItem.largeTitleDisplayMode = .never
        
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.tintColor = .primary
        messageInputBar.sendButton.setTitleColor(.primary, for: .normal)

        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        
        //Atualiza a mensagem quando é adicionado uma nova
        messageListener = reference?.addSnapshotListener { querySnapshot, error in
          guard let snapshot = querySnapshot else {
            print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
            return
          }
          
          snapshot.documentChanges.forEach { change in
            self.handleDocumentChange(change)
          }
        }
    }
    
    private func insertNewMessage(_ message: Message) {
      guard !messages.contains(message) else {
        return
      }
      
      messages.append(message)
      messages.sort()
      
      let isLatestMessage = messages.firstIndex(of: message) == (messages.count - 1)
      let shouldScrollToBottom = messagesCollectionView.isAtBottom && isLatestMessage
      
      messagesCollectionView.reloadData()
      
      if shouldScrollToBottom {
        DispatchQueue.main.async {
          self.messagesCollectionView.scrollToBottom(animated: true)
        }
      }
    }
    
    private func handleDocumentChange(_ change: DocumentChange) {
      guard let message = Message(document: change.document) else {
        return
      }
      switch change.type {
      case .added:
        insertNewMessage(message)
      default:
        break
      }
    }
    
    private func save(_ message: Message) {
      reference?.addDocument(data: message.representation) { error in
        if let e = error {
          print("Error sending message: \(e.localizedDescription)")
          return
        }
        self.messagesCollectionView.scrollToBottom()
      }
    }
    
    // função de funcionamento do botão com o novo MessageKit
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
         print("apertou o botao")
           let message = Message(content: text)
           save(message)
           inputBar.inputTextView.text = ""
    }
} // end class ChatViewController


// MARK: - MessageInputBarDelegate
extension ChatViewController: MessagesDisplayDelegate {
  
    internal func backgroundColor(for message: MessageType, at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> UIColor {
    
    return isFromCurrentSender(message: message) ? .primary : .incomingMessage
  }

  func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> Bool {

    return false
  }

  func messageStyle(for message: MessageType, at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> MessageStyle {

    let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft

    return .bubbleTail(corner, .curved)
  }
  
} // end extension ChatViewController: MessagesDisplayDelegate

// MARK: - UIImagePickerControllerDelegate

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
} // end extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate

// MARK: - MessagesDataSource
extension ChatViewController: MessagesDataSource {
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func currentSender() -> SenderType {
        return Sender(id: "666", displayName: "Júlio John teste")
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

  func cellTopLabelAttributedText(for message: MessageType,
    at indexPath: IndexPath) -> NSAttributedString? {

    let name = message.sender.displayName
    return NSAttributedString(
      string: name,
      attributes: [
        .font: UIFont.preferredFont(forTextStyle: .caption1),
        .foregroundColor: UIColor(white: 0.3, alpha: 1)
      ]
    )
  }
} // end extension ChatViewController: MessagesDataSource


// MARK: - MessageLayoutDelegate
extension ChatViewController: MessagesLayoutDelegate {

  func avatarSize(for message: MessageType, at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CGSize {

    return .zero
  }

  func footerViewSize(for message: MessageType, at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CGSize {

    return CGSize(width: 0, height: 8)
  }

  func heightForLocation(message: MessageType, at indexPath: IndexPath,
    with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {

    return 0
  }
} // end extension ChatViewController: MessagesLayoutDelegate


