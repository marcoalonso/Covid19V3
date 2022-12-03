//
//  PaisModel.swift
//  CovidEscapingClosures
//
//  Created by Marco Alonso Rodriguez on 02/12/22.
//

import Foundation

struct Covid: Codable {
    let Countries: [Pais]
}

struct Pais: Codable {
    let Country: String
    let TotalConfirmed: Int
}
