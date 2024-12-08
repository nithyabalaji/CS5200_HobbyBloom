import UIKit

class QuizView: UIView {
    
    let questions = [
        "Would you rather run a marathon or paint a mural?",
        "Would you rather watch a sports game or attend a music festival?",
        "Would you rather camp in the wilderness or party all night in the city?",
        "Would you rather attend a live concert or a fashion show?",
        "Would you rather try a food-tasting experience or laugh at a live comedy show?",
        "Would you rather attend an in-person workshop or learn something new through a virtual class?",
        "Are you a ",
        "Who do you think you best suited to be?",
    ]
    
    let answerOptions = [
        ["Fitness", "Arts & Crafts"],
        ["Sports", "Festivals & Fairs"],
        ["Nature", "Party"],
        ["Music", "Fashion"],
        ["Food", "Comedy"],
        ["Workshop", "Virtual"],
        ["Explorer", "Learner"],
        ["Entertainer", "Energetic"]
    ]
    
    var answerButtons = [[UIButton]]() // Array to hold buttons for each question
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .myPurple // Updated to use myPurple color
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        var previousQuestion: UIView? = nil
        
        for (index, question) in questions.enumerated() {
            // Create question label
            let questionLabel = UILabel()
            questionLabel.text = "\(index + 1). \(question)"
            questionLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            questionLabel.numberOfLines = 2 // Allow two lines
            questionLabel.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.addSubview(questionLabel)
            NSLayoutConstraint.activate([
                questionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
                questionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
                questionLabel.topAnchor.constraint(equalTo: previousQuestion?.bottomAnchor ?? scrollView.topAnchor, constant: 24)
            ])
            
            // Create answer buttons
            let option1Button = createOptionButton(title: answerOptions[index][0])
            let option2Button = createOptionButton(title: answerOptions[index][1])
            answerButtons.append([option1Button, option2Button])
            
            // Add buttons to view
            scrollView.addSubview(option1Button)
            scrollView.addSubview(option2Button)
            
            NSLayoutConstraint.activate([
                option1Button.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 8),
                option1Button.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
                option1Button.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.4), // Less than half width
                option1Button.heightAnchor.constraint(equalToConstant: 28), // Reduced button height
                
                option2Button.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 8),
                option2Button.leadingAnchor.constraint(equalTo: option1Button.trailingAnchor, constant: 16),
                option2Button.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
                option2Button.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.4), // Less than half width
                option2Button.heightAnchor.constraint(equalToConstant: 28)  // Reduced button height
            ])
            
            previousQuestion = option2Button
        }
        
        // Add Save button
        scrollView.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: previousQuestion?.bottomAnchor ?? scrollView.topAnchor, constant: 32),
            saveButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 120),
            saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }

    
    private func createOptionButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .myLightPurple // Updated to use myLightPurple color
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6 // Smaller corner radius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
