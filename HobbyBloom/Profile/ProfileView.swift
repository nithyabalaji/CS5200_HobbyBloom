//
//  ProfileView.swift
//  HobbyBloom
//
//  Created by Ashmitha appandaraju on 11/19/24.
//

import UIKit

class ProfileView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var profileImageView = UIImageView()
    var nameLabel = UILabel()
    var locationLabel = UILabel()
    var emailLabel = UILabel()

    var interestsTitleLabel = UILabel()
    var interestsCollectionView: UICollectionView!


    var personalityTitleLabel = UILabel()
    var personalityCollectionView: UICollectionView!

    var reQuizButton = UIButton()

    var interests = [String]()
    //var skills = [String]()
    var personality = [String]()

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

        // Interests
        interestsTitleLabel.text = "Interests"
        interestsTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        interestsTitleLabel.textColor = .black
        interestsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(interestsTitleLabel)

        interestsCollectionView = createTagCollectionView()
        addSubview(interestsCollectionView)


        // Personality
        personalityTitleLabel.text = "Personality"
        personalityTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        personalityTitleLabel.textColor = .black
        personalityTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(personalityTitleLabel)

        personalityCollectionView = createTagCollectionView()
        addSubview(personalityCollectionView)

        // Re-Quiz Button
        reQuizButton.setTitle("Re Quiz", for: .normal)
        reQuizButton.setTitleColor(.white, for: .normal)
        reQuizButton.backgroundColor = .purple
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

            interestsCollectionView.topAnchor.constraint(equalTo: interestsTitleLabel.bottomAnchor, constant: 10),
            interestsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            interestsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            interestsCollectionView.heightAnchor.constraint(equalToConstant: 100),

            // personality
            personalityTitleLabel.topAnchor.constraint(equalTo: interestsCollectionView.bottomAnchor, constant: 20),
            personalityTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            personalityCollectionView.topAnchor.constraint(equalTo: personalityTitleLabel.bottomAnchor, constant: 10),
            personalityCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            personalityCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            personalityCollectionView.heightAnchor.constraint(equalToConstant: 100),

    
            // Re-Quiz Button
            reQuizButton.topAnchor.constraint(equalTo: personalityCollectionView.bottomAnchor, constant: 20),
            reQuizButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            reQuizButton.widthAnchor.constraint(equalToConstant: 100),
            reQuizButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func createTagCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }

    func configureTags(for collectionView: UICollectionView, with tags: [String]) {
        if collectionView == interestsCollectionView {
            interests = tags
        } else if collectionView == personalityCollectionView {
            personality = tags
        }
        collectionView.reloadData()
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == interestsCollectionView {
            return interests.count
        } else {
            return personality.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        if collectionView == interestsCollectionView {
            cell.configure(tag: interests[indexPath.row])
        } else if collectionView == personalityCollectionView {
            cell.configure(tag: personality[indexPath.row])
        }
        return cell
    }
}

class TagCell: UICollectionViewCell {
    private let label = PaddingLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.backgroundColor = .myDarkRed
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.padding = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        label.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(tag: String) {
        label.text = tag
    }
}
