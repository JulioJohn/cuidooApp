//
//  ChatViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 13/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController, MessageInputBarDelegate {

    @IBOutlet weak var headView: UIView!
    
    //private let user: User
    private let channel: Channel! = nil
    
    //Mensagens
    private var messages: [Message] = []
    
    var chatServices: ChatServices!
    var matchId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        scrollsToBottomOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.tintColor = .primary
        messageInputBar.sendButton.setTitleColor(.primary, for: .normal)

        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        //match ID deve  ser setado na tela anterior
        self.matchId = LoggedUser.shared.actualMatch?.documentId
        
        self.chatServices = ChatServices(matchId: matchId)
        self.chatServices.addListener { (message, error) in
            if error != nil {
                print(error)
                return
            } else {
                self.insertNewMessage(message!)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.bringSubviewToFront(headView)
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
    
    private func save(_ message: Message) {
        chatServices.save(message) {
            self.messagesCollectionView.scrollToBottom()
        }
    }
    
    // Função de funcionamento do botão com o novo MessageKit
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
           let message = Message(content: text)
           save(message)
           inputBar.inputTextView.text = ""
    }

    
}


// MARK: - MessageInputBarDelegate
extension ChatViewController: MessagesDisplayDelegate {
  
    internal func backgroundColor(for message: MessageType, at indexPath: IndexPath,
                                  in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        return isFromCurrentSender(message: message) ? .cuidooPurple : .incomingMessage
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath,
                             in messagesCollectionView: MessagesCollectionView) -> Bool {
        
        return false
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath,
                      in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        //  let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        
        return .bubble
    }
    
  
}

// MARK: - UIImagePickerControllerDelegate

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
}

// MARK: - MessagesDataSource
extension ChatViewController: MessagesDataSource {

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func currentSender() -> SenderType {
        return Sender(id: LoggedUser.shared.user!.uid, displayName: LoggedUser.shared.user!.name)
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
}


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
   
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString (
            string: name,
            attributes: [.font: UIFont.preferredFont(forTextStyle: .caption1),
                         .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
    }
    
    
    
}
