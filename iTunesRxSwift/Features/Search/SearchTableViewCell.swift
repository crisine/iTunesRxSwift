//
//  SearchTableViewCell.swift
//  SeSACRxThreads
//
//  Created by jack on 2024/04/01.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    var disposeBag = DisposeBag()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemMint
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 16
        return button
    }()
    
    private let infoStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        return view
    }()
    
    private let scoreView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private let scoreImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .systemGray
        return view
    }()
    
    let scoreLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    let artistNameLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    let genreLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 13)
        view.textAlignment = .right
        return view
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        configure()
    }
     
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // MARK: 새 disposeBag() 으로 교체하면서 하나의 셀에 중첩되지 않도록 하여, 셀의 재활용 해결
        disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        [appNameLabel, appIconImageView, downloadButton, infoStackView].forEach {
            contentView.addSubview($0)
        }
        
        [scoreImageView, scoreLabel].forEach {
            scoreView.addSubview($0)
        }
        
        [scoreView, artistNameLabel, genreLabel].forEach {
            infoStackView.addArrangedSubview($0)
        }
        
        appIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(20)
            $0.size.equalTo(60)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(-8)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalTo(appIconImageView)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(32)
            $0.width.equalTo(72)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.height.equalTo(20)
        }
        
        scoreImageView.snp.makeConstraints { make in
            make.centerY.equalTo(scoreView.safeAreaLayoutGuide)
            make.leading.equalTo(scoreView.snp.leading).offset(4)
            make.size.equalTo(16)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(scoreView.safeAreaLayoutGuide)
            make.leading.equalTo(scoreImageView.snp.trailing).offset(4)
            make.trailing.equalTo(scoreView.safeAreaLayoutGuide).inset(4)
            make.verticalEdges.equalTo(scoreView.safeAreaLayoutGuide).inset(4)
        }
        
//        scoreView.snp.makeConstraints { make in
//            make.height.equalTo(infoStackView)
//        }
//        
//        sellerNameLabel.snp.makeConstraints { make in
//            make.height.equalTo(infoStackView)
//        }
//        
//        genreLabel.snp.makeConstraints { make in
//            make.height.equalTo(infoStackView)
//        }
    }
}

