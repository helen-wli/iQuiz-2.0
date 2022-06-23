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
    
    // Go back to the home screen
    private func toMainVC() {
        // reset the correctCounter
        QuizData.instance.correctCounter = 0
        
        // go back to the home screen
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "viewController") as? ViewController {
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        self.toMainVC()
    }
    
    // swipe left to replace pressing "Done", go back to the home screen
    @objc func swipeLeft(_ sender : UISwipeGestureRecognizer) {
        self.toMainVC()
    }
    
    // swipe up to quit the quiz, back to the home screen
    @objc func swipeUp(_ sender : UISwipeGestureRecognizer) {
        self.toMainVC()
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
        
        // swipe left action
        let swipeLf: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swipeLf.direction = .left
        self.view.addGestureRecognizer(swipeLf)
        
        // swipe up action
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
