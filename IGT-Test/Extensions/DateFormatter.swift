//
//  Date.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var rfc3339Format = "yyyy-MM-dd'T'HH:mm:ssZ"
    static var loginFormat = "MM/dd/yyy'T'HH:mm"
    
    static var rfc3339Formatter: DateFormatter {
        return formatter(with: DateFormatter.rfc3339Format)
    }
    
    static var loginFormatter: DateFormatter {
        return formatter(with: DateFormatter.loginFormat)
    }
    
    static func formatter(with format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}
