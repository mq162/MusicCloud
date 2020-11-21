//
//  GetListTrackRequestModel.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import ObjectMapper

class GetListTrackRequestModel: RequestBaseModel {
    var limit: Int = 0
    var clientID: String = Constants.SoundCloud.SoundcloudClientID
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    init(limit: Int) {
        super.init()
        self.limit = limit
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        limit <- map["limit"]
        clientID <- map["client_id"]
    }
}
