//
//  MatchFlowError.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 05/12/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

enum MatchFlowError: Error {
    case thisMatchIsNotAvailable
    case thisMatchIsNoLongerAvailable
    case noMatchExists
    case noAvailableMatchExists
}
