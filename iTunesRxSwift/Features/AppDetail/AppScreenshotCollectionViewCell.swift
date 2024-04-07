//
//  AppScreenshotCollectionViewCell.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/8/24.
//

import UIKit

final class AppScreenshotCollectionViewCell: UICollectionViewCell {
    
    static let reusableIdentifier = "AppScreenshotCollectionViewCell"
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureConstraints()
        configureCell()
    }
    
    private func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    private func configureCell() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
