//
//  LoginResponseModel.swift
//  MusicCloud
//
//  Created by Quang Pham on 04/04/2021.
//

import ObjectMapper

class LoginResponseModel: ResponseBaseModel {
    var accessToken = ""

    override func mapping(map: Map) {
        super.mapping(map: map)
        accessToken <- map["access_token"]
    }
}
