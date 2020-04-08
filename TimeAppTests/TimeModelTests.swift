//
//  TimeModelTests.swift
//  TimeAppTests
//
//  Created by Radoslav Blasko on 08/04/2020.
//  Copyright © 2020 Radoslav Blasko. All rights reserved.
//

import XCTest
@testable import TimeApp

class TimeModelTests: XCTestCase {

    func testHoursMinutesSecondsGregorian() throws {
        let calendar = Calendar(identifier: .gregorian)
        let timezone = TimeZone(secondsFromGMT: 0)!
        let dateComponents = DateComponents(calendar: calendar, timeZone: timezone, year: 2020, month: 4, day: 8, hour: 1, minute: 15, second: 24)
        let time = calendar.date(from: dateComponents)!

        let subject = TimeModel(date: time, timeZone: timezone)

        XCTAssertEqual(subject.hours, 1.01, accuracy: 0.01)
        XCTAssertEqual(subject.minutes, 15.4)
        XCTAssertEqual(subject.seconds, 24.0)
    }

}
