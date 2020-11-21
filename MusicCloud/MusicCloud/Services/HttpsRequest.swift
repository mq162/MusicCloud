//
//  HttpsRequest.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import Alamofire
import UIKit

class HttpRequests: NSObject {
    static let successRange = 200..<300

    static func request<T, V>(request: T,
                              completed: @escaping(_ result: Bool, _ response: V) -> Void)
        where T: BaseAPIProtocol, V: ResponseBaseModel, T.ResponseModel == V {
        if request.isShowLoading {
            Utils.showLoadingIndicator()
        }
        print(String(format: "-------------------\n\n\n\n link: = %@ \n params: = %@ \n", (request.urlRequest?.url!.absoluteString)!, request.params))
        AF.request(request)
            .validate(statusCode: HttpRequests.successRange)
            .responseJSON { (response) in
            if request.isShowLoading {
                Utils.hideLoadIndicator()
            }
            switch(response.result) {
            case .success(let data):
                print("\n response: \(data)")
                if data is [String: Any] {
                    let responseData = data as? [String: Any]
                    completed(true, V.init(JSON: responseData!)!)
                } else if data is NSArray {
                    let JSON = ["data": data]
                    completed(true, V.init(JSON: JSON)!)
                }
            case .failure(let error):
                print("failed \(error.localizedDescription)")
                var errorResponse = V.init()
                do {
                    //let statusCode = response.response?.statusCode ?? 0
                    if response.data != nil {
                        let responseString = String(data: response.data!, encoding: .utf8) ?? ""
                        print("error response \(responseString)")
                        guard let JSON: [String: Any] =
                            try JSONSerialization.jsonObject(with: response.data!,
                                                             options: JSONSerialization.ReadingOptions()) as? [String : Any] else {
                                return
                        }
                        errorResponse = V.init(JSON: JSON)!
                    }
                    if request.isShowErrorMessage {
                        //Utils.showErrorMessage(message: errorResponse.getErrorMessage())
                    }
                    completed(false, errorResponse)
                } catch {
                    if request.isShowErrorMessage {
                        //Utils.showErrorMessage(message: errorResponse.getErrorMessage())
                    }
                    completed(false, errorResponse)
                }
            }
        }
    }
}

