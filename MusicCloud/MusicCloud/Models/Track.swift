//
//  Track.swift
//  SoundCloud
//
//  Created by Quang Pham on 19/11/2020.
//

import Foundation

struct Track: Codable {
    
    var user: User?
    var artwork_url: String?
    var created_at: String?
    var directory_path: String?
    var uri: String?
    var permalink_url: String?
    var descriptionText: String?
    var waveform_url: String?
    var title: String?
    var stream_url: String?
    var playback_count: Int?
    var comment_count: Int?
    var favoritings_count: Int?
    var likes_count: Int?
    var anId: Int?
    var duration: Int?
    var download_url: String?
    var local_path: String?
    var reposts_count: Int?
    var isDownloadable: Bool = false
    var isStreamable: Bool = false
    
    init(trackRespost respost: TrackRepost?) {
        
    }
    
}
