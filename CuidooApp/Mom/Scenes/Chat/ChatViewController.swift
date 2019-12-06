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
    
    @IBOutlet weak var babySitterChatImageView: UIImageView!
    
    //private let user: User
    private let channel: Channel! = nil
    
    //Mensagens
    private var messages: [Message] = []
    
    var chatServices: ChatServices!
    
    var matchId: String?
    
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        babySitterChatImageView.layer.cornerRadius = 19.859
        
        navigationItem.largeTitleDisplayMode = .never
    
        messageInputBar.inputTextView.tintColor = .primary
        messageInputBar.sendButton.setTitleColor(.primary, for: .normal)
        configureMessageCollectionView()
        messageInputBar.delegate = self
        
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        //O user ID deve ser setado na tela anterior
        
        self.matchId = LoggedUser.shared.actualMatchID
        
        if let id = matchId {
            self.chatServices = ChatServices(matchId: id)
            self.chatServices.addListener { (message, error) in
                if error != nil {
                    print(error)
                    return
                } else {
                    self.insertNewMessage(message!)
                }
            }
        } else {
            print("O matchId não existe!")
        }
    }
    func configureMessageCollectionView() {
        
        messagesCollectionView.messagesDataSource = self
        
        scrollsToBottomOnKeyboardBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false
        
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
        return Sender(id: LoggedUser.shared.uid!, displayName: LoggedUser.shared.name!)
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
  
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        if let firstMessageId = messages.first?.id, firstMessageId == message.messageId {
            return 75
        }
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
