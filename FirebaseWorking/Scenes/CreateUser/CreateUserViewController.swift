//
//  CreateUserViewController.swift
//  FirebaseWorking
//
//  Created by Halil Bakar on 26.07.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class CreateUserViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "welcomeLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
        
    }()
    
    private lazy var createUserLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Create User"
        label.textColor = .systemGray4
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
        return imageView
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
    
    private lazy var passTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Password"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.addLeftPadding(textField: textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var tryPassTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Try Password"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.addLeftPadding(textField: textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Your Name"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.addLeftPadding(textField: textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var surnameTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Your Surname"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.addLeftPadding(textField: textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        button.configuration = .filled()
        button.configuration?.cornerStyle = .capsule
        button.configuration?.baseBackgroundColor = .gray
        button.configuration?.baseForegroundColor = .white
        button.configuration?.title = "Create Account"
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var viewModel = CreateUserViewModel()
    
    private var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "grey100")
        
        view.addSubview(imageView)
        view.addSubview(createUserLabel)
        view.addSubview(profileImageView)
        view.addSubview(oneStackView)
        view.addSubview(createAccountButton)
        
        oneStackView.addArrangedSubview(userNameTextField)
        oneStackView.addArrangedSubview(passTextField)
        oneStackView.addArrangedSubview(nameTextField)
        oneStackView.addArrangedSubview(surnameTextField)
        
        viewModel.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat.dHeight(padding: 88)),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.dWidth(padding: 64)),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat.dWidth(padding: -64)),
            
            createUserLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: CGFloat.dHeight(padding: 12)),
            createUserLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: createUserLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 24)),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 100)),
            profileImageView.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 100)),
            
            oneStackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: CGFloat.dHeight(padding: 20)),
            oneStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.dWidth(padding: 16)),
            oneStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat.dWidth(padding: -16)),
            oneStackView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 200)),
            
            createAccountButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat.dHeight(padding: -48)),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.dWidth(padding: 83)),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CGFloat.dWidth(padding: -83)),
        ])
    }
    
    @objc private func createButtonTapped() {
        guard let username = userNameTextField.text,
              let password = passTextField.text,
              let name = nameTextField.text,
              let surname = surnameTextField.text,
              let selectedImage = profileImageView.image else { return }
        
        viewModel.signUp(email: username, password: password, firstName: name, lastName: surname, profileImage: selectedImage)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func imageViewTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension CreateUserViewController: CreateUserViewModelDelegate {
    func toLogin() {
        navigationController?.popViewController(animated: true)
    }
}

extension CreateUserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
