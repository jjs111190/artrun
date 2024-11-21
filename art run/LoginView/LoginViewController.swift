import UIKit
import Firebase

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UITextField {
    func setLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

class LoginViewController: UIViewController {

    // UI elements
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var onLoginSuccess: (() -> Void)? // Success closure
    var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        
        setupUI()
    }

    func setupUI() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        // Background view
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        backgroundView.backgroundColor = .white
        view.addSubview(backgroundView)

        // "Art Run" logo
        let logoLabel = UILabel(frame: CGRect(x: 20, y: 60, width: screenWidth - 40, height: 80))
        logoLabel.textAlignment = .center
        logoLabel.font = UIFont.boldSystemFont(ofSize: 48)
        logoLabel.attributedText = getStyledLogoText()
        view.addSubview(logoLabel)

        // Email text field
        emailTextField = createTextField(placeholder: "Email", y: 200)
        view.addSubview(emailTextField)

        // Password text field
        passwordTextField = createTextField(placeholder: "Password", y: 270)
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)

        // Login button
        let loginButton = UIButton(frame: CGRect(x: 40, y: 370, width: screenWidth - 80, height: 50))
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor(hex: "33CD5F")
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.layer.cornerRadius = 10
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        view.addSubview(loginButton)

        // Sign Up button
        signUpButton = UIButton(frame: CGRect(x: 40, y: 440, width: screenWidth - 80, height: 50))
        signUpButton.setTitle("Don't have an account? Sign up", for: .normal)
        signUpButton.setTitleColor(UIColor(hex: "33CD5F"), for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        signUpButton.addTarget(self, action: #selector(navigateToSignUp), for: .touchUpInside)
        view.addSubview(signUpButton)

        // Social media buttons
        createSocialMediaButtons(yPosition: 510)
    }

    func createTextField(placeholder: String, y: CGFloat) -> UITextField {
        let textField = UITextField(frame: CGRect(x: 40, y: y, width: UIScreen.main.bounds.width - 80, height: 50))
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.setLeftPadding(10) // Add padding
        return textField
    }

    func getStyledLogoText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "Art Run")
        attributedText.addAttribute(.foregroundColor, value: UIColor(hex: "33CD5F"), range: NSRange(location: 0, length: 1))
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 1, length: 3))
        attributedText.addAttribute(.foregroundColor, value: UIColor(hex: "33CD5F"), range: NSRange(location: 4, length: 1))
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 5, length: 2))
        return attributedText
    }

    func createSocialMediaButtons(yPosition: CGFloat) {
        let socialMediaButtons = [
            ("Twitter", "twitter_icon"),
            ("Google", "google_icon"),
            ("Facebook", "facebook_icon")
        ]
        
        var xPosition: CGFloat = 40
        for (title, icon) in socialMediaButtons {
            let button = UIButton(frame: CGRect(x: xPosition, y: yPosition, width: 50, height: 50))
            button.setTitle(title, for: .normal)
            button.setImage(UIImage(named: icon), for: .normal)
            button.layer.cornerRadius = 25
            button.layer.borderColor = UIColor.gray.cgColor
            button.layer.borderWidth = 1
            button.addTarget(self, action: #selector(handleSocialMediaLogin), for: .touchUpInside)
            view.addSubview(button)
            xPosition += 70
        }
    }

    @objc func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.showLoginError(message: error.localizedDescription)
                return
            }
            self?.onLoginSuccess?()
        }
    }

    func showLoginError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc func navigateToSignUp() {
        let signUpVC = SignUpViewController2() // Make sure SignUpViewController2 is the correct view controller for sign up
        navigationController?.pushViewController(signUpVC, animated: true) // Navigate to the SignUp screen
    }

    @objc func handleSocialMediaLogin() {
        // Handle social media login (Twitter, Google, Facebook)
    }
}

class SignUpViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Sign Up"
        
        // Setup Sign Up UI here
        setupUI()
    }
    
    func setupUI() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // Create a label and other UI elements for Sign Up
        let signUpLabel = UILabel(frame: CGRect(x: 20, y: 60, width: screenWidth - 40, height: 80))
        signUpLabel.textAlignment = .center
        signUpLabel.font = UIFont.boldSystemFont(ofSize: 48)
        signUpLabel.text = "Sign Up"
        view.addSubview(signUpLabel)
        
        // Add other text fields and buttons for the user to sign up
    }
}
