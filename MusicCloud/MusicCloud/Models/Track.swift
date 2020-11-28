//
//  Track.swift
//  SoundCloud
//
//  Created by Quang Pham on 19/11/2020.
//

import ObjectMapper
import Foundation

class Track: BaseModel, Hashable {
    
    var id: Int = 0
    var user: User?
    var artworkUrl: String?
    var createdAt: String?
    var directory_path: String?
    var uri: String?
    var permalink_url: String?
    var descriptionText: String?
    var waveform_url: String?
    var title: String?
    var stream_url: String?
    var playbackCount: Int?
    var commentCount: Int?
    var favoriteCount: Int?
    var likesCount: Int?
    var duration: Int?
    var download_url: String?
    var local_path: String?
    var repostsCount: Int?
    var isDownloadable: Bool = false
    var isStreamable: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Track, rhs: Track) -> Bool {
        lhs.id == rhs.id
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["origin.id"]
        user <- map["user"]
        title <- map["title"]
        artworkUrl <- map["origin.artwork_url"]
        createdAt <- map["created_at"]
        directory_path <- map["directory_path"]
        descriptionText <- map["descriptionText"]
        permalink_url <- map["permalink_url"]
        uri <- map["uri"]
        favoriteCount <- map["favoritings_count"]
        likesCount <- map["likes_count"]
        repostsCount <- map["reposts_count"]
        commentCount <- map["comment_count"]
    }

}
