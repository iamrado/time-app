//
//  TimeModel.swift
//  time app
//
//  Created by Radoslav Blasko on 14/02/2020.
//  Copyright © 2020 Radoslav Blasko. All rights reserved.
//

import Foundation

class TimeModel: ObservableObject {
    private(set) var hours: Double
    private(set) var minutes: Double
    private(set) var seconds: Double
    private let timeZone: TimeZone

    init(date: Date = Date(), timeZone: TimeZone = .current) {
        self.timeZone = timeZone
        (hours, minutes, seconds) = calculate(date: date, timeZone: timeZone)
    }

    func update(date: Date = Date()) {
        objectWillChange.send()
        (hours, minutes, seconds) = calculate(date: date, timeZone: timeZone)
    }
}

private func calculate(date: Date, timeZone: TimeZone) -> (Double, Double, Double) {
    var calendar = Calendar.current
    calendar.timeZone = timeZone

    let timeZoneOffset = TimeInterval(calendar.timeZone.secondsFromGMT() - timeZone.secondsFromGMT())
    let timeZoneDate = Date(timeIntervalSince1970: date.timeIntervalSince1970 + timeZoneOffset)

    let hour = calendar.component(.hour, from: timeZoneDate)
    let hoursDate = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: timeZoneDate, matchingPolicy: .strict, repeatedTimePolicy: .first, direction: .forward)
    let secondsSinceLastHour = timeZoneDate.timeIntervalSince(hoursDate!)

    let hours = Double(hour) + secondsSinceLastHour / 60 / 60
    let minutes = secondsSinceLastHour / 60
    let seconds = secondsSinceLastHour - floor(minutes) * 60

    return (hours, minutes, seconds)
}
