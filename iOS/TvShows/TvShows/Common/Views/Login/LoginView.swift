import RxSwift
import UIKit

class LoginView: CustomView {

    var backgroundImageView: UIImageView!
    var titleImageView: UIImageView!
    var stackView: UIStackView!
    var loginLabel: UILabel!
    var loginDescriptionLabel: UILabel!
    var emailTextField: UITextField!
    var emailDivider: Divider!
    var passwordTextField: UITextField!
    var revealPasswordButton: UIButton!
    var passwordDivider: Divider!
    var loginButton: BaseButton!
    var registerButton: BaseButton!

    convenience init() {
        self.init(frame: .zero)

        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func setupLayout() {
        backgroundImageView = UIImageView()
        addSubview(backgroundImageView)

        titleImageView = UIImageView()
        addSubview(titleImageView)

        stackView = UIStackView()
        addSubview(stackView)

        loginLabel = UILabel()
        stackView.addArrangedSubview(loginLabel)

        loginDescriptionLabel = UILabel()
        stackView.addArrangedSubview(loginDescriptionLabel)

        emailTextField = InsetedTextField(insets: .insets(left: 12, right: 12))
        stackView.addArrangedSubview(emailTextField)

        emailDivider = Divider()
        stackView.addArrangedSubview(emailDivider)

        revealPasswordButton = UIButton()

        passwordTextField = InsetedTextField(insets: .insets(left: 12, right: 12))
        stackView.addArrangedSubview(passwordTextField)

        passwordDivider = Divider()
        stackView.addArrangedSubview(passwordDivider)

        loginButton = BaseButton()
        stackView.addArrangedSubview(loginButton)

        registerButton = BaseButton()
        stackView.addArrangedSubview(registerButton)
    }

    override func styleViews() {
        backgroundImageView.image = UIImage(with: .backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill

        titleImageView.image = UIImage(with: .tvShowsLogo)
        titleImageView.contentMode = .scaleAspectFill

        stackView.axis = .vertical
        stackView.setDefaultMargins()
        stackView.spacing = 15
        stackView.setCustomSpacing(20, after: loginLabel)
        stackView.setCustomSpacing(45, after: loginDescriptionLabel)
        stackView.setCustomSpacing(25, after: emailDivider)
        stackView.setCustomSpacing(30, after: passwordDivider)

        loginLabel.text = "Login"
        loginLabel.textColor = .white
        loginLabel.font = .systemFont(ofSize: 34, weight: .bold)

        loginDescriptionLabel.text = "In order to continue please log in."
        loginDescriptionLabel.textColor = .white
        loginDescriptionLabel.font = .systemFont(ofSize: 17, weight: .regular)

        emailTextField.placeholder = "Email"
        emailTextField.textColor = .white
        emailTextField.font = .systemFont(ofSize: 17, weight: .regular)
        emailTextField.returnKeyType = .done

        revealPasswordButton.setImage(UIImage(with: .passwordInvisible), for: .normal)

        passwordTextField.placeholder = "Password"
        passwordTextField.textColor = .white
        passwordTextField.font = .systemFont(ofSize: 17, weight: .regular)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightView = revealPasswordButton
        passwordTextField.rightViewMode = .always
        passwordTextField.returnKeyType = .done

        loginButton.backgroundColor = .white
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.backgroundViolet, for: .normal)
        loginButton.roundCorners(corners: .allCorners, radius: 24)

        registerButton.backgroundColor = .clear
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.roundCorners(corners: .allCorners, radius: 24)
    }

    override func setupConstraints() {
        backgroundImageView.pinToSuperview()

        titleImageView.pinTo(top: topAnchor, insets: .insets(top: 120))
        titleImageView.centerTo(centerX: centerXAnchor)

        stackView.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 30).isActive = true
        stackView.pinTo(left: leftAnchor, right: rightAnchor)

        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true

        registerButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

}

extension LoginView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }

}
