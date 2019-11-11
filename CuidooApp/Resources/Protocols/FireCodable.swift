//
//  FireCodable.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 11/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import UIKit

protocol BaseCodable: class {
  var id: String { get set }
}

protocol FireCodable: BaseCodable, Codable {
  var id: String { get set }
}

protocol FireStorageCodable: FireCodable {
  
  var profilePic: UIImage? { get set }
  var profilePicLink: String? { get set }
  
} 
