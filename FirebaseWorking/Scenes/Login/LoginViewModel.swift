//
//  LoginViewModel.swift
//  FirebaseWorking
//
//  Created by Halil Bakar on 26.07.2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

protocol LoginViewModelDelegate: AnyObject {
    func singIn()
}

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
}

extension LoginViewModel {
    func login(email: String, password: String) {
        AuthManager.shared.login(email: email, password: password) { result in
            switch result {
            case .success:
                // Kullanıcı kaydı başarılı, gerekli işlemleri yapabilirsiniz
                print("Kullanıcı kaydı başarılı.")
                self.delegate?.singIn()
            case .failure(let error):
                // Kayıt işlemi başarısız, hata ile ilgili işlemleri yapabilirsiniz
                print("Kullanıcı kaydı başarısız: \(error)")
            }
        }
    }
}



