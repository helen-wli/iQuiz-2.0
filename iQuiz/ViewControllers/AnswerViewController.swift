//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Helen Li on 6/19/22.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var questionText: String = ""
    var answerText: String = ""
    var isCorrect: Bool = false
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        // go to questionVC
        
        // go to finishVC
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
