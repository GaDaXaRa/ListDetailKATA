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
    
    static var rfc3339Formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.rfc3339Format
        return formatter
    }
}
