//
//  GetListTrackResponseModel.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import ObjectMapper

class GetListTrackResponseModel: ResponseBaseModel {
    var track: [Track] = [Track]()

    override func mapping(map: Map) {
        super.mapping(map: map)
        track <- map["collection"]
    }
}
