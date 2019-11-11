//
//  Encodable.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 11/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//
import Foundation

extension Encodable {
  var values: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
