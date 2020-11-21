//
//  GetListTrackAPI.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import Alamofire

class GetListTrackAPI: BaseAuthAPIProtocol {

    typealias RequestModel = GetListTrackRequestModel
    typealias ResponseModel = GetListTrackResponseModel
    var requestModel: GetListTrackRequestModel

    var path: String {
        return APIServices.listTrackAPI
    }

    var params: Parameters {
        return requestModel.toJSON()
    }

    init(limit: Int) {
        requestModel = GetListTrackRequestModel(limit: limit)
    }
}
