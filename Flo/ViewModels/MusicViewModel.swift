//
//  MusicViewModel.swift
//  Flo
//
//  Created by 이상준 on 2022/11/21.
//

import UIKit
import AVFoundation

class MusicViewModel {
    
    var player = AVPlayer()
    var isPlay: Bool
    
    var music: ObservableObject<Music>
    var image: UIImage
    var lyricsDict: [Int: String]
    var lyricsArray: [String]
    
    
    var title: String {
        return music.value.title
    }
    
    var singer: String {
        return music.value.singer
    }
    
    var album: String {
        return music.value.album
    }
    
    var duration: Int {
        return music.value.duration
    }
    
    var fileUrl: String {
        return music.value.fileUrl
    }
    
    var lyrics: String {
        return music.value.lyrics
    }
    
    
    var currentTime: CMTime {
        return player.currentItem?.currentTime() ?? CMTime.zero
    }
    
    var currentValue: Double {
        return player.currentItem?.currentTime().seconds ?? 0
    }
    
    var currentTimeText: String {
        return getTime(time: currentValue)
    }
    
    
    init() {
        self.music = ObservableObject(Music.initialize)
        self.image = UIImage()
        self.lyricsDict = [Int: String]()
        self.lyricsArray = [String]()
        self.isPlay = false
    }
    
    
    func fetchMusic() {
        MusicService.getMusic { response in
            switch response {
            case .success(let music):
                ImageUtil.loadImageData(imgUrl: music.imageUrl) { image in
                    self.image = image ?? UIImage()
                    self.music.value = music
                    self.classifyLyrics()
                }
            case .failure(_):
                print("Error")
            }
        }
    }
    
    
    func classifyLyrics() {
        var lyricsArr = self.lyrics.split(separator: "\n").map{String($0)}
        
        for lyrics in lyricsArr {
            let lyricsStart = lyrics.index(lyrics.startIndex, offsetBy: 11)
            
            let minutes = lyrics.substring(from: 1, to: 2)
            let seconds = lyrics.substring(from: 4, to: 5)
            let onlyLyrics = String(lyrics[lyricsStart...])
            
            let dictKey = (Int(minutes) ?? 0) * 60 + (Int(seconds) ?? 0)
            lyricsDict[dictKey] = onlyLyrics
        }
        lyricsArr = lyricsDict.sorted { $0.key < $1.key}.map { $0.value }
    }
    
    // 분:초 치환 함수
    func getTime(time: Double) -> String {
        let minute: Int = Int(time / 60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        return String(format: "%02ld:%02ld", minute, second)
    }
}

// MARK: 음원 재생에 대한 확장
extension MusicViewModel {
    
    // 음원 url을 받아 음원 데이터로 바꿔주는 함수
    func getMusicData(urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
    }
    
    // 음원 재생 함수
    func playMusic() {
        player.play()
        isPlay = true
    }
    
    // 음원 정지 함수
    func pauseMusic() {
        player.pause()
        isPlay = false
    }
    
    // 원하는 지점을 찾고 이동하는 함수
    func seek(_ time: CMTime) {
        player.seek(to: time)
    }
    
    
    func addPeriodicTimeObserver(forInterver: CMTime, queue: DispatchQueue?, using: @escaping(CMTime) -> Void) -> Any {
        player.addPeriodicTimeObserver(forInterval: forInterver, queue: queue, using: using)
    }
}

// MARK: - SubString 구현에 대한 확장
extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        // Index 값 획득
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1)
        
        // 파싱
        return String(self[startIndex ..< endIndex])
    }
}
