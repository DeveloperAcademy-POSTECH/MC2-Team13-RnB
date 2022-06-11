//
//  NetworkManager.swift
//  CleanFish
//
//  Created by Moon Jongseek on 2022/06/11.
//

import Foundation

class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    let baseURLString: String = "http://ec2-3-85-213-190.compute-1.amazonaws.com/"
    
    func getVideoURL(courseName: String, step: Int) -> URL {
        guard let url = URL(string: baseURLString + courseName + "_\(step).mp4") else {
            return URL(fileURLWithPath: "")
        }
        return url
    }
    
    func getTotalStep(courseName: String, completeHandler: @escaping (NetworkVO?) -> Void) {
        guard let url = URL(string: baseURLString + "/course/" + courseName) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                return
            }
            
            let courseInfo = try? JSONDecoder().decode(NetworkVO.self, from: data)
            completeHandler(courseInfo)
        }.resume()
    }
}
