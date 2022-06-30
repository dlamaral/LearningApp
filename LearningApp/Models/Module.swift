//
//  Module.swift
//  LearningApp
//
//  Created by Diogo Amaral on 30/06/2022.
//

import Foundation

class Module: Identifiable, Decodable {
    var id: Int
    var category: String
    var content: Content
    var test: Test
}
