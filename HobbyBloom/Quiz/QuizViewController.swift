//
//  QuizViewController.swift
//  HobbyBloom
//
//  Created by Bhumi Shah on 12/2/24.
//
//
//import UIKit
//import Firebase
//
//class QuizViewController: UIViewController {
//    
//    let quizView = QuizView()
//    var answers = [Int?](repeating: nil, count: 6)
//    let db = Firestore.firestore()
//    var userId: String?
//    
//    override func loadView() {
//        view = quizView
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupActions()
//        quizView.saveButton.addTarget(self, action: #selector(saveInterests), for: .touchUpInside)
//    }
//    
//    private func setupActions() {
//        for (questionIndex, buttons) in quizView.answerButtons.enumerated() {
//            for (optionIndex, button) in buttons.enumerated() {
//                button.tag = questionIndex * 10 + optionIndex
//                button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
//            }
//        }
//    }
//    
//    @objc func optionSelected(_ sender: UIButton) {
//        let questionIndex = sender.tag / 10
//        let optionIndex = sender.tag % 10
//        
//        quizView.answerButtons[questionIndex].forEach { $0.backgroundColor = .lightGray }
//        sender.backgroundColor = .blue
//        answers[questionIndex] = optionIndex
//    }
//    
//    @objc func saveInterests() {
//        guard let userId = userId else {
//            print("User ID not found")
//            return
//        }
//        
//        // Check if all questions are answered
//        guard answers.allSatisfy({ $0 != nil }) else {
//            print("Please answer all questions")
//            return
//        }
//        
//        // Map answers to the corresponding interests
//        var selectedInterests = [String]()
//        for (index, answer) in answers.enumerated() {
//            if let answerIndex = answer {
//                selectedInterests.append(quizView.answerOptions[index][answerIndex])
//            }
//        }
//        
//        // Save interests to Firestore under the user's document
//        db.collection("users").document(userId).setData(["interests": selectedInterests], merge: true) { error in
//            if let error = error {
//                print("Error saving interests: \(error.localizedDescription)")
//            } else {
//                print("Interests saved successfully")
//                // Navigate to ProfileViewController after saving interests
//                            DispatchQueue.main.async {
//                                let profileViewController = ProfileViewController() // Assuming you have a ProfileViewController
//                                self.navigationController?.pushViewController(profileViewController, animated: true)
//                            }
//            }
//        }
//        
//    }
//}
// QuizViewController.swift
import UIKit
import Firebase
import FirebaseAuth

class QuizViewController: UIViewController {
    
    let quizView = QuizView()
    let db = Firestore.firestore()
    var userId: String?
    var answers = [Int?](repeating: nil, count: 8)  // For the first 6 questions (interests)
    var personalityAnswers = [String?](repeating: nil, count: 2)
    
    override func loadView() {
        view = quizView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        quizView.saveButton.addTarget(self, action: #selector(saveInterestsTapped), for: .touchUpInside)
    }
    
    private func setupActions() {
        for (questionIndex, buttons) in quizView.answerButtons.enumerated() {
            for (optionIndex, button) in buttons.enumerated() {
                button.tag = questionIndex * 10 + optionIndex
                button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            }
        }
    }
    
    @objc func optionSelected(_ sender: UIButton) {
        let questionIndex = sender.tag / 10
        let optionIndex = sender.tag % 10
        
        quizView.answerButtons[questionIndex].forEach { $0.backgroundColor = .myLightPurple }
        sender.backgroundColor = .myPurple
        answers[questionIndex] = optionIndex
        
        if questionIndex == 6 {
            personalityAnswers[0] = quizView.answerOptions[6][optionIndex]
        } else if questionIndex == 7 {
            personalityAnswers[1] = quizView.answerOptions[7][optionIndex]
        }
    }


    
    
    @objc func saveInterestsTapped() {
        saveInterestsAndNavigate()
    }
 
    private func saveInterestsAndNavigate() {
        guard let userId = userId else {
            print("User ID not found")
            return
        }
        
        // Check if all questions are answered
        guard answers.allSatisfy({ $0 != nil }) && personalityAnswers.allSatisfy({ $0 != nil }) else {
            print("Please answer all questions")
            return
        }
        
        // Map answers to the corresponding interests
        var selectedInterests = [String]()
        for (index, answer) in answers.enumerated() {
            if index < answers.count - 2 {
                if let answerIndex = answer {
                    if index < quizView.answerOptions.count {
                        selectedInterests.append(quizView.answerOptions[index][answerIndex])
                    }
                }
            }
        }
        
        // Map personality answers to an array
        var selectedPersonality = [String]()
        for personalityAnswer in personalityAnswers {
            if let answer = personalityAnswer {
                selectedPersonality.append(answer)
            }
        }
        
        // Save interests and personality to Firestore under the user's document
        db.collection("users").document(userId).setData([
            "interests": selectedInterests,
            "personality": selectedPersonality
        ], merge: true) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error saving interests and personality: \(error.localizedDescription)")
                    // Show an error label or alert if needed
                } else {
                    print("Interests and personality saved successfully")
                    self.dismiss(animated: true)
                    if let navigationController = self.navigationController {
                                   for controller in navigationController.viewControllers {
                                       if let profileVC = controller as? ProfileViewController {
                                           navigationController.popToViewController(profileVC, animated: true)
                                           return
                                       }
                                   }

                                   let profileViewController = ProfileViewController()
                                   profileViewController.currentUser = Auth.auth().currentUser
                                   navigationController.pushViewController(profileViewController, animated: true)
                               }
                }
            }
        }
    }


}
