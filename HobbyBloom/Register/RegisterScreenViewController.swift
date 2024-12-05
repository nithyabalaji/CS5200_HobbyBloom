import UIKit
import FirebaseAuth
import FirebaseFirestore
import CoreLocation

class RegisterScreenViewController: UIViewController, CLLocationManagerDelegate {
    
    let registerScreen = RegisterScreenView()
    let locationManager = CLLocationManager()
    let db = Firestore.firestore() // Firestore database reference
    
    override func loadView() {
        view = registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerScreen.takeQuizButton.addTarget(self, action: #selector(onTakeQuizButtonTapped), for: .touchUpInside)

        // Request location access
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Start location updates
        locationManager.startUpdatingLocation()
        // Remove password hiding
           registerScreen.passwordTextField.isSecureTextEntry = false  // Set to false to display password in plain text
    }
    
    @objc func onTakeQuizButtonTapped() {
        if validateFields() {
            registerUser { success, userId in
                DispatchQueue.main.async {
                    if success, let userId = userId {
                        let quizViewController = QuizViewController()
                        quizViewController.userId = userId // Pass the user ID
                        self.navigationController?.pushViewController(quizViewController, animated: true)
                    } else {
                        self.showAlertForDatabaseError()
                    }
                }
            }
        } else {
            showAlertForIncompleteFields()
        }
    }

    
    private func registerUser(completion: @escaping (Bool, String?) -> Void) {
        guard let name = registerScreen.nameTextField.text,
              let email = registerScreen.emailTextField.text,
              let password = registerScreen.passwordTextField.text,
              let city = registerScreen.selectedCity else {
            completion(false, nil)
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                completion(false, nil)
                return
            }

            guard let user = authResult?.user else {
                print("User creation succeeded but user object is nil.")
                completion(false, nil)
                return
            }

            let userData: [String: Any] = [
                "name": name,
                "email": email,
                "city": city,
                "timestamp": Timestamp(date: Date())
            ]

            self.db.collection("users").document(user.uid).setData(userData) { error in
                if let error = error {
                    print("Error saving user data: \(error.localizedDescription)")
                    completion(false, nil)
                } else {
                    print("User data saved successfully!")
                    completion(true, user.uid) // Pass user ID upon successful registration
                }
            }
        }
    }


    // Validate that all required fields are filled, email is valid, and password meets criteria
    private func validateFields() -> Bool {
        guard let name = registerScreen.nameTextField.text, !name.isEmpty,
              let email = registerScreen.emailTextField.text, !email.isEmpty, isValidEmail(email),
              let password = registerScreen.passwordTextField.text, !password.isEmpty, isValidPassword(password),
              let city = registerScreen.selectedCity, !city.isEmpty, city != "Select a city" else {            return false
        }
        return true
    }

    // Check if the email is valid using a regular expression
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // Validate password (e.g., minimum 6 characters)
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }

    // Show alert for incomplete fields
    private func showAlertForIncompleteFields() {
        let alertMessage: String
        
        if let email = registerScreen.emailTextField.text, !isValidEmail(email) {
            alertMessage = "Please enter a valid email address."
        } else if let password = registerScreen.passwordTextField.text, !isValidPassword(password) {
            alertMessage = "Password must be at least 6 characters long."
        } else if registerScreen.selectedCity == "Select a city" {
            alertMessage = "Please select a city."
        } else {
            alertMessage = "Please fill all required fields before proceeding."
        }
        
        let alert = UIAlertController(title: "Form Error",
                                      message: alertMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    
    // Show alert for database error
    private func showAlertForDatabaseError() {
        let alert = UIAlertController(title: "Database Error",
                                      message: "This Email ID has already been used to register.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func updateCityPicker(with location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first, let city = placemark.locality {
                DispatchQueue.main.async {
                    self.setCityInPicker(to: city)
                }
            } else if let error = error {
                print("Failed to reverse geocode location: \(error.localizedDescription)")
            }
        }
    }
    
    func setCityInPicker(to city: String) {
        if let index = registerScreen.cities.firstIndex(of: city) {
            registerScreen.cityPickerView.selectRow(index, inComponent: 0, animated: true)
            registerScreen.selectedCity = city
        } else {
            print("City '\(city)' not in predefined list.")
        }
    }
}
