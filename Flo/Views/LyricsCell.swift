//
//  LyricsCell.swift
//  Flo
//
//  Created by 이상준 on 2022/11/26.
//

import UIKit

class LyricsCell: UITableViewCell {
    
    private let lyricsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "문재인"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(lyricsLabel)
        lyricsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 20, paddingRight: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLyrics(text: String) {
        lyricsLabel.text = text
    }
    
    func setCurrentLyricsIndex() {
        lyricsLabel.textColor = .black
        lyricsLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    func resetCurrentLyricsUI() {
        lyricsLabel.textColor = .lightGray
        lyricsLabel.font = UIFont.systemFont(ofSize: 16)
    }
}
