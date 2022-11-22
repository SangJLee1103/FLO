//
//  PlayService.swift
//  Flo
//
//  Created by 이상준 on 2022/11/20.
//

import UIKit

struct MusicService {
    var music: Music?
    
    static func getMusic(completion: @escaping(Result<Music, Error>) -> Void) {
        let urlString = "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let requestURL = URLRequest(url: url)
            
            let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                if let safeData = data {
                    do {
                        let music = try JSONDecoder().decode(Music.self, from: safeData)
                        completion(.success(music))
                        print(music)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }
}
