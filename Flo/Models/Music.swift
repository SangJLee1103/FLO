//
//  Music.swift
//  Flo
//
//  Created by 이상준 on 2022/11/20.
//

import Foundation

struct Music: Codable {
    let singer: String
    let album: String
    let title: String
    let duration: Int
    let imageUrl: String
    let fileUrl: String
    let lyrics: String
    
    enum CodingKeys: String, CodingKey {
        case singer, album, title, duration, lyrics
        case imageUrl = "image"
        case fileUrl = "file"
    }
}

extension Music {
    static let initialize = Music(singer: "", album: "", title: "", duration: 0, imageUrl: "", fileUrl: "", lyrics: "")
}
