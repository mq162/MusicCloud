//
//  LoginVC.swift
//  SoundCloud
//
//  Created by Quang Pham on 19/11/2020.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {

    @IBOutlet private weak var tfEmail: UITextField!
    @IBOutlet private weak var tfPassword: UITextField!
    
    private lazy var userDefault = UserDefaultUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupView() {
       
    }
    
    @IBAction func btnSignInClicked(_ sender: UIButton) {
        let email = tfEmail.text ?? ""
        let password = tfPassword.text ?? ""
        HttpRequests.request(request: LoginAPI(email: email, password: password)) { [weak self] (result, response) in
            if result {
                self?.userDefault.setString(value: response.accessToken, key: Constants.Key.ACCESS_TOKEN)
                print(response.accessToken)
                self?.moveToHome()
            } else {
                print(response.getErrorMessage())
            }
        }
    }
    
    private func moveToHome() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        appDelegate.showHome()
    }
 }
