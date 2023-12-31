//
//  String+Ext.swift
//  GatewayAssignment
//
//  Created by Aaditya Singh on 28/09/23.
//


extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
