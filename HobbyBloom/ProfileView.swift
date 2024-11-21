//
//  ProfileView.swift
//  HobbyBloom
//
//  Created by Ashmitha appandaraju on 11/19/24.
//
import UIKit

class ProfileView: UIView {

    var profileImageView = UIImageView()
    var nameLabel = UILabel()
    var locationLabel = UILabel()
    var emailLabel = UILabel()

    var interestsTitleLabel = UILabel()
    var interestsStackView = UIStackView()
    
    var skillsTitleLabel = UILabel()
    var skillsStackView = UIStackView()
    
    var personalityTitleLabel = UILabel()
    var personalityStackView = UIStackView()
    
    var reQuizButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     func setupViews() {
        // Profile Image
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.tintColor = .black
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImageView)

        // Name Label
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)

        // Location Label
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.textColor = .gray
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(locationLabel)

        // Email Label
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.textColor = .gray
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailLabel)

        // Tags: Interests
        interestsTitleLabel.text = "Interests"
        interestsTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        interestsTitleLabel.textColor = .black
        interestsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(interestsTitleLabel)

        interestsStackView.axis = .horizontal
        interestsStackView.spacing = 8
        interestsStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(interestsStackView)

        // Tags: Skills
        skillsTitleLabel.text = "Skills"
        skillsTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        skillsTitleLabel.textColor = .black
        skillsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(skillsTitleLabel)

        skillsStackView.axis = .horizontal
        skillsStackView.spacing = 8
        skillsStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(skillsStackView)

        // Tags: Personality
        personalityTitleLabel.text = "Personality"
        personalityTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        personalityTitleLabel.textColor = .black
        personalityTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(personalityTitleLabel)

        personalityStackView.axis = .horizontal
        personalityStackView.spacing = 8
        personalityStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(personalityStackView)

        // Re-Quiz Button
        reQuizButton.setTitle("Re Quiz", for: .normal)
        reQuizButton.setTitleColor(.white, for: .normal)
         reQuizButton.backgroundColor = .myDarkPurple
        reQuizButton.layer.cornerRadius = 8
        reQuizButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(reQuizButton)
    }

     func setupConstraints() {
        NSLayoutConstraint.activate([
            // Profile Image
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),

            // Name Label
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            // Location Label
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            // Email Label
            emailLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            emailLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            // Interests
            interestsTitleLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            interestsTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            interestsStackView.topAnchor.constraint(equalTo: interestsTitleLabel.bottomAnchor, constant: 10),
            interestsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            // Skills
            skillsTitleLabel.topAnchor.constraint(equalTo: interestsStackView.bottomAnchor, constant: 20),
            skillsTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            skillsStackView.topAnchor.constraint(equalTo: skillsTitleLabel.bottomAnchor, constant: 10),
            skillsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            // Personality
            personalityTitleLabel.topAnchor.constraint(equalTo: skillsStackView.bottomAnchor, constant: 20),
            personalityTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            personalityStackView.topAnchor.constraint(equalTo: personalityTitleLabel.bottomAnchor, constant: 10),
            personalityStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            // Re-Quiz Button
            reQuizButton.topAnchor.constraint(equalTo: personalityStackView.bottomAnchor, constant: 80),
            reQuizButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            reQuizButton.widthAnchor.constraint(equalToConstant: 100),
            reQuizButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func configureTags(for stackView: UIStackView, with tags: [String]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        for tag in tags {
            let tagLabel = PaddingLabel()
            tagLabel.text = tag
            tagLabel.font = UIFont.systemFont(ofSize: 14)
            tagLabel.textColor = .white
            tagLabel.backgroundColor = .red
            tagLabel.textAlignment = .center
            tagLabel.layer.cornerRadius = 8
            tagLabel.clipsToBounds = true
            tagLabel.padding = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
            tagLabel.translatesAutoresizingMaskIntoConstraints = false
            tagLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
            tagLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
            stackView.addArrangedSubview(tagLabel)
        }
    }
}

