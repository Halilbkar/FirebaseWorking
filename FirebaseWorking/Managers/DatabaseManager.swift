//
//  DatabaseManager.swift
//  FirebaseWorking
//
//  Created by Halil Bakar on 26.07.2023.
//

import Foundation
import FirebaseDatabase

enum DatabaseError: Error {
    case getUserInfoError
}

final class DatabaseManager {
    static let shared = DatabaseManager()
    internal let databaseRef = Database.database().reference()
    private init() {}
}

extension DatabaseManager {
    func saveUserInfo(uid: String, email: String, firstName: String, lastName: String, profileImageURL: String?, completion: @escaping (Error?) -> Void) {
        let userData = [
            "email": email,
            "firstName": firstName,
            "lastName": lastName,
            "profileImageURL": profileImageURL
        ]
        
        databaseRef.child("users").child(uid).setValue(userData) { (error, _) in
            completion(error)
        }
    }
    
    func getUserInformation(uid: String, completion: @escaping (Result<UserInformation?, DatabaseError>) -> Void) {
        databaseRef.child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                if let userInfoDict = snapshot.value as? [String: Any],
                   let email = userInfoDict["email"] as? String,
                   let firstName = userInfoDict["firstName"] as? String,
                   let lastName = userInfoDict["lastName"] as? String,
                   let profileImageURL = userInfoDict["profileImageURL"] as? String {
                    let userInfo = UserInformation(uid: uid, firstName: firstName, lastName: lastName, email: email, profileImageURL: profileImageURL)
                    completion(.success(userInfo))
                } else {
                    completion(.failure(.getUserInfoError))
                }
            } else {
                completion(.failure(.getUserInfoError))
            }
        }
    }
    
    func getUserInformationForAllUsers(completion: @escaping (Result<[UserInformation], DatabaseError>) -> Void) {
        databaseRef.child("users").observeSingleEvent(of: .value) { snapshot in
            var users: [UserInformation] = []
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let userInfoDict = childSnapshot.value as? [String: Any],
                   let uid = childSnapshot.key as? String,
                   let email = userInfoDict["email"] as? String,
                   let firstName = userInfoDict["firstName"] as? String,
                   let lastName = userInfoDict["lastName"] as? String,
                   let profileImageURL = userInfoDict["profileImageURL"] as? String {
                    let userInfo = UserInformation(uid: uid, firstName: firstName, lastName: lastName, email: email, profileImageURL: profileImageURL)
                    users.append(userInfo)
                }
            }
            completion(.success(users))
        }
    }
}

