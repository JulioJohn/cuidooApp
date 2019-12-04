//
//  AlertType.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 04/12/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

enum AlertType: String {
    case noneBabySitter = "Não temos nenhuma cuidadora disponível na sua região no momento."
    case cancelCall = "Parece que a mãe cancelou o seu chamado."
    case cancelBabySitter = "Ao cancelar o chamado você perderá acesso aos dados da cuidadora"
    case reportBabySitter = "O reporte registra problemas graves durante o chamado"
}
