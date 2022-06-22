//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Helen Li on 6/19/22.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // current question number
    var currQuestionIndex: Int = 0
    
    // current question
    var currQuestion: Question? = nil

    // the selected choice's number
    var selectedChoiceIndex: Int = -1
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var choiceTableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "choiceTableViewCell", for: indexPath) as! ChoiceTableViewCell
        cell.choiceLabel.text = currQuestion!.answers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currQuestion!.answers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedChoiceIndex = indexPath.row
    }
    
    // Fire an alert
    func fireAlert(alertTitle : String, alertMessage : String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {
            NSLog("\(alertTitle) fired")
        })
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if self.selectedChoiceIndex == -1 { // have not selected a choice
            fireAlert(alertTitle: "Oops", alertMessage: "Please select a choice to submit")
        } else {
            let correctChoiceIndex = Int(currQuestion!.answer)! - 1
            
            if let answerVC = storyboard?.instantiateViewController(withIdentifier: "answerViewController") as? AnswerViewController {
                answerVC.currQuestionIndex = self.currQuestionIndex
                answerVC.numTotalQuestions = QuizData.instance.questionsOfTopic.count
                answerVC.questionText = currQuestion!.text
                answerVC.answerText = currQuestion!.answers[correctChoiceIndex]
                answerVC.isCorrect = correctChoiceIndex == self.selectedChoiceIndex
                self.navigationController?.pushViewController(answerVC, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set up question label
        currQuestion = QuizData.instance.questionsOfTopic[currQuestionIndex]
        questionLabel.text = currQuestion!.text
        
        // set up table view
        choiceTableView.dataSource = self
        choiceTableView.delegate = self
        choiceTableView.register(UINib(nibName: "ChoiceTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "choiceTableViewCell")
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
