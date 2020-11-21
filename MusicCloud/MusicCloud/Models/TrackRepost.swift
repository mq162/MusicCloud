//
//  TrackRepost.swift
//  SoundCloud
//
//  Created by Quang Pham on 19/11/2020.
//

import Foundation

struct TrackRepost: Codable {
    var type: String?
    var user: User?
    var artwork_url: String?
    var waveform_url: String?
    var title: String?
    var uri: String?
    var permalink_url: String?
    var download_url: String?
    var stream_url:String?
    var local_path: String?
    var playback_count: Int?
    var comment_count: Int?
    var favoritings_count: Int?
    var likes_count: Int?
    var duration: Int?
    var anId: Int?
    var created_at: String?
    var descriptionText: String?
    var downloadable = false
    var streamable = false
    var user_id: Int?
    var repostCount: Int?
}
