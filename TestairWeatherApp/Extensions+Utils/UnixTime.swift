//
//  UnixTime.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 12/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import Foundation

typealias UnixTime = Int

extension UnixTime {
    private func formatType(form: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    var dateFull: Date {
        return Date(timeIntervalSince1970: Double(self))
    }
    var month: String {
        return formatType(form: "MMM").string(from: dateFull)
    }
    
    var day: String {
        return formatType(form: "dd").string(from: dateFull)
    }
    
    var monthDay: String {
        return month.uppercased() + "\n" + day
    }
}
