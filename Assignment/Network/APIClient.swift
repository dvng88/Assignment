//
//  APIClient.swift
//  Assignment
//
//  Created by Devang Shah on 09/02/22.
//

import Foundation



struct APIClient {
    
    enum VideoError: Error {
        case invalidResponse
        case invalidData
        case noData
        case failedRequest
    }
    
    static func getVideos(query: String, nextPageToken: String?, completion: @escaping (Result<Videos, Error>) -> ()) {
        var url = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=15&key=\(Config.youtubeAPIKey)"
        
        guard let q = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        
        url += "&q=\(q.lowercased())"
        
        if let pageToken = nextPageToken {
            url += "&pageToken=\(pageToken)"
        }
        
        let request = URLRequest(url: URL( string: url)!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
              guard error == nil else {
                print("Failed request from : \(error!.localizedDescription)")
                completion(.failure(VideoError.failedRequest))
                return
              }
              
              guard let data = data else {
                completion(.failure(VideoError.noData))
                return
              }
              
              guard let response = response as? HTTPURLResponse else {
                print("Unable to process response")
                completion(.failure(VideoError.invalidResponse))
                return
              }
              
              guard response.statusCode == 200 else {
                print("Failure response from : \(response.statusCode)")
                print(response)
                completion(.failure(VideoError.failedRequest))
                return
              }
                
            do {
                let model = try JSONDecoder().decode(Videos.self, from: data)
                completion(.success(model))
            } catch {
                print("Fail : \(error)")
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
}
