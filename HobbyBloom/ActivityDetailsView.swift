//
//  ActivityDetailsView.swift
//  HobbyBloom
//
//  Created by Nishy Ann Tomy on 11/22/24.
//
import UIKit
import MapKit
struct Activity {
       var id: String
       var name: String
       var imageName: String
       var dayOfWeek: String
       var date: String
       var time: String
       var location: String
       var latitude: Double
       var longitude: Double
       var price: Double
       var interestTags: [String]
       var personalityTags: [String]
   }
   
class ActivityDetailsView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    var activityImageView: UIImageView!
    var dayDateLabel: UILabel!
    var priceBubbleLabel: UILabel!
    var activityNameLabel: UILabel!
    var activityDescriptionLabel: UILabel!
    var dateTimeSectionLabel: UILabel!
    var dateTimeLabel: UILabel!
    var locationSectionLabel: UILabel!
    var locationLabel: UILabel!
    var mapView: MKMapView!
    var whoIsGoingSectionLabel: UILabel!
    var usersStackView: UIStackView!
    var seeAllButton: UIButton!
    var tagsSectionLabel: UILabel!
    var tagsCollectionView: UICollectionView!
    
    var activity: Activity?
    var users: [String] = []
    var tags: [String] = []
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        setupUI()
        layoutUI()
    }
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        // MARK: - UI Setup
        func setupUI() {
            setupScrollView()
            setupActivityImageView()
            setupDayDateLabel()
            setupPriceBubbleLabel()
            setupActivityNameLabel()
            setupActivityDescriptionLabel()
            setupDateTimeSectionLabel()
            setupDateTimeLabel()
            setupLocationSectionLabel()
            setupLocationLabel()
            setupMapView()
            setupWhoIsGoingSectionLabel()
            setupUsersStackView()
            setupSeeAllButton()
            setupTagsSectionLabel()
        }
        
        func setupScrollView() {
            scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(scrollView)
            
            contentView = UIView()
            contentView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(contentView)
        }
        func setupActivityImageView() {
            activityImageView = UIImageView()
            activityImageView.contentMode = .scaleAspectFill
            activityImageView.clipsToBounds = true
            activityImageView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(activityImageView)
        }
        func setupDayDateLabel() {
            dayDateLabel = UILabel()
            dayDateLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            dayDateLabel.textColor = .darkGray
            dayDateLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(dayDateLabel)
        }
        func setupPriceBubbleLabel() {
            priceBubbleLabel = PaddedLabel()
            priceBubbleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            priceBubbleLabel.textColor = .white
            priceBubbleLabel.backgroundColor = .systemBlue
            priceBubbleLabel.layer.cornerRadius = 8
            priceBubbleLabel.clipsToBounds = true
            priceBubbleLabel.textAlignment = .center
            priceBubbleLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(priceBubbleLabel)
        }
        func setupActivityNameLabel() {
            activityNameLabel = UILabel()
            activityNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            activityNameLabel.textColor = .black
            activityNameLabel.numberOfLines = 0
            activityNameLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(activityNameLabel)
        }
        func setupActivityDescriptionLabel() {
            activityDescriptionLabel = UILabel()
            activityDescriptionLabel.font = UIFont.systemFont(ofSize: 18)
            activityDescriptionLabel.textColor = .black
            activityDescriptionLabel.numberOfLines = 0
            activityDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(activityDescriptionLabel)
        }
        func setupDateTimeSectionLabel() {
            dateTimeSectionLabel = UILabel()
            dateTimeSectionLabel.text = "Date and Time"
            dateTimeSectionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            dateTimeSectionLabel.textColor = .black
            dateTimeSectionLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(dateTimeSectionLabel)
        }
        func setupDateTimeLabel() {
            dateTimeLabel = UILabel()
            dateTimeLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            dateTimeLabel.textColor = .darkGray
            dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(dateTimeLabel)
        }
        func setupLocationSectionLabel() {
            locationSectionLabel = UILabel()
            locationSectionLabel.text = "Location"
            locationSectionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            locationSectionLabel.textColor = .black
            locationSectionLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(locationSectionLabel)
        }
        func setupLocationLabel() {
            locationLabel = UILabel()
            locationLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            locationLabel.textColor = .darkGray
            locationLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(locationLabel)
        }
        func setupMapView() {
            mapView = MKMapView()
            mapView.layer.cornerRadius = 8
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true
            mapView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(mapView)
        }
        func setupWhoIsGoingSectionLabel() {
            whoIsGoingSectionLabel = UILabel()
            whoIsGoingSectionLabel.text = "Who's Going?"
            whoIsGoingSectionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            whoIsGoingSectionLabel.textColor = .black
            whoIsGoingSectionLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(whoIsGoingSectionLabel)
        }
        func setupUsersStackView() {
            usersStackView = UIStackView()
            usersStackView.axis = .horizontal
            usersStackView.spacing = 8
            usersStackView.alignment = .center
            usersStackView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(usersStackView)
        }
        func setupSeeAllButton() {
            seeAllButton = UIButton(type: .system)
            seeAllButton.setTitle("See All", for: .normal)
            seeAllButton.setTitleColor(.systemBlue, for: .normal)
            seeAllButton.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(seeAllButton)
        }
        func setupTagsSectionLabel() {
            tagsSectionLabel = UILabel()
            tagsSectionLabel.text = "Tags"
            tagsSectionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            tagsSectionLabel.textColor = .black
            tagsSectionLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(tagsSectionLabel)
            tagsCollectionView = createTagCollectionView()
            contentView.addSubview(tagsCollectionView)
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
        // MARK: - Layout
        func layoutUI() {
            NSLayoutConstraint.activate([
                // ScrollView
                scrollView.topAnchor.constraint(equalTo: self.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                // Content View
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                
                // Activity Image View
                activityImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                activityImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                activityImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                activityImageView.heightAnchor.constraint(equalToConstant: 250),
                
                // Day and Date Label
                dayDateLabel.topAnchor.constraint(equalTo: activityImageView.bottomAnchor, constant: 8),
                dayDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                dayDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                            
                // Price Bubble Label
                priceBubbleLabel.topAnchor.constraint(equalTo: activityImageView.bottomAnchor, constant: 8),
                priceBubbleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                // Activity Name Label
                activityNameLabel.topAnchor.constraint(equalTo: priceBubbleLabel.bottomAnchor, constant: 8),
                activityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                activityNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                // Activity Description Label
                activityDescriptionLabel.topAnchor.constraint(equalTo: activityNameLabel.bottomAnchor, constant: 4),
                activityDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                activityDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                // Date Time Section Label
                dateTimeSectionLabel.topAnchor.constraint(equalTo: activityDescriptionLabel.bottomAnchor, constant: 20),
                dateTimeSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                
                // Date Time Label
                dateTimeLabel.topAnchor.constraint(equalTo: dateTimeSectionLabel.bottomAnchor, constant: 8),
                dateTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                
                // Location Section Label
                locationSectionLabel.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: 20),
                locationSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                
                // Location Label
                locationLabel.topAnchor.constraint(equalTo: locationSectionLabel.bottomAnchor, constant: 8),
                locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                
                // Map View
                mapView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
                mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                mapView.heightAnchor.constraint(equalToConstant: 250),
                
                // Who's Going Section Label
                whoIsGoingSectionLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20),
                whoIsGoingSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                
                // Users Stack View
                usersStackView.topAnchor.constraint(equalTo: whoIsGoingSectionLabel.bottomAnchor, constant: 8),
                usersStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                
                // See All Button
                seeAllButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10),
                seeAllButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                // Tags Section Label
                tagsSectionLabel.topAnchor.constraint(equalTo: seeAllButton.bottomAnchor, constant: 20),
                tagsSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                
                // Tags Collection View
                tagsCollectionView.topAnchor.constraint(equalTo: tagsSectionLabel.bottomAnchor, constant: 8),
                tagsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                tagsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                tagsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                tagsCollectionView.heightAnchor.constraint(equalToConstant: 200)
            ])
        }
        
        // MARK: - Populate Data
                func populateData() {
                    guard let activity = activity else { return }
                    activityImageView.image = UIImage(named: activity.imageName)
                    dayDateLabel.text = "\(activity.dayOfWeek), \(activity.date)"
                    priceBubbleLabel.text = "$\(activity.price)"
                    activityNameLabel.text = activity.name
                    dateTimeLabel.text = "\(activity.date) at \(activity.time)"
                    locationLabel.text = activity.location
                    let coordinate = CLLocationCoordinate2D(latitude: activity.latitude, longitude: activity.longitude)
                    let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                    mapView.setRegion(region, animated: true)
                    
                    updateUsersStackView()
                }
        
        @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return tags.count
            }
            @objc(collectionView:cellForItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
                cell.configure(tag: tags[indexPath.row])
                return cell
            }
            
            func configureTags(with tags: [String]) {
                self.tags = tags
                tagsCollectionView.reloadData()
            }
            
                
                private func updateUsersStackView() {
                    usersStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
                    
                    for user in users.prefix(5) {
                        let userLabel = UILabel()
                        userLabel.text = user
                        userLabel.font = UIFont.systemFont(ofSize: 14)
                        userLabel.textColor = .systemBlue
                        usersStackView.addArrangedSubview(userLabel)
                    }
                }
        
            
    }
class PaddedLabel: UILabel {
    var textInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8) // Customize padding
    
    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: textInsets)
        super.drawText(in: insetRect)
    }
    
    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(
            width: originalSize.width + textInsets.left + textInsets.right,
            height: originalSize.height + textInsets.top + textInsets.bottom
        )
    }
}
