//
//  File.swift
//  Flo
//
//  Created by 이상준 on 2022/11/22.
//

import UIKit

struct ImageUtil {
    static func loadImageData(imgUrl: String, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let url = URL(string: imgUrl) {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        completion(image)
                    }
                }
            }else {
                completion(UIImage(named: "thum"))
            }
        }
    }
}
