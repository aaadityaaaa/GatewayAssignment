//
//  ErrorMessage.swift
//  GatewayAssignment
//
//  Created by Aaditya Singh on 27/09/23.
//

import Foundation

enum ErrorMessage: String, Error {
    case unableToCompleteRequest = "There was a problem with the request. check yout internet"
    case invalidResponse = "Invalid request"
    case invalidData = "The data received was invalid please try again"
}
