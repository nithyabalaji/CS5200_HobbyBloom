//
//  ActivityDetailsViewController.swift
//  HobbyBloom
//
//  Created by Nishy Ann Tomy on 11/22/24.
//
import UIKit
import FirebaseFirestore
import MapKit
import FirebaseAuth
class ActivityDetailsViewController: UIViewController  {
    // MARK: - Model Properties
    var activity: Activity?
    var users: [String] = []
    var tags: [String] = []
    var comments: [Comment] = []
    var activityID: String!
    
    // MARK: - Firebase Firestore Reference
    let db = Firestore.firestore()
    // MARK: - UI Elements
    private let activityDetailsView = ActivityDetailsView()
    let commentsView = CommentsView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchActivityData()
        fetchComments()
        setupActions()
        self.activityDetailsView.seeAllButton.addTarget(self, action: #selector(didTapSeeAll), for: .touchUpInside)
        self.activityDetailsView.seeAllCommentsButton.addTarget(self, action: #selector(didTapSeeAllComments), for: .touchUpInside)
        self.activityDetailsView.attendButton.addTarget(self, action: #selector(didTapattend), for: .touchUpInside)
    }
   
    @objc private func didTapattend() {
        activityDetailsView.attendButton.isEnabled = false
        activityDetailsView.attendButton.setTitle("Attending", for: .normal)
        addAttendee()
        fetchUsersForActivity(activityId: activityID)
    }
    func addAttendee(){
        guard let activityId = activityID else { return }

        guard let userEmail = Auth.auth().currentUser?.email else {
                print("User is not logged in.")
                return
            }

            let attendees = [
                "email": userEmail,
            ] as [String: Any]

        db.collection("activities")
            .document(activityId)
            .collection("attendees")
            .addDocument(data: attendees) { error in
                if let error = error {
                    print("Error adding comment: \(error)")
                }
            }
    }
        // MARK: - Add Comment
        private func addComment(text: String) {
            guard let activityId = activityID else { return }

            guard let userEmail = Auth.auth().currentUser?.email else {
                    print("User is not logged in.")
                    return
                }

                let comment = [
                    "email": userEmail,
                    "text": text,
                    "time": FieldValue.serverTimestamp()
                ] as [String: Any]

            db.collection("activities")
                .document(activityId)
                .collection("comments")
                .addDocument(data: comment) { error in
                    if let error = error {
                        print("Error adding comment: \(error)")
                    }
                }
        }

        // MARK: - Setup Actions
        

        @objc private func didTapSend() {
            guard let text = commentsView.commentInputField.text, !text.isEmpty else { return }
            addComment(text: text)
            commentsView.commentInputField.text = ""
        }
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(activityDetailsView)
        view.addSubview(commentsView)
        activityDetailsView.translatesAutoresizingMaskIntoConstraints = false
        commentsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // ActivityDetailsView constraints
            activityDetailsView.topAnchor.constraint(equalTo: view.topAnchor),
            activityDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityDetailsView.bottomAnchor.constraint(equalTo: commentsView.topAnchor), // Fixed

            // CommentsView constraints
            commentsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commentsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            commentsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            commentsView.topAnchor.constraint(equalTo: activityDetailsView.bottomAnchor) 
        ])
        
    }
    private func setupActions() {
            commentsView.sendButton.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)
        }
    
        
    private func fetchComments() {
        print("fetchComments called")
        guard let activityId = activityID else {
            print("Activity ID is nil")
            return
        }
        print("Fetch comments:" )
        db.collection("activities")
            .document(activityId)
            .collection("comments")
            .order(by: "time", descending: false)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error fetching comments: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No comments found")
                    return
                }

                self?.comments = documents.compactMap { document in
                    let data = document.data()
                    let text = data["text"] as? String ?? ""
                    let email = data["email"] as? String ?? "Anonymous"
                    let time = data["time"] as? Timestamp ?? Timestamp()
                    
                    return Comment(email: email, text: text, time: time)
                }

                //print("Fetched comments: \(self?.comments)")
                // Assuming `comments` is an array of `Comment` objects fetched from Firebase
                DispatchQueue.main.async {
                    self?.activityDetailsView.comments = self?.comments ?? []
                    self?.activityDetailsView.updateCommentsStackView()
                }

            }
    }

    @objc func didTapSeeAllComments() {
        guard !comments.isEmpty else {
            let alert = UIAlertController(title: "No Comments", message: "There are no comments to display.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Create the alert
        let alert = UIAlertController(title: "Comments", message: nil, preferredStyle: .alert)
        
        // Define a custom view to contain the scrollable list
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        alert.view.addSubview(customView)
        
        // Create a scroll view and stack view
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview(scrollView)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        // Add comments to the stack view
        for comment in comments.prefix(20) {
            let tile = UIView()
            tile.backgroundColor = .myLightPurple
            tile.layer.cornerRadius = 8
            tile.layer.masksToBounds = true
            
            let label = UILabel()
            label.numberOfLines = 0
            let timeFormatted = formatTime(comment.time)
            label.text = "\(comment.text)\n\(comment.email)\n\(timeFormatted)"
            label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            
            tile.addSubview(label)
            stackView.addArrangedSubview(tile)
            
            // Add constraints for the tile and label
            NSLayoutConstraint.activate([
                tile.heightAnchor.constraint(equalToConstant: 80),
                            tile.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
                            tile.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
                tile.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -20),
                            label.centerYAnchor.constraint(equalTo: tile.centerYAnchor),
                            label.leadingAnchor.constraint(equalTo: tile.leadingAnchor, constant: 15),
                            label.trailingAnchor.constraint(equalTo: tile.trailingAnchor, constant: -15)
            ])
           
                   
        }
        
        // Set constraints for customView to determine the alert size
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50),
            customView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10),
            customView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -10),
            customView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -70),
            customView.heightAnchor.constraint(equalToConstant: 450),
            customView.widthAnchor.constraint(equalToConstant: 320),
            
            scrollView.topAnchor.constraint(equalTo: customView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20)
        ])
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        // Present the alert
        present(alert, animated: true, completion: nil)
    }
   


    func formatTime(_ timestamp: Timestamp) -> String {
        // Format the timestamp as desired, for example:
        let date = timestamp.dateValue()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:MM, MMM dd"
        return formatter.string(from: date)
    }

    
    // MARK: - Fetch Data from Firestore
    private func fetchActivityData() {
        // Ensure the activity ID is available
        guard let activityId = activityID else { return }
        
        // Fetch activity details, users, and tags
        fetchActivityDetails(activityId: activityId)
        fetchUsersForActivity(activityId: activityId)
    }
    private func fetchActivityDetails(activityId: String) {
        db.collection("activities").document(activityId).getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                // Fetch the document data as a dictionary
                if let data = document.data() {
                    let id = data["id"] as? String ?? "Unknown"
                    let name = data["name"] as? String ?? "Unknown"
                    let description = data["description"] as? String ?? "No description"
                    let address = data["address"] as? String ?? "Unknown"
                    let price = data["price"] as? String ?? "Free"
                    let interestTags = data["interest_tags"] as? [String] ?? []
                    let personalityTags = data["personality_tags"] as? [String] ?? []
                    let allTags = interestTags + personalityTags
                    let photoUrlString = data["photo_url"] as? String ?? ""
                    let date = data["date"] as? Timestamp
                    let geopoint = data["location"] as? GeoPoint
                    let latitude = geopoint?.latitude as? Double ?? 0.0
                    let longitude = geopoint?.longitude as? Double ?? 0.0
                    
                    
                    // Configure map view
                                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                    let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                                    
                                    DispatchQueue.main.async {
                                        self?.activityDetailsView.mapView.setRegion(region, animated: true)
                                        
                                        // Add annotation to map
                                        let annotation = MKPointAnnotation()
                                        annotation.coordinate = coordinate
                                        annotation.title = name
                                        self?.activityDetailsView.mapView.addAnnotation(annotation)
                                    }
                    
                    // Populate the view with fetched data
                    self?.activityDetailsView.activityNameLabel.text = name
                    self?.activityDetailsView.activityDescriptionLabel.text = description
                    self?.activityDetailsView.locationLabel.text = address
                    self?.activityDetailsView.priceBubbleLabel.text = price
                    self?.activityDetailsView.configureTags(with: allTags)
        
                    if let photoUrl = URL(string: photoUrlString) {
                        self?.downloadImage(from: photoUrl)
                    }
                    
                    if let date = date {
                        let dayDateFormatter = DateFormatter()
                        dayDateFormatter.dateFormat = "EEEE, MMMM d"
                        self?.activityDetailsView.dayDateLabel.text = dayDateFormatter.string(from: date.dateValue())
                        
                        let dateTimeFormatter = DateFormatter()
                        dateTimeFormatter.dateFormat = "EEEE, MMMM d, h:mm a z"
                        self?.activityDetailsView.dateTimeLabel.text = dateTimeFormatter.string(from: date.dateValue())
                    }
                    
                    // Update UI
                    self?.activityDetailsView.populateData()
                }
            } else {
                print("Error fetching activity details: \(String(describing: error))")
            }
        }
    }
    private func fetchUsersForActivity(activityId: String) {
        db.collection("activities").document(activityId).collection("attendees").getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error getting users: \(error)")
                return
            }
            
            self?.users = querySnapshot?.documents.compactMap { document -> String? in
                if let email = document["email"] as? String {
                    return email
                }
                return nil
            } ?? []
            
            // Update users UI
            self?.activityDetailsView.users = self?.users ?? []
            self?.activityDetailsView.populateData()
        }
    }
    @objc func didTapSeeAll() {
        guard !users.isEmpty else {
            let alert = UIAlertController(title: "No Attendees", message: "There are no attendees to display.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        // Create the alert
        let alert = UIAlertController(title: "Attendees", message: nil, preferredStyle: .alert)
        
        // Define a custom view to contain the scrollable list
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        alert.view.addSubview(customView)
        
        // Create a scroll view and stack view
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview(scrollView)
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        // Add attendee tiles to the stack view
        for attendee in users {
            let tile = UIView()
            tile.backgroundColor = UIColor.lightGray
            tile.layer.cornerRadius = 8
            tile.layer.masksToBounds = true
            let label = UILabel()
            label.text = attendee
            label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            
            tile.addSubview(label)
            stackView.addArrangedSubview(tile)
            NSLayoutConstraint.activate([
                tile.heightAnchor.constraint(equalToConstant: 40),
                label.centerYAnchor.constraint(equalTo: tile.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: tile.leadingAnchor, constant: 8),
                label.trailingAnchor.constraint(equalTo: tile.trailingAnchor, constant: -8)
            ])
        }
        // Set constraints for customView to determine the alert size
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50),
            customView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10),
            customView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -10),
            customView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -70),
            customView.heightAnchor.constraint(equalToConstant: 300),
            customView.widthAnchor.constraint(equalToConstant: 280),
            scrollView.topAnchor.constraint(equalTo: customView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20)
        ])
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        // Present the alert
        present(alert, animated: true, completion: nil)
    }
    
    // Helper method to download image
    private func downloadImage(from url: URL) {
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.activityDetailsView.activityImageView.image = image
                }
            }
        }
        dataTask.resume()
    }
}


