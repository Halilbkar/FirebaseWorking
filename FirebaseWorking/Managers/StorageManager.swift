//
//  StorageManager.swift
//  FirebaseWorking
//
//  Created by Halil Bakar on 26.07.2023.
//

import Foundation
import UIKit
import FirebaseStorage

enum StorageError: Error {
    case imageUploadError
    case imageDownloadError
}

final class StorageManager {
    static let shared = StorageManager()
    private let storage = Storage.storage()
    private let storageRef = Storage.storage().reference()
    private init() {}
}

extension StorageManager {
    func uploadProfileImage(_ image: UIImage, withUID uid: String, completion: @escaping (Result<String?, StorageError>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(.imageUploadError))
            return
        }

        let profileImageRef = storageRef.child("profile_images").child("\(uid).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        profileImageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                debugPrint(error)
                completion(.failure(.imageUploadError))
            } else {
                profileImageRef.downloadURL { (url, error) in
                    if let error = error {
                        debugPrint(error)
                        completion(.failure(.imageUploadError))
                    } else {
                        completion(.success(url?.absoluteString))
                    }
                }
            }
        }
    }

    func downloadProfileImage(withURL urlString: String, completion: @escaping (Result<UIImage?, StorageError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.imageDownloadError))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                debugPrint(error)
                completion(.failure(.imageDownloadError))
            } else {
                if let data = data, let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(.imageDownloadError))
                }
            }
        }.resume()
    }
}
