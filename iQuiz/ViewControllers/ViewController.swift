//
//  ViewController.swift
//  iQuiz
//
//  Created by Helen Li on 6/19/22.
//

import UIKit
import Foundation
import SystemConfiguration

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let defaultUrl: String = "https://tednewardsandbox.site44.com/questions.json"
    let iconNames: [String] = ["science-icon", "marvel-icon", "math-icon"]
    
    @IBOutlet weak var quizTableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizTableViewCell", for: indexPath) as! QuizTableViewCell
        cell.iconImageView.image = UIImage(named: iconNames[indexPath.row])
        cell.titleLabel.text = QuizData.instance.quizzes[indexPath.row].title
        cell.descLabel.text = QuizData.instance.quizzes[indexPath.row].desc
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuizData.instance.quizzes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let questionVC = storyboard?.instantiateViewController(withIdentifier: "questionViewController") as? QuestionViewController {
            questionVC.questionsOfTopic = QuizData.instance.quizzes[indexPath.row].questions
            self.navigationController?.pushViewController(questionVC, animated: true)
        }
    }
    
    // Set up the table view
    private func setUpQuizTableView() {
        quizTableView.dataSource = self
        quizTableView.delegate = self
        quizTableView.register(UINib(nibName: "QuizTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "quizTableViewCell")
    }
    
    // Read the local json file
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    // Fetch data
    private func fetchQuizData(_ fetchingUrlStr : String) {
        let request = URLRequest(url: URL(string: fetchingUrlStr)!)
        
        URLSession.shared.dataTask(with: request) { [weak self]  data, response, error in
            
            guard let self = self else { return }
            
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
                    
                    // set up the table view
                    self.setUpQuizTableView()
                    self.quizTableView.reloadData()
                }
            } else {
                print("Failed to fetch data")
                return
            }
        }.resume()
    }
    
    // Check the network
    func internetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    // Fire an alert
    func fireAlert(alertTitle : String, alertMessage : String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {
            NSLog("\(alertTitle) fired")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if self.internetAvailable() { // connected to network
            // fire an alert to give some time for fetching data
            self.fireAlert(alertTitle: "Welcome", alertMessage: "Ready to go!")
            
            // fetch data
            self.fetchQuizData(defaultUrl)
        } else { // network not available
            self.fireAlert(alertTitle: "Network not available", alertMessage: "Load local data")
            
            if let localData = self.readLocalFile(forName: "data") {
                QuizData.instance.quizzes = try! JSONDecoder().decode([Quiz].self, from: localData)
            }
            self.setUpQuizTableView()
        }
    }
    
}
