//
//  AppDetailViewController.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/7/24.
//

import UIKit
import SnapKit


final class AppDetailViewController: BaseViewController {
    
    // MARK: Top Section
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 32
        return view
    }()
    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    let artistLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textColor = .gray
        return view
    }()
    let downloadButton: UIButton = {
        let view = UIButton(configuration: .filled())
        view.tintColor = .systemBlue
        view.setTitle("받기", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 18)
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    // MARK: Middle Section
    let releaseNotesTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 22)
        view.text = "새로운 소식"
        return view
    }()
    let versionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    let releaseNotesLabel: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 14)
        view.isEditable = false
        view.isSelectable = false
        return view
    }()
    
    // MARK: Bottom Section (Screenshots, Descriptions)
    
    
    var selectedApp: App?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        [iconImageView, nameLabel, artistLabel, downloadButton,
        releaseNotesTitleLabel, versionLabel, releaseNotesLabel].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.top)
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalTo(nameLabel.snp.trailing)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.bottom.equalTo(iconImageView.snp.bottom)
            make.leading.equalTo(nameLabel.snp.leading)
            make.width.equalTo(72)
            make.height.equalTo(32)
        }
        
        releaseNotesTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(16)
            make.leading.equalTo(iconImageView.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseNotesTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(releaseNotesTitleLabel.snp.leading)
            make.trailing.equalTo(releaseNotesTitleLabel.snp.trailing)
        }
        
        releaseNotesLabel.snp.makeConstraints { make in
            make.top.equalTo(versionLabel.snp.bottom).offset(8)
            make.leading.equalTo(releaseNotesTitleLabel.snp.leading)
            make.trailing.equalTo(releaseNotesTitleLabel.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    override func configureView() {
        guard let selectedApp else { return }
        print("선택한 앱 정보: \(selectedApp)")
        
        iconImageView.kf.setImage(with: URL(string: selectedApp.artworkUrl512))
        nameLabel.text = selectedApp.trackCensoredName
        artistLabel.text = selectedApp.artistName
        versionLabel.text = selectedApp.version
        releaseNotesLabel.text = selectedApp.releaseNotes
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
}
