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
        let clock = TabItemViewModel(title: "World Clock",
                                     image: Image(systemName: "globe"),
                                     view: WorldClockView())
        
        let alarm = TabItemViewModel(title: "Alarm",
                                     image: Image(systemName: "alarm"),
                                     view: AlarmView())
        
        let stopwatch = TabItemViewModel(title: "Stop Watch",
                                         image: Image(systemName: "stopwatch"),
                                         view: StopWatchView())
        
        let timer = TabItemViewModel(title: "Timer",
                                     image: Image(systemName: "timer"),
                                     view: TimerView())
        
        tabs = [clock, alarm, stopwatch, timer]
    }
}
