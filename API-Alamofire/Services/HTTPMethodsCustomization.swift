//
//  HTTPMethodsCustomization.swift
//  API-Alamofire
//
//  Created by Reserveit Support on 25/3/23.
//

import UIKit
import Alamofire

class HTTPMethodsCustomization {
    
    let baseURL = "https://reqres.in/"

    var delegate: listValueTF? = nil
    var delegateS: singleValueTF? = nil
    var delegateLogin: loginToken? = nil
    
    // MARK: - Single Get
    func singleMethodGet(endPoint: String) {
        AF.request(baseURL + endPoint).responseJSON { response in
            print(response.response?.statusCode)
            
            switch response.result {
            case .success(let value):
                guard let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []),
                      let myData = try? JSONDecoder().decode(SingleGetModel.self, from: jsonData) else {
                    return
                }
                //print(myData)
                self.delegateS?.dataForTransfer(value: myData)
                
            case .failure(let error):
                print("Error retrieving data: \(error)")
            }
        }
    }
    
    // MARK: - List Get Method
    func listMethodGet(endPoint: String) {
        AF.request(baseURL + endPoint).responseJSON { response in
            print(response.response?.statusCode)
            
            switch response.result {
            case .success(let value):
                
                guard let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []),
                      let myData = try? JSONDecoder().decode(ListGetModel.self, from: jsonData) else {
                    return
                }
                self.delegate?.dataForTransfer(value: myData)
                
            case .failure(let error):
                print("Error retrieving data: \(error)")
            }
        }
    }
    
    //patch replaces a part of resource but put replaces the entire resourc. MARK: Patch
    func patchMethod(endPoint: String) {
        AF.request(baseURL + endPoint, method: .patch).responseJSON { response in
            print(response.response?.statusCode)
        }
    }
    
    // MARK: - Post Method
    func postMethod(endPoint: String,
                    parameter: PostModel) {
        
        AF.request(baseURL + endPoint, method: .post, parameters: parameter, encoder: JSONParameterEncoder.default).responseJSON { response in
            print(response.response?.statusCode)
            
            switch response.result {
            case .success(let value):
                print("Response: \(response).")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loginPostMethod(endPoint: String,
                         parameter: LoginPostModel) {
        
        AF.request(baseURL + endPoint, method: .post, parameters: parameter, encoder: JSONParameterEncoder.default).responseJSON { response in
            print(response.response?.statusCode)
            
            switch response.result {
            case .success(let value):
                guard let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []),
                      let myData = try? JSONDecoder().decode(LoginPostStatusModel.self, from: jsonData) else {
                    return
                }
                self.delegateLogin?.token(value: myData)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Put Method
    func putMethod(endPoint: String,
                   parameter: NSDictionary) {
        let param: [String: Any] = [
            "Email": "faysal.ahmed@reserveitbd.com",
            "Name": "Faysal Ahmed",
            "Password": "faysalf123"
        ]
        AF.request(baseURL + endPoint,
                   method: .put,
                   parameters: parameter as? Parameters,
                   encoding: JSONEncoding.default).responseJSON { response in
            print(response.response?.statusCode)
        }
    }
    
    // MARK: - Delete method
    func deleteMethod(endPoint: String) {
        AF.request(baseURL + endPoint,
                   method: .delete).responseJSON { response in
            print(response.response?.statusCode)
            
        }
    }
    
}
