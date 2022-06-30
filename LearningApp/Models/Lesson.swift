//
//  Lesson.swift
//  LearningApp
//
//  Created by Diogo Amaral on 30/06/2022.
//

import Foundation

struct Lesson: Identifiable, Decodable {
    var id: Int
    var title: String
    var video: String
    var duration: String
    var explanation: String
}
