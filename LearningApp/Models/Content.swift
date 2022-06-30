//
//  Content.swift
//  LearningApp
//
//  Created by Diogo Amaral on 30/06/2022.
//

import Foundation

class Content: Identifiable, Decodable {
    var id: Int
    var image: String
    var time: String
    var description: String
    var lessons: [Lesson]
}
