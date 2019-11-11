//
//  Optional.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 11/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

extension Optional {
  var isNone: Bool {
    return self == nil
  }
  
  var isSome: Bool {
    return self != nil
  }
}

extension String {

func isValidEmail() -> Bool {
  let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
  let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
  return emailTest.evaluate(with: self)}
}
