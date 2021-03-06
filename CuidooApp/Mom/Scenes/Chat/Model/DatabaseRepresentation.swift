//
//  DatabaseRepresentation.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 13/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

public protocol DatabaseRepresentation {
  var representation: [String: Any] { get }
}
