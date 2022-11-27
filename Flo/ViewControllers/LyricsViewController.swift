//
//  LyricsViewController.swift
//  Flo
//
//  Created by 이상준 on 2022/11/20.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "LyricsCell"

class LyricsViewController: UIViewController {
    
    var musicTitle: String? = ""
    var artist: String? = ""
    var viewModel: MusicViewModel!
    var imageConfig: UIImage.SymbolConfiguration?
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 2
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var lyricsTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        return tv
    }()
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal)
        slider.minimumTrackTintColor = #colorLiteral(red: 0.1411764706, green: 0.01176470611, blue: 0.8360022396, alpha: 1)
        slider.addTarget(self, action: #selector(moveSlider), for: .touchUpInside)
        return slider
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
        configureTableView()
        configureUI()
        updateTime(time: viewModel.currentTime)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        slider.value = Float(viewModel.currentValue)
    }
    
    func configureTableView() {
        lyricsTableView.delegate = self
        lyricsTableView.dataSource = self
        
        lyricsTableView.register(LyricsCell.self, forCellReuseIdentifier: reuseIdentifier)
        lyricsTableView.rowHeight = 30
    }
    
    func configureUI() {
        view.addSubview(topView)
        topView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 60)
        
        topView.addSubview(titleLabel)
        titleLabel.anchor(top: topView.topAnchor, left: topView.leftAnchor, paddingTop: 15, paddingLeft: 20)
        titleLabel.text = "\(musicTitle)\n\(artist)"
        
        topView.addSubview(closeButton)
        closeButton.anchor(top: topView.topAnchor, right: topView.rightAnchor, paddingTop: 15, paddingRight: 20)
        
        
        view.addSubview(lyricsTableView)
        lyricsTableView.anchor(top: topView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor ,right: view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 100, paddingRight: 0)
        
        view.addSubview(slider)
        slider.anchor(top: lyricsTableView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        slider.maximumValue = Float(viewModel.duration)
        
        view.addSubview(playButton)
        playButton.centerX(inView: view)
        playButton.anchor(top: slider.bottomAnchor, paddingTop: 20)
        
        let image = viewModel.isPlay ? UIImage(systemName: "pause.fill", withConfiguration: imageConfig) : UIImage(systemName: "play.fill", withConfiguration: imageConfig)
        playButton.setImage(image, for: .normal)
    }
}

// MARK: - 뷰 터치 이벤트에 대한 확장
extension LyricsViewController {
    @objc func dismissVC(_ sender: UIButton) {
        self.dismiss(animated: true)
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
    
    // UISlider
    @objc func moveSlider(_ sender: UISlider) {
        let seconds = Double(sender.value)
        
        if sender.isTracking {
            return
        } else {
            viewModel.player.seek(to: CMTime(seconds: seconds, preferredTimescale: 100))
        }
    }
}

// MARK: - 테이블 뷰 델리게이트, 데이터소스
extension LyricsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.lyricsDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LyricsCell
        cell.setLyrics(text: viewModel.lyricsArray[indexPath.row])
        return cell
    }
}

extension LyricsViewController {
    func addObserver() {
        viewModel.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 100), queue: DispatchQueue.main) { time in
            self.updateTime(time: time)
        }
    }
    
    func updateTime(time: CMTime) {
        slider.value = Float(viewModel.currentValue)
        let index = viewModel.getCurrentLyricsIndex()
        
        if index >= 1 {
            guard viewModel.prevLyricsIndex != index else { return }
            updateCell(prevIndex: viewModel.prevLyricsIndex, index: index)
            viewModel.prevLyricsIndex = index
        }
    }
    
    func updateCell(prevIndex: Int, index: Int) {
        lyricsTableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .middle, animated: true)
        
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = lyricsTableView.cellForRow(at: indexPath) as? LyricsCell {
            cell.setCurrentLyricsIndex()
        }
        
        guard prevIndex >= 0 else { return }
        let prevIndexPath = IndexPath(row: prevIndex, section: 0)
        
        if let prevLyricsCell = lyricsTableView.cellForRow(at: prevIndexPath) as? LyricsCell {
            prevLyricsCell.resetCurrentLyricsUI()
        }
    }
}
