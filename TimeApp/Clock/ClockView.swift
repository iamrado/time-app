//
//  ClockView.swift
//  time app
//
//  Created by Radoslav Blasko on 13/02/2020.
//  Copyright © 2020 Radoslav Blasko. All rights reserved.
//

import SwiftUI

struct ClockView: View {
    let borderColor = Color(.systemFill)
    let borderWidth: CGFloat = 2
    let timeZone: TimeZone

    @State private var seconds: Double = 0
    @State private var minutes: Double = 0
    @State private var hours: Double = 0

    init(timeZone: TimeZone) {
        self.timeZone = timeZone
    }

    var body: some View {
        GeometryReader { g in
            ZStack {
                Circle()
                    .fill(Color(.systemBackground))
                Circle()
                    .stroke(self.borderColor, lineWidth: self.borderWidth * g.size.width * 0.003)
                    .padding(self.borderWidth)

                ClockMarksView()
                ClockHoursView()
                    .padding(40 * g.size.width * 0.003)
                ClockHands(seconds: self.seconds, minutes: self.minutes, hours: self.hours)
                    .onFrame { _ in
                        let time = TimeModel(date: Date(), timeZone: self.timeZone)
                        self.seconds = time.seconds
                        self.minutes = time.minutes
                        self.hours = time.hours
                }
            }
        }
    }
}

private struct ClockMarksView: View {
    private let relativeLength: CGFloat = 0.03

    var body: some View {
        GeometryReader { g in
            ForEach(0..<60) { n in
                Path { path in
                    path.move(to: CGPoint(x: g.size.width / 2, y: 0))
                    path.addLine(to: CGPoint(x: g.size.width / 2,
                                             y: ( n % 5 == 0 ? 0.05 : 0.02) * g.size.height))
                }
                .stroke(Color(.systemGray), lineWidth: (n % 5 == 0 ? 2 : 1) * g.size.width * 0.003)
                .rotationEffect(Angle(degrees: Double(n) * 360 / 60))
            }
        }
    }
}

private struct ClockHands: View {
    let seconds: Double
    let minutes: Double
    let hours: Double

    init(seconds: Double, minutes: Double, hours: Double) {
        self.seconds = seconds
        self.minutes = minutes
        self.hours = hours
    }

    var body: some View {
        GeometryReader { g in
            ZStack {
                Path { path in
                    path.move(to: CGPoint(x: g.size.width / 2, y: 0))
                    path.addLine(to: CGPoint(x: g.size.width / 2,
                                             y: g.size.height / 2))
                }
                .stroke(Color(.systemRed), lineWidth: 1 * g.size.width * 0.003)
                .rotationEffect(Angle(degrees: self.seconds * 360 / 60))

                Path { path in
                    path.move(to: CGPoint(x: g.size.width / 2, y: (g.size.height / 2) * 0.1))
                    path.addLine(to: CGPoint(x: g.size.width / 2,
                                             y: g.size.height / 2))
                }
                .stroke(Color(.label), lineWidth: 2 * g.size.width * 0.003)
                .rotationEffect(Angle(degrees: self.minutes * 360 / 60))

                Path { path in
                    path.move(to: CGPoint(x: g.size.width / 2, y: (g.size.height / 2) * 0.5))
                    path.addLine(to: CGPoint(x: g.size.width / 2,
                                             y: g.size.height / 2))
                }
                .stroke(Color(.label), lineWidth: 4 * g.size.width * 0.003)
                .rotationEffect(Angle(degrees: self.hours * 360 / 12))
            }
        }
    }
}

private struct ClockHoursView: View {
    var body: some View {
        GeometryReader { g in
            ForEach(1..<13) { hour in
                Text(String(hour))
                    .font(.system(size: 0.1 * g.size.width, weight: .semibold, design: .rounded))
                    .position(HourAngle(hour: hour, diameter: g.size.width / 2).origin)
            }
        }
    }
}

private struct HourAngle {
    let origin: CGPoint

    init(hour: Int, diameter: CGFloat) {
        assert(Range(1...12).contains(hour))

        let angle: Double = ((Double(hour) * 30.0) + -90) * Double.pi / 180
        let r = Double(diameter)

        let x = cos(angle) * r + r
        let y = sin(angle) * r + r

        origin = CGPoint(x: x, y: y)
    }
}

struct ClockView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            ClockView(timeZone: .current)
                .aspectRatio(1, contentMode: .fit)
                .previewLayout(.fixed(width: 200, height: 200))
        }
    }
}
