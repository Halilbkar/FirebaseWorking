//
//  LoginViewController.swift
//  FirebaseWorking
//
//  Created by Halil Bakar on 26.07.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "welcomeLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
        
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Log In"
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Username"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.addLeftPadding(textField: textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Password"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.addLeftPadding(textField: textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.addRightImageButton(image: UIImage(named: "faceID")!, target: self, action: #selector(faceIDTapped))
        
        return textField
    }()
    
    private lazy var oneStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        
        button.configuration = .plain()
        button.configuration?.baseForegroundColor = .black
        button.configuration?.title = "Create Account"
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        
        button.configuration = .filled()
        button.configuration?.cornerStyle = .capsule
        button.configuration?.baseBackgroundColor = .gray
        button.configuration?.baseForegroundColor = .white
        button.configuration?.title = "Log In"
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var googleSıgnInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        
        button.style = .standard
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(googleSıgnInButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "grey100")
        
        view.addSubview(imageView)
        view.addSubview(loginLabel)
        view.addSubview(oneStackView)
        view.addSubview(createAccountButton)
        view.addSubview(loginButton)
        view.addSubview(googleSıgnInButton)
        
        oneStackView.addArrangedSubview(userNameTextField)
        oneStackView.addArrangedSubview(passwordTextField)
        
        viewModel.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
        
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat.dHeight(padding: 88)),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.dWidth(padding: 64)),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat.dWidth(padding: -64)),
            
            loginLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: CGFloat.dHeight(padding: 48)),
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            oneStackView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 12)),
            oneStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.dWidth(padding: 16)),
            oneStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat.dWidth(padding: -16)),
            oneStackView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 100)),
            
            googleSıgnInButton.topAnchor.constraint(equalTo: oneStackView.bottomAnchor, constant: CGFloat.dHeight(padding: 16)),
            googleSıgnInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.dWidth(padding: 16)),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat.dHeight(padding: -48)),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.dWidth(padding: 83)),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat.dWidth(padding: -83)),
            
            createAccountButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: CGFloat.dHeight(padding: -24)),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.dWidth(padding: 83)),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat.dWidth(padding: -83)),
            
        ])
    }
    
    @objc private func loginButtonTapped() {
        guard let username = userNameTextField.text, let password = passwordTextField.text else { return }
        
        viewModel.login(email: username, password: password)

    }
    
    @objc private func createButtonTapped() {
        let view = CreateUserViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    
    @objc private func googleSıgnInButtonTapped() {
        
    }
    
    @objc private func faceIDTapped() {
        
    }
    
}

extension LoginViewController: LoginViewModelDelegate {
    func singIn() {
        let view = MainViewController()
        navigationController?.pushViewController(view, animated: true)
    }
}
