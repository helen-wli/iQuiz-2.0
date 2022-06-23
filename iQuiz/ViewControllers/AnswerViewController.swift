//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Helen Li on 6/19/22.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var currQuestionIndex: Int = -1
    var numTotalQuestions: Int = -1 // number of total questions
    var questionText: String = ""
    var answerText: String = ""
    var isCorrect: Bool = false
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    // Go to the QuestionViewController
    private func toQuestionVC() {
        if let questionVC = storyboard?.instantiateViewController(withIdentifier: "questionViewController") as? QuestionViewController {
            questionVC.currQuestionIndex = self.currQuestionIndex + 1
            questionVC.selectedChoiceIndex = -1
            self.navigationController?.pushViewController(questionVC, animated: true)
        }
    }
    
    // Go to the FinishViewController
    private func toFinishVC() {
        if let finishVC = storyboard?.instantiateViewController(withIdentifier: "finishViewController") as? FinishViewController {
            finishVC.numTotalQuestions = self.numTotalQuestions
            self.navigationController?.pushViewController(finishVC, animated: true)
        }
    }
    
    // Go back to the home screen and reset quiz score
    private func toMainVC() {
        // reset the correctCounter
        QuizData.instance.correctCounter = 0
        
        // go back to the home screen
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "viewController") as? ViewController {
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    // Update quiz score
    private func updateScore() {
        if isCorrect {
            // keep track of the number of correct answers
            QuizData.instance.correctCounter += 1
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.updateScore()
        
        if currQuestionIndex == numTotalQuestions - 1 { // last question shown, go to finishVC
            self.toFinishVC()
        } else { // more questions to go, to questionVC
            self.toQuestionVC()
        }
    }

    // swipe left to replace pressing the "Next" button
    @objc func swipeLeft(_ sender : UISwipeGestureRecognizer) {
        self.updateScore()
        
        if currQuestionIndex == numTotalQuestions - 1 {  // last question shown, go to finishVC
            self.toFinishVC()
        } else { // more questions to go, to questionVC
            self.toQuestionVC()
        }
    }
    
    // swipe up to quit the quiz, back to the home screen
    @objc func swipeUp(_ sender : UISwipeGestureRecognizer) {
        self.toMainVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionLabel.text = questionText
        answerLabel.text = answerText
        if isCorrect {
            resultLabel.text = "Got right!"
        } else {
            resultLabel.text = "Got wrong :("
        }

        // swipe left to go "Next"
        let swipeLf: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swipeLf.direction = .left
        self.view.addGestureRecognizer(swipeLf)
        
        // swipe up to quit the quiz
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
