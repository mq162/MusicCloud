//
//  User.swift
//  SoundCloud
//
//  Created by Quang Pham on 19/11/2020.
//

import Foundation

struct User: Codable {
    
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
}
