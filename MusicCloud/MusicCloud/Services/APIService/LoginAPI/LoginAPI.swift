//
//  LoginAPI.swift
//  MusicCloud
//
//  Created by Quang Pham on 04/04/2021.
//

import Alamofire

class LoginAPI: BaseAPIProtocol {
    
    typealias RequestModel = LoginRequestModel
    typealias ResponseModel = LoginResponseModel
    var requestModel: LoginRequestModel
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return APIServices.oAuthAPI + "?client_id=\(Constants.SoundCloud.soundCloudClientID)"
    }

    var params: Parameters {
        return requestModel.toJSON()
    }

    init(email: String, password: String) {
        requestModel = LoginRequestModel(username: email, password: password)
    }
}
