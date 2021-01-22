//
//  FlutterChannelManager.swift
//  Runner
//
//  Created by achsum on 17/1/21.
//

import Foundation

class FluuterChannelmanager {
    var flutterViewController:FlutterViewController
    let channel: FlutterMethodChannel
    var signSignUpViewModel: SignSignUpViewModel?
    
    init(flutterViewController: FlutterViewController) {
        self.flutterViewController = flutterViewController
        channel = FlutterMethodChannel(name: "sph.flutter.dev", binaryMessenger: flutterViewController.binaryMessenger)
    }
    
    func setUp(){
        self.channel.setMethodCallHandler { (call, result) in
            self.signSignUpViewModel = SignSignUpViewModel()
            switch call.method {
            case "login":
                self.signSignUpViewModel?.login(values: call.arguments as Any, complition: { (status) in
                    result(status)
                })
            case "register":
                self.signSignUpViewModel?.register(values: call.arguments as Any, complition: { (status) in
                    result(status)
                })
            case "getUserName":
                self.signSignUpViewModel?.getUserName(complition: { (status, firstName) in
                    if status {
                        result(firstName)
                    }
                })
                
            case "getEmailAddress":
                self.signSignUpViewModel?.getEmailAddress(complition: { (status, firstName) in
                    if status {
                        result(firstName)
                    }
                })
            case "getUserLoggedIn" :
                self.signSignUpViewModel?.getUserLoggedIn(complition: { (status) in
                    result(status)
                })
            case "logoutUser":
                self.signSignUpViewModel?.logOutuser(complition: { (status) in
                    result(status)
                })
            case "getCardDetails":
                self.signSignUpViewModel?.getCardDetails(complition: { (data) in
                    result(data)
                })
            default:
                break
            }
        }
        
    }
}
