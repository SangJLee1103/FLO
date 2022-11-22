//
//  SplashViewController.swift
//  Flo
//
//  Created by 이상준 on 2022/11/20.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    var music: Music?
    var viewModel = MusicViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "ssssss"
        return label
    }()
    
    private let albumLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "ssssss"
        return label
    }()
    
    private let singerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        label.text = "ssssss"
        return label
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    private let lyricsTableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        setupBinders()
    }
    
    func configureUI() {
        view.addSubview(titleLabel)
        titleLabel.centerX(inView: view)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        
        view.addSubview(albumLabel)
        albumLabel.centerX(inView: view)
        albumLabel.anchor(top: titleLabel.bottomAnchor, paddingTop: 3)
        
        view.addSubview(singerLabel)
        singerLabel.centerX(inView: view)
        singerLabel.anchor(top: albumLabel.bottomAnchor, paddingTop: 3)
        
        view.addSubview(imageView)
        imageView.anchor(top: singerLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 7, paddingLeft: 50, paddingRight: 50 , height: view.frame.width - 100)
    }
    
    func configure() {
        self.titleLabel.text = viewModel.title
        self.albumLabel.text = viewModel.album
        self.singerLabel.text = viewModel.singer
        
    }
    
    func setupBinders() {
        viewModel.fetchMusic()
        viewModel.music.bind { music in
            DispatchQueue.main.async {
                self.configure()
            }
        }
    }
}
