//
//  AppDetailViewController.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/7/24.
//

import UIKit
import SnapKit


final class AppDetailViewController: BaseViewController {
    
    var selectedApp: App?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureConstraints() {
        
    }
    
    override func configureView() {
        guard let selectedApp else { return }
        print("선택한 앱 정보: \(selectedApp)")
    }
}
