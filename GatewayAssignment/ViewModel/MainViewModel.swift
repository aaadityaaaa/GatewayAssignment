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
            guard let self = self else {return}
            view.dismissLoadingView()
            switch result {
            case .success(let response):
                print("success on getting response \(response)")
                completionHandler(response)
            case .failure(let error):
                print("failed to get response \(error)")
            }
        }
    }
    
    func nsdataToJSON(data: Data) -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}

