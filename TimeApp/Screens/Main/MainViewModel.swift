//
//  MainViewModel.swift
//  TimeApp
//
//  Created by Radoslav Blasko on 11/04/2020.
//  Copyright © 2020 Radoslav Blasko. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class MainViewModel {
    let tabs: [TabViewModel]

    init() {
        let clock = TabViewModel(title: NSLocalizedString("World Clock", comment: ""),
                                 image: Image(systemName: "clock"),
                                 view: WorldClockView())

        let alarm = TabViewModel(title: NSLocalizedString("Alarm", comment: ""),
                                 image: Image(systemName: "alarm"),
                                 view: AlarmView())

        let stopwatch = TabViewModel(title: NSLocalizedString("Stop Watch", comment: ""),
                                     image: Image(systemName: "stopwatch"),
                                     view: StopWatchView())

        let timer = TabViewModel(title: NSLocalizedString("Timer", comment: ""),
                                 image: Image(systemName: "timer"),
                                 view: TimerView())

        tabs = [clock, alarm, stopwatch, timer]
    }
}

struct TabViewModel: Identifiable {
    let id = UUID()
    let title: String
    let image: Image
    let view: (() -> AnyView)

    init<V: View>(title: String, image: Image, view: @escaping @autoclosure (() -> V)) {
        self.title = title
        self.image = image
        self.view = { AnyView(view()) }
    }
}
