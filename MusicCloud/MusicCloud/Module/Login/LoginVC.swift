//
//  LoginVC.swift
//  SoundCloud
//
//  Created by Quang Pham on 19/11/2020.
//

import UIKit
import SwiftUI
import Alamofire

class LoginVC: UIViewController {

    @IBOutlet private weak var tfEmail: UITextField!
    @IBOutlet private weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupView() {
        
    }
    
    @IBAction func btnSignInClicked(_ sender: UIButton) {

        //let email = tfEmail.text!
        //let password = tfPassword.text!
//        HttpRequests.request(request: LoginAPI(username: email, password: password)) { (result, response) in
//            if result {
//                print(response.accessToken)
//            } else {
//                print(response.errorMessage)
//            }
//        }
        AF.request("https://api.soundcloud.com/oauth2/token?client_id=3ceea65b3d83ab630bc818ce1d179a82&client_secret=3b03e7bcc01b73c36075364e37fbfb58&grant_type=password&scope=non-expiring&username=minhquang16297@gmail.com&password=koolpoy1997").response { response in
            print(response)
        }
    
    }
    
}
