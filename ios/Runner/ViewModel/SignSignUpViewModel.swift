//
//  SignSignUpViewModel.swift
//  Runner
//
//  Created by achsum on 17/1/21.
//

import Foundation
import KeychainSwift

class SignSignUpViewModel {
    let keychain = KeychainSwift()
    
    public func login(values: Any, complition: @escaping (_ isSuccess: Bool)-> Void) {
        let userValues = values as! [String: String]
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.keychain.set(true, forKey: "isUserLoggedIn")
            self.keychain.set(userValues["userName"] ?? "", forKey: "userName")
            complition(true)
        }
    }
    
    public func register(values: Any, complition: @escaping (_ isSuccess: Bool)-> Void) {
        let userValues = values as! [String: String]
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.keychain.set(true, forKey: "isUserLoggedIn")
            self.keychain.set(userValues["userName"] ?? "", forKey: "userName")
            self.keychain.set(userValues["emailAddress"] ?? "", forKey: "emailAddress")
            complition(true)
        }
    }
    
    public func getUserName( complition: @escaping (_ isSuccess: Bool, _ firstName: String)-> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            complition(true, self.keychain.get("userName") ?? "")
        }
    }
    
    public func getEmailAddress( complition: @escaping (_ isSuccess: Bool, _ firstName: String)-> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            complition(true, self.keychain.get("emailAddress") ?? "")
        }
    }
    
    public func getUserLoggedIn( complition: @escaping (_ isSuccess: Bool)-> Void) {
        complition(self.keychain.getBool("isUserLoggedIn") ?? false)
    }
    
    public func logOutuser( complition: @escaping (_ isSuccess: Bool)-> Void) {
        self.keychain.clear()
        complition(true)
    }
    
    public func getCardDetails( complition: @escaping (_ data: String)-> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            complition(self.readLocalFile(forName: "Movies") ?? "")
        }
        
    }
    
    
    private func readLocalFile(forName name: String) -> String? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8), let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
