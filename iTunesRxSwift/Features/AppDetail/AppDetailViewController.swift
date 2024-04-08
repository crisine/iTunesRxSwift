//
//  AppDetailViewController.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/7/24.
//

import UIKit
import SnapKit


final class AppDetailViewController: BaseViewController {
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        return view
    }()
    let contentView = UIView()
    
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
    let releaseNotesLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 0
        return view
    }()
    
    // MARK: Bottom Section (Screenshots, Descriptions)
    lazy var screenshotCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.register(AppScreenshotCollectionViewCell.self, forCellWithReuseIdentifier: AppScreenshotCollectionViewCell.reusableIdentifier)
        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        return view
    }()
    let descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.numberOfLines = 0
        return view
    }()
    
    var selectedApp: App?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [iconImageView, nameLabel, artistLabel, downloadButton,
        releaseNotesTitleLabel, versionLabel, releaseNotesLabel,
        screenshotCollectionView, descriptionLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.top)
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
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
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseNotesTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(releaseNotesTitleLabel.snp.leading)
            make.trailing.equalTo(releaseNotesTitleLabel.snp.trailing)
            make.height.equalTo(14)
        }
        
        releaseNotesLabel.snp.makeConstraints { make in
            make.top.equalTo(versionLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
        screenshotCollectionView.snp.makeConstraints { make in
            make.top.equalTo(releaseNotesLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(380)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(screenshotCollectionView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    override func configureView() {
        guard let selectedApp else { return }
        // print("선택한 앱 정보: \(selectedApp)")
        
        iconImageView.kf.setImage(with: URL(string: selectedApp.artworkUrl512))
        nameLabel.text = selectedApp.trackCensoredName
        artistLabel.text = selectedApp.artistName
        versionLabel.text = selectedApp.version
        releaseNotesLabel.text = selectedApp.releaseNotes
        descriptionLabel.text = selectedApp.description
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension AppDetailViewController {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }
}

extension AppDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let selectedApp else { return 0 }
        return selectedApp.screenshotUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppScreenshotCollectionViewCell.reusableIdentifier, for: indexPath) as! AppScreenshotCollectionViewCell
        
        guard let selectedApp else { return cell }
        
        cell.imageView.kf.setImage(with: URL(string: selectedApp.screenshotUrls[indexPath.row])) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let value):
                self.screenshotCollectionView.snp.remakeConstraints { make in
                    // MARK: 이 방법으로는 셀이 설정될때마다 크기를 재설정하게 됨
                    print("remaking heights..")
                    make.top.equalTo(self.releaseNotesLabel.snp.bottom).offset(16)
                    make.horizontalEdges.equalTo(self.contentView.safeAreaLayoutGuide).inset(16)
                    make.height.equalTo(value.image.size.height)
                }
            case .failure(let error):
                dump(error)
            }
        }
        
        return cell
    }
}
