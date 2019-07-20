//
//  Tarefa.swift
//  DailyRoutine
//
//  Created by Matheus Marcos Maus on 19/07/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import Foundation

struct Tarefa {
    var ID: String
    var nome: String
    var horario: String
    var notas: String

    init(ID: String, nome: String, horario: String, notas: String) {
        self.ID = ID
        self.nome = nome
        self.horario = horario
        self.notas = notas
    }
}
