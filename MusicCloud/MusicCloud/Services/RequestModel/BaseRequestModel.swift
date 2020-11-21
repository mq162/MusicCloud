//
//  BaseRequestModel.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import ObjectMapper

class RequestBaseModel: Mappable {
    required init?(map: Map) {}

    init() {}

    func mapping(map: Map) {}
}

class ResponseBaseModel: Mappable {

    private var errorMessage = [String]()

    required init?(map: Map) {}

    required init() {

    }

    required init(message: String) {
        self.errorMessage = [message]
    }

    func mapping(map: Map) {
        errorMessage <- map["e.message"]
    }

    func getErrorMessage() -> String {
        return errorMessage.first ?? "Error"
    }
}

