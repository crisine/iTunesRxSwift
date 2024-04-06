//
//  TodayViewController.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/6/24.
//

import UIKit
import SnapKit

final class TodayViewController: BaseViewController {
    
    let tempLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 32)
        view.textAlignment = .center
        view.text = "TodayVC"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(tempLabel)
    }
    
    override func configureConstraints() {
        tempLabel.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(36)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        
    }
}
