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
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if isCorrect {
            // keep track of the number of correct answers
            QuizData.instance.correctCounter += 1
        }
        
        if currQuestionIndex == numTotalQuestions - 1 { // last question shown
            // go to finishVC
            if let finishVC = storyboard?.instantiateViewController(withIdentifier: "finishViewController") as? FinishViewController {
                finishVC.numTotalQuestions = self.numTotalQuestions
                self.navigationController?.pushViewController(finishVC, animated: true)
            }
        } else { // more questions to go
            // go to questionVC
            if let questionVC = storyboard?.instantiateViewController(withIdentifier: "questionViewController") as? QuestionViewController {
                questionVC.currQuestionIndex = self.currQuestionIndex + 1
                questionVC.selectedChoiceIndex = -1
                self.navigationController?.pushViewController(questionVC, animated: true)
            }
        }
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
