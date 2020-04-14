//
//  MainViewModel.swift
//  TimeApp
//
//  Created by Radoslav Blasko on 11/04/2020.
//  Copyright © 2020 Radoslav Blasko. All rights reserved.
//

import SwiftUI

final class MainViewModel {
    let tabs: [TabItemViewModel]

    init() {
        let clock = TabItemViewModel(title: NSLocalizedString("World Clock", comment: ""),
                                 image: Image(systemName: "clock"),
                                 view: WorldClockView())

        let alarm = TabItemViewModel(title: NSLocalizedString("Alarm", comment: ""),
                                 image: Image(systemName: "alarm"),
                                 view: AlarmView())

        let stopwatch = TabItemViewModel(title: NSLocalizedString("Stop Watch", comment: ""),
                                     image: Image(systemName: "stopwatch"),
                                     view: StopWatchView())

        let timer = TabItemViewModel(title: NSLocalizedString("Timer", comment: ""),
                                 image: Image(systemName: "timer"),
                                 view: TimerView())

        tabs = [clock, alarm, stopwatch, timer]
    }
}
