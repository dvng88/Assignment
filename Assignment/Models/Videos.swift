//
//  Videos.swift
//  Assignment
//
//  Created by Devang Shah on 09/02/22.
//

import Foundation

struct Videos: Codable {
    var nextPageToken: String?
    var pageInfo: PageInfo
    var items: [Items]
}

struct PageInfo: Codable {
    var totalResults: Int!
    var resultsPerPage: Int!
}

struct Items: Codable {
    var id: Id!
    var snippet: Snippet!
    
    struct Id: Codable {
        var videoId: String!
    }
    
//    enum CodingKeys: String, CodingKey {
//        case snippet = "snippet"
//        case videoId = "id"
//    }
//    
//    enum VideoIdKey: CodingKey {
//        case videoId
//    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        
//        let location = try values.nestedContainer(keyedBy: VideoIdKey.self, forKey: .videoId)
//        videoId = try location.decode(String.self, forKey: .videoId)
//        snippet = try values.decode(Snippet.self, forKey: .snippet)
//    }
}

struct Snippet: Codable {
    var title: String!
    var description: String!
    var thumbnails: Thumbnails!
}

struct Thumbnails: Codable {
    var high: High!
    
    struct High: Codable {
        var url: String!
    }
    
}
