//
//  MeProfileAPI.swift
//  MusicCloud
//
//  Created by Quang Pham on 04/04/2021.
//

import Alamofire

class MeProfileAPI: BaseAuthAPIProtocol {
    
    typealias RequestModel = RequestBaseModel
    typealias ResponseModel = UserProfileResponse
    var requestModel: RequestBaseModel = RequestBaseModel()
    
    var path: String {
        return APIServices.meProfile
    }

    var params: Parameters {
        return requestModel.toJSON()
    }
}
