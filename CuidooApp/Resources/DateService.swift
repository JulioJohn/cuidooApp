//
//  DateService.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 11/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class DateService {
  
  static let shared = DateService()
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
  }()
  
  private init() {}
  
  func format(_ date: Date) -> String {
    return dateFormatter.string(from: date)
  }
}
