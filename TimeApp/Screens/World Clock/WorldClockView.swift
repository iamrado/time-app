//
//  WorldClockView.swift
//  TimeApp
//
//  Created by Radoslav Blasko on 11/04/2020.
//  Copyright © 2020 Radoslav Blasko. All rights reserved.
//

import SwiftUI

struct WorldClockView: View {
    var body: some View {
        VStack {
            ClockView(timeZone: .current)
                .scaledToFit()
                .padding(25)
        }
    }
}

struct WorldClockView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockView()
    }
}
