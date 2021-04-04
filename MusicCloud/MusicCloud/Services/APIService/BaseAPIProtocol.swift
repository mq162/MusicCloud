//
//  BaseAPIProtocol.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import Alamofire
import Foundation

protocol BaseAPIProtocol: URLRequestConvertible {
    associatedtype RequestModel
    associatedtype ResponseModel

    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: Parameters { get }
    var headers: [String: String] { get }
    var isShowErrorMessage: Bool { get }
    var isShowLoading: Bool { get }
    var encode: ParameterEncoding { get }
    var requestModel: RequestModel { get set }
    var customizeMessage: [Int: String] { get }
}

extension BaseAPIProtocol {
    var host: String {
        return APIServices.serverSoundCloud
    }

    var method: HTTPMethod {
        return .get
    }

    var params: Parameters {
        return [:]
    }

    var headers: [String : String] {
        return [:]
    }

    var isShowErrorMessage: Bool {
        return true
    }

    var isShowLoading: Bool {
        return true
    }

    var encode: ParameterEncoding {
        return URLEncoding.default
    }

    var customizeMessage: [Int: String] {
        return [:]
    }

    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: URL(string: host + path)!)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        if !params.isEmpty {
            request = try encode.encode(request, with: params)
        }
        return request
    }
}

protocol BaseAuthAPIProtocol: BaseAPIProtocol {

}

extension BaseAuthAPIProtocol {
    var headers: [String : String] {
        let userDefault = UserDefaultUtils()
        if let token = userDefault.stringValue(key: Constants.Key.ACCESS_TOKEN) {
            return ["Authorization" : "OAuth \(token)"]
        } else {
            return headers
        }
    }
}
