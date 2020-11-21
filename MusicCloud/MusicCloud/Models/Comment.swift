//
//  Comment.swift
//  SoundCloud
//
//  Created by Quang Pham on 19/11/2020.
//

import Foundation

struct Comment: Codable {
    var type: String?
    var body: String?
    var timestamp: Int?
    var id: Int?
    var user: User?
}
