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
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 30)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let albumLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private lazy var lyricsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.sizeToFit()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.textAlignment = .center
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(moveLyricsVC))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }()
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal)
        slider.minimumTrackTintColor = #colorLiteral(red: 0.1411764706, green: 0.01176470611, blue: 0.8360022396, alpha: 1)
        slider.addTarget(self, action: #selector(moveSlider), for: .touchUpInside)
        return slider
    }()
    
    private let currentTimeLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.sizeToFit()
        return label
    }()
    
    private let durationLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.sizeToFit()
        label.textAlignment = .right
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.addTarget(self, action: #selector(playMusic), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.playMusic()
        configureUI()
        setupBinders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver()
        let image = viewModel.isPlay ? UIImage(systemName: "pause.fill", withConfiguration: imageConfig) : UIImage(systemName: "play.fill", withConfiguration: imageConfig)
        playButton.setImage(image, for: .normal)
    }
    
    func configureUI() {
        view.addSubview(titleLabel)
        titleLabel.centerX(inView: view)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        
        view.addSubview(albumLabel)
        albumLabel.centerX(inView: view)
        albumLabel.anchor(top: titleLabel.bottomAnchor, paddingTop: 3)
        
        view.addSubview(artistLabel)
        artistLabel.centerX(inView: view)
        artistLabel.anchor(top: albumLabel.bottomAnchor, paddingTop: 3)
        
        view.addSubview(imageView)
        imageView.anchor(top: artistLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 50, paddingRight: 50 , height: view.frame.width - 100)
        
        view.addSubview(lyricsLabel)
        lyricsLabel.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 50, paddingRight: 50, height: 40)
        
        view.addSubview(slider)
        slider.anchor(top: lyricsLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingRight: 20)
        
        
        let timeLblStack = UIStackView(arrangedSubviews: [currentTimeLbl, durationLbl])
        timeLblStack.distribution = .fillEqually
        
        view.addSubview(timeLblStack)
        timeLblStack.anchor(top: slider.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(playButton)
        playButton.centerX(inView: view)
        playButton.anchor(top: timeLblStack.bottomAnchor, paddingTop: 30)
        
    }
    
    func configure() {
        titleLabel.text = viewModel.title
        albumLabel.text = viewModel.album
        artistLabel.text = viewModel.singer
        imageView.image = viewModel.image
        currentTimeLbl.text = "00:00"
        slider.maximumValue = Float(viewModel.duration)
        durationLbl.text = viewModel.getTime(time: Double(viewModel.duration))
    }
}

// MARK: - 뷰 터치 이벤트에 대한 확장
extension PlayViewController {
    // 전체 가사 보기 화면 이동
    @objc func moveLyricsVC(_ gesture: UITapGestureRecognizer) {
        let lyricsVC = LyricsViewController()
        lyricsVC.modalPresentationStyle = .fullScreen
        lyricsVC.viewModel = viewModel
        lyricsVC.musicTitle = titleLabel.text
        lyricsVC.artist = artistLabel.text
        lyricsVC.imageConfig = imageConfig
        self.present(lyricsVC, animated: true)
    }
    
    // UISlider
    @objc func moveSlider(_ sender: UISlider) {
        let seconds = Double(sender.value)
        currentTimeLbl.text = viewModel.currentTimeText
        
        if sender.isTracking {
            return
        } else {
            viewModel.player.seek(to: CMTime(seconds: seconds, preferredTimescale: 100))
        }
    }
    
    // 음악 재생 버튼 클릭시 이벤트
    @objc func playMusic(_ sender: UIButton) {
        if viewModel.isPlay {
            let playUI = UIImage(systemName: "play.fill", withConfiguration: imageConfig)
            sender.setImage(playUI, for: .normal)
            viewModel.pauseMusic()
        } else {
            let pauseUI = UIImage(systemName: "pause.fill", withConfiguration: imageConfig)
            sender.setImage(pauseUI, for: .normal)
            viewModel.playMusic()
        }
        sender.isSelected = viewModel.isPlay
    }
}

extension PlayViewController {
    func initMusic() {
        self.viewModel.getMusicData(urlStr: viewModel.fileUrl)
    }
    
    func setupBinders() {
        viewModel.music.bind { music in
            DispatchQueue.main.async {
                self.configure()
                self.initMusic()
            }
        }
        viewModel.fetchMusic()
    }
    
    func addObserver() {
        viewModel.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 100), queue: DispatchQueue.main) { time in
            self.updateTime(time: time)
        }
    }
    
    func updateTime(time: CMTime) {
        slider.value = Float(viewModel.currentValue)
        currentTimeLbl.text = viewModel.currentTimeText
        let index = viewModel.getCurrentLyricsIndex()
        print(index)
        lyricsLabel.text = "\(viewModel.lyricsArray[index])\n\(viewModel.lyricsArray[index + 1])"
        if index >= 1 {
            let attribtuedString = NSMutableAttributedString(string: lyricsLabel.text ?? "")
            let range = (lyricsLabel.text! as NSString).range(of: "\(viewModel.lyricsArray[index])")
            attribtuedString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
            lyricsLabel.attributedText = attribtuedString
        }
    }
}
