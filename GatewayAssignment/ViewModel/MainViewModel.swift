//
//  AppSessionViewModel.swift
//  GatewayAssignment
//
//  Created by Aaditya Singh on 27/09/23.
//

import Foundation
import AuthenticationServices

class MainViewModel: NSObject, ASWebAuthenticationPresentationContextProviding {
   
    var webAuthSession: ASWebAuthenticationSession?
    private let networkingManager: NetworkManager
    init(networkingManager: NetworkManager) {
        self.networkingManager = networkingManager
    }
   
   func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
       return ASPresentationAnchor()
   }
   
    func openURLInApp(completionHandler: @escaping (_ callback: URL) -> Void) {
       let urlString = "https://webcode.tools/generators/html/hyperlink"
       if let url = URL(string: urlString) {
           webAuthSession = ASWebAuthenticationSession.init(
               url: url,
               callbackURLScheme: "sc-assignment",
               completionHandler: { (callback:URL?, error:Error?) in
                   guard let url = callback else { return }
                   completionHandler(url)
               })
           webAuthSession?.presentationContextProvider = self
           webAuthSession?.prefersEphemeralWebBrowserSession = true
           webAuthSession?.start()
       }
   }
    
    func fetchData(view: LoadingVC, completionHandler: @escaping (_ output: String) -> Void) {
        view.showLoadingView()
        networkingManager.getObject { [weak self] result in
            view.dismissLoadingView()
            switch result {
            case .success(let response):
                completionHandler(response)
            case .failure(let error):
                print("failed to get response \(error)")
            }
        }
    }
    
    func percentEncodeJSON() {
        let jsonObject: [String: Any] = [
            "name": "Aaditya",
            "age": 30
        ]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                // Now you have the JSON string
                print("ADD: json string -- " + jsonString)
                if let encodedJSONString = jsonString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                        // Now you have the URL-encoded JSON string
                        print("ADD: ENCODED json string -- " + encodedJSONString)
                    
                    let baseUrlString = "sc-assignment://home/redirect?"
                    var components = URLComponents(string: baseUrlString)

                    if let encodedJSONString = jsonString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                        let queryItem1 = URLQueryItem(name: "status", value: "Gateway-2023")
                        let queryItem2 = URLQueryItem(name: "code", value: "200")
                        let queryItem3 = URLQueryItem(name: "data", value: encodedJSONString)
                        components?.queryItems = [queryItem1, queryItem2, queryItem3]
                    }
                    if let url = components?.url {
                        // Use the URL with the JSON parameter
                        print("ADD: ABSOLUTE FINAL URL STRING IS -- " + url.absoluteString)
                    }
                    }
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
    }
    
    func percentDecodeJSON(urlString: String) -> String {
        let urlString = urlString
        if let dataParameter = urlString.split(separator: "&").first(where: { $0.contains("data=") }) {
            let encodedJSONString = dataParameter.replacingOccurrences(of: "data=", with: "")
            
            if let decodedJSONString = encodedJSONString.removingPercentEncoding {
                
                print("THIS IS THE PERCENT decoded JSON -  " + decodedJSONString)
                
                if let secondTime = decodedJSONString.removingPercentEncoding {
                    print("THIS IS THE SECOND TIME decoded JSON -  " + secondTime)
                    if let json = try? JSONSerialization.jsonObject(with: Data(secondTime.utf8), options: .mutableContainers),
                       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                        print(String(decoding: jsonData, as: UTF8.self))
                        return String(decoding: jsonData, as: UTF8.self)
                    } else {
                        print("json data malformed")
                    }
                }
            }
        }
        return ""
    }
}

//sc-assignment://home/redirect?status=Gateway-2023&code=200&data=%257B%2522name%2522:%2522Aaditya%2522,%2522age%2522:30%257D
