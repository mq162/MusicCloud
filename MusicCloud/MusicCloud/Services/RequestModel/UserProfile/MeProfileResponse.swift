//
//  MeProfileResponse.swift
//  MusicCloud
//
//  Created by Quang Pham on 04/04/2021.
//

import ObjectMapper

class UserProfileResponse: ResponseBaseModel {
    var profile = User()

    override func mapping(map: Map) {
        super.mapping(map: map)
        profile.mapping(map: map)
    }
}
