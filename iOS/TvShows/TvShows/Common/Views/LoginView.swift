import UIKit

class LoginView: CustomView {

    var backgroundImageView: UIImageView!
    var titleImageView: UIImageView!
    var loginLabel: UILabel!
    var loginDescriptionLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!

    override func setupLayout() {
        backgroundImageView = UIImageView()
        addSubview(backgroundImageView)

        titleImageView = UIImageView()
        addSubview(titleImageView)

        loginLabel = UILabel()
        addSubview(loginLabel)

        loginDescriptionLabel = UILabel()
        addSubview(loginDescriptionLabel)

        emailTextField = UITextField()
        addSubview(emailTextField)

        passwordTextField = UITextField()
        addSubview(passwordTextField)
    }

    override func styleViews() {
        backgroundImageView.image = UIImage(with: .backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill

        titleImageView.image = UIImage(with: .tvShowsLogo)
        titleImageView.contentMode = .scaleAspectFill

        loginLabel.text = "Login"
        loginLabel.textColor = .white
        loginLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)

        loginDescriptionLabel.text = "In order to continue please log in."
        loginDescriptionLabel.textColor = .white
        loginDescriptionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }

    override func setupConstraints() {
        backgroundImageView.pinToSuperview()

        titleImageView.pinTo(top: topAnchor, insets: .insets(top: 120))
        titleImageView.centerTo(centerX: centerXAnchor)

        loginLabel.pinTo(left: leftAnchor, right: rightAnchor, insets: .insets(left: 20, right: -20))
        loginLabel.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 30).isActive = true

        loginDescriptionLabel.pinTo(left: leftAnchor, right: rightAnchor, insets: .insets(left: 20, right: -20))
        loginDescriptionLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20).isActive = true
    }

}
