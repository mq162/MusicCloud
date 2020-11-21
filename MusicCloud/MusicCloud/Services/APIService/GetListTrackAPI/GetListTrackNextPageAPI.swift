//
//  GetListTrackNextPageAPI.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import Alamofire

class GetListTrackNextPageAPI: BaseAuthAPIProtocol {
    
    var url = ""

    typealias RequestModel = RequestBaseModel
    typealias ResponseModel = GetListTrackResponseModel
    var requestModel: RequestBaseModel = RequestBaseModel()
    
    var host: String {
        return url
    }

    var path: String {
        return ""
    }

    var params: Parameters {
        return requestModel.toJSON()
    }
    
    init(url: String) {
        self.url = url
    }
}

