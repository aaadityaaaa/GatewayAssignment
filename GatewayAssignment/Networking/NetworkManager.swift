//
//  NetworkManager.swift
//  GatewayAssignment
//
//  Created by Aaditya Singh on 27/09/23.
//

import Foundation

class NetworkManager {
    
    func getObject(completed: @escaping (Result<String, ErrorMessage>) -> Void) {
        
        let endpoint = Constants.URL
        guard let url = URL(string: endpoint) else {
            completed(.failure(.unableToCompleteRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(String(decoding: jsonData, as: UTF8.self))
                completed(.success(String(decoding: jsonData, as: UTF8.self)))
            } else {
                print("json data malformed")
            }
        }
        task.resume()
    }
    
}
