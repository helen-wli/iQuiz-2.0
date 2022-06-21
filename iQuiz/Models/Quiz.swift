//
//  Quiz.swift
//  iQuiz
//
//  Created by Helen Li on 6/20/22.
//

import Foundation

struct Quiz: Decodable {
    let title: String
    let desc: String
    let questions: [Question]
}
