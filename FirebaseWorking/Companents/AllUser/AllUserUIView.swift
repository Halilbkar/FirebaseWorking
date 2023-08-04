//
//  AllUserUIView.swift
//  FirebaseWorking
//
//  Created by Halil Bakar on 26.07.2023.
//

import UIKit
import FirebaseDatabase

class AllUserUIView: UIView {
    
    private lazy var recipientsPinnedLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Pinned"
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 20))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var recipientsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 102, height: 102)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AllUserCollectionViewCell.self, forCellWithReuseIdentifier: AllUserCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    var allUsers: [UserInformation] = []
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .blue
        
        addSubview(recipientsPinnedLabel)
        addSubview(recipientsCollectionView)
        
        test()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            recipientsPinnedLabel.topAnchor.constraint(equalTo: topAnchor),
            recipientsPinnedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 16)),
            recipientsPinnedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -16)),
            recipientsPinnedLabel.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 25)),
            
            recipientsCollectionView.topAnchor.constraint(equalTo: recipientsPinnedLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 8)),
            recipientsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipientsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipientsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func test() {
        DatabaseManager.shared.getUserInformationForAllUsers { result in
            switch result {
            case .success(let users):
                self.allUsers = users
                self.recipientsCollectionView.reloadData()
                
                print("Tüm kullanıcılar: \(users)")
                
            case .failure(let error):
                print("Tüm kullanıcılar çekilirken hata oluştu: \(error)")
            }
        }
    }
}

extension AllUserUIView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllUserCollectionViewCell.identifier, for: indexPath) as! AllUserCollectionViewCell
        
        let user = allUsers[indexPath.row]
        
        cell.config(user: user)
        
        return cell
    }
}

