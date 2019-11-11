//
//  FirebaseEnums.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 11/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

public enum FirestoreCollectionReference: String {
  case users = "Users"
  case conversations = "Conversations"
  case messages = "Messages"
}

public enum FirestoreResponse {
  case success
  case failure
}
