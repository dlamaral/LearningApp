//
//  Questions.swift
//  LearningApp
//
//  Created by Diogo Amaral on 30/06/2022.
//

import Foundation

class Questions: Decodable, Identifiable {
    var id: Int
    var content: String
    var correctIndex: Int
    var answers: [String]
}
