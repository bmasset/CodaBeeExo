//
//  APIHelper.swift
//  CodaBee
//
//  Created by Bernard Masset on 27/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit

class APIHelper {
    
    //https://www.googleapis.com/youtube/v3/search?
    //part=snippet&
    //channelId=UCCVQ8CmUbsDOnkaYbnRXRdA&
    //maxResults=50&
    //type=video&
    //key={YOUR_API_KEY}
    
    func getVideos(completion: (([Video]) -> Void)?) {
        // créer l'URL à partir de composants
        if var urlComponents = URLComponents(string: API_BASE_SEARCH) {
            urlComponents.queryItems = [
                URLQueryItem(name: "part", value: "snippet"),
                URLQueryItem(name: "ChannelId", value: CHANNEL_ID),
                URLQueryItem(name: "maxResults", value: String(50)),
                URLQueryItem(name: "type", value: "video"),
                URLQueryItem(name: "key", value: API_KEY)
            ]
                    }

        if var urlComponents = URLComponents(string: API_BASE_SEARCH) {
            urlComponents.queryItems = [
                URLQueryItem(name: "part", value: "snippet"),
                URLQueryItem(name: "channelId", value: CHANNEL_ID),
                URLQueryItem(name: "maxResults", value: String(50)),
                URLQueryItem(name: "type", value: "video"),
                URLQueryItem(name: "key", value: API_KEY)
            ]
            if let url = urlComponents.url {
                URLSession.shared.dataTask(with: url) { (d, response, error) in
                    if let data = d {
                        do {
                            let resultats =  try JSONDecoder().decode(APIResponse.self, from: data)
                            completion?(resultats.items)
                        } catch {
                            print(error.localizedDescription)
                            completion?([])
                        }
                    } else {
                        completion?([])
                    }
                    }.resume()
            } else {
                completion?([])
            }
        } else {
            completion?([])
        }
    }
}
