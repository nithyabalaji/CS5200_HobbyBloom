//
//  CommentsView.swift
//  HobbyBloom
//
//  Created by Ashmitha appandaraju on 12/3/24.
//

import UIKit

class CommentsView: UIView {
   
        let tableView: UITableView = {
                let tableView = UITableView()
                tableView.translatesAutoresizingMaskIntoConstraints = false
                tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CommentCell")
                return tableView
            }()
    
            let commentInputField: UITextField = {
                let textField = UITextField()
                textField.placeholder = "Add a comment..."
                textField.borderStyle = .roundedRect
                textField.translatesAutoresizingMaskIntoConstraints = false
                return textField
            }()
    
            let sendButton: UIButton = {
                let button = UIButton(type: .system)
                button.setTitle("Send", for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = false
                return button
            }()
    
            private let inputContainer: UIView = {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
    
            // MARK: - Initialization
            override init(frame: CGRect) {
                super.init(frame: frame)
                setupUI()
            }
    
            required init?(coder: NSCoder) {
                super.init(coder: coder)
                setupUI()
            }
    
            // MARK: - Setup UI
            private func setupUI() {
                // Add subviews
                addSubview(tableView)
                addSubview(inputContainer)
                inputContainer.addSubview(commentInputField)
                inputContainer.addSubview(sendButton)
    
                // Setup constraints
                NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: topAnchor),
                    tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    tableView.bottomAnchor.constraint(equalTo: inputContainer.topAnchor),
    
                    inputContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
                    inputContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
                    inputContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                    inputContainer.heightAnchor.constraint(equalToConstant: 50),
    
                    commentInputField.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor, constant: 10),
                    commentInputField.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor),
                    commentInputField.heightAnchor.constraint(equalToConstant: 35),
    
                    sendButton.leadingAnchor.constraint(equalTo: commentInputField.trailingAnchor, constant: 10),
                    sendButton.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor, constant: -10),
                    sendButton.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor),
                    sendButton.widthAnchor.constraint(equalToConstant: 50)
                ])
    
            }
  
}

