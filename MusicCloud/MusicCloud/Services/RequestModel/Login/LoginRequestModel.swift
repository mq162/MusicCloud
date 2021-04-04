//
//  LoginRequestModel.swift
//  MusicCloud
//
//  Created by Quang Pham on 04/04/2021.
//

import ObjectMapper

class LoginRequestModel: RequestBaseModel {
    private var username = ""
    private var password = ""
    private var clientSecret = Constants.SoundCloud.soundCloudClientSecret
    private var grantType = "password"
    private var scope = "non-expiring"
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    init(username: String, password: String) {
        super.init()
        self.username = username
        self.password = password
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        username <- map["username"]
        password <- map["password"]
        clientSecret <- map["client_secret"]
        grantType <- map["grant_type"]
        scope <- map["scope"]
    }
}
