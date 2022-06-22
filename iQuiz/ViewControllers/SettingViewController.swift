//
//  SettingViewController.swift
//  iQuiz
//
//  Created by Helen Li on 6/19/22.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    
    // Fire an alert
    func fireAlert(alertTitle : String, alertMessage : String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {
            NSLog("\(alertTitle) fired")
        })
    }
    
    // Check whether the input is a valid url
    private func isValidInput(_ input: String?) -> Bool {
        // case: empty input
        if input == "" {
            fireAlert(alertTitle: "Empty Input", alertMessage: "Please enter a valid URL")
            return false
        }
        
        // for non-empty input, check whether the input is a valid URL
        if let urlString = input {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    // Fetch data
    private func fetchQuizData(_ fetchingUrlStr : String) {
        let request = URLRequest(url: URL(string: fetchingUrlStr)!)
        
        URLSession.shared.dataTask(with: request) { [weak self]  data, response, error in
            
            guard self != nil else { return }
            
            guard error == nil else {
                print("Cannot parse data")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
            else {
                print("Error with http response")
                return
            }
            
            guard let data = data else {
                print("No data found")
                return
            }
            
            if let quizData = try? JSONDecoder().decode([Quiz].self, from: data) {
                DispatchQueue.main.async {
                    // save data to the QuizData singleton
                    QuizData.instance.quizzes = quizData
                }
            } else {
                print("Cannot fetch data")
                return
            }
        }.resume()
    }
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        let textInput = urlTextField.text
        if isValidInput(textInput) {
            self.fetchQuizData(textInput!)
        } else {
            fireAlert(alertTitle: "Not a URL", alertMessage: "Please enter a valid URL")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
