//
//  TimeModel.swift
//  time app
//
//  Created by Radoslav Blasko on 14/02/2020.
//  Copyright © 2020 Radoslav Blasko. All rights reserved.
//

import Foundation

struct Time {
    let hours: Double
    let minutes: Double
    let seconds: Double

    init(date: Date, timeZone: TimeZone = .current) {
        let calendar = Calendar.current
        let timeZoneOffset = TimeInterval(timeZone.secondsFromGMT(for: date))
        let timeZoneDate = Date(timeIntervalSince1970: date.timeIntervalSince1970 + timeZoneOffset)

        let hour = calendar.component(.hour, from: timeZoneDate)
        let hoursDate = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: timeZoneDate, matchingPolicy: .strict, repeatedTimePolicy: .first, direction: .forward)
        let secondsSinceLastHour = timeZoneDate.timeIntervalSince(hoursDate!)

        hours = Double(hour) + secondsSinceLastHour / (60 * 60 * 24)
        minutes = secondsSinceLastHour / 60
        seconds = secondsSinceLastHour
    }
}
