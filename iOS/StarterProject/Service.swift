//
//  Service.swift
//  Platimi
//
//  Created by Božidar on 28/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Service {

    static let sharedInstance = Service()
    private let parser = Parser()

    let fonEndpoint = "http://foncoreapi.azurewebsites.net"

    private init() {}

    private let endpoint = "http://pokeapi.co"

    func sendTestRequest(completion: @escaping ([Pokemon]?) -> ()) {
        Alamofire.request("\(endpoint)/api/v2/pokemon").responseJSON { [weak self] response in
            print(response.result)   // result of response serialization

            if let response = response.result.value {
                let responseJSON = JSON(response)
                let pokemons = self?.parser.parseTest(json: responseJSON)
                completion(pokemons)
            }
        }
    }

    func sendTestRequestDetails(url: String, completion: @escaping ([Pokemon]?) -> ()) {
        Alamofire.request(url).responseJSON { [weak self] response in
            print(response.result)   // result of response serialization

            if let response = response.result.value {
                let responseJSON = JSON(response)
                print("detalji: \(responseJSON)")
//                let pokemons = self?.parser.parseTest(json: responseJSON)
//                completion(pokemons)
            }
        }
    }

    func loginWithFacebook(token: String, completion: @escaping (String?) -> ()) {
        let url = URL(string: "http://foncoreapi.azurewebsites.net/account/login/facebook")

        let parameters: Parameters = [
            "AccessToken": token
        ]

        var urlRequest = URLRequest(url: url!)

        urlRequest.httpMethod = "POST"

        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            // No-op
        }

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        Alamofire.request(urlRequest).responseJSON { response in
            if let response = response.result.value {
                let responseJSON = JSON(response)
                completion(responseJSON["accessToken"].string)
            } else {
                completion("")
            }
        }
    }

    func testProtected(token: String) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]


        Alamofire.request("\(fonEndpoint)/account/protected", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let response = response.result.value {
                print("response: \(response)")
            }
        }

    }
}
