//
//  QuizData.swift
//  iQuiz
//
//  Created by Helen Li on 6/20/22.
//

import Foundation

class QuizData {
    
    static let instance = QuizData()
    
    var quizzes: [Quiz]
    var correctCounter: Int // number of correct answers submitted by the user
    
    init() {
        self.quizzes = []
        self.correctCounter = -1
    }
    
}
