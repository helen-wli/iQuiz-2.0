//
//  Question.swift
//  iQuiz
//
//  Created by Helen Li on 6/20/22.
//

import Foundation

struct Question: Decodable {
    let text: String
    let answer: String
    let answers: [String]
}
