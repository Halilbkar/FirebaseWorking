//
//  MainViewController.swift
//  FirebaseWorking
//
//  Created by Halil Bakar on 26.07.2023.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    private lazy var allUserUIView: AllUserUIView = {
       let view = AllUserUIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var currentUserUIView: CurrentUserUIView = {
       let view = CurrentUserUIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(currentUserUIView)
        view.addSubview(allUserUIView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
        
            currentUserUIView.topAnchor.constraint(equalTo: view.topAnchor),
            currentUserUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentUserUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentUserUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: view.frame.height/2)),
            
            allUserUIView.topAnchor.constraint(equalTo: currentUserUIView.bottomAnchor),
            allUserUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allUserUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allUserUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
