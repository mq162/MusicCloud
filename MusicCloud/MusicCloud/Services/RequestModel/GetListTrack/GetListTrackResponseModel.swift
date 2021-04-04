//
//  GetListTrackResponseModel.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import ObjectMapper

class GetListTrackResponseModel: ResponseBaseModel {
    var tracks: [Track] = [Track]()
    var nextUrl = ""

    override func mapping(map: Map) {
        super.mapping(map: map)
        tracks <- map["collection"]
        nextUrl <- map["next_href"]
    }
}
