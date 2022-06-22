//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Helen Li on 6/19/22.
//

import UIKit

class FinishViewController: UIViewController {
    
    var numTotalQuestions: Int = -1
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        // reset the correctCounter
        QuizData.instance.correctCounter = 0
        
        // to back to the home screen
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "viewController") as? ViewController {
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if QuizData.instance.correctCounter == numTotalQuestions { // answered all questions correctly
            messageLabel.text = "Perfect!"
        } else {
            messageLabel.text = "Almost :)"
        }
        scoreLabel.text = "Score: \(QuizData.instance.correctCounter)/\(numTotalQuestions) correct"
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
