//
//  BaseViewController.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/6/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    func configureHierarchy() {}
    
    func configureConstraints() {}
    
    func configureView() {}
}
