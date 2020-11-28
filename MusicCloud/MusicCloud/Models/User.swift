//
//  User.swift
//  SoundCloud
//
//  Created by Quang Pham on 19/11/2020.
//

import ObjectMapper

class User: BaseModel {
    
    var avatarUrl: String?
    var country: String?
    var city: String?
    var descriptionText: String?
    var anId: String?
    var username: String?
    var publicFavoritesCount: Int?
    var trackCount: Int?
    var playlistCount: Int?
    var followersCount: Int?
    var followingsCount: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        avatarUrl <- map["avatar_url"]
        username <- map["username"]
    }
}
