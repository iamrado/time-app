//
//  ContentView.swift
//  time app
//
//  Created by Radoslav Blasko on 13/02/2020.
//  Copyright © 2020 Radoslav Blasko. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let identifiers: [String] = {
        let ids = TimeZone.knownTimeZoneIdentifiers
        return Array(ids.reversed().dropFirst(ids.count - 4))
    }()

    var rows: [[TimeZone]] {
        let itemsPerRow = 3
        return identifiers
            .compactMap { TimeZone(identifier: $0) }
            .reduce([]) { (prev, element) -> [[TimeZone]] in
                if var last = prev.last {
                    var p = prev

                    if last.count == itemsPerRow {
                        p.append([element])
                        return p
                    } else {
                        last.append(element)
                        p.removeLast()
                        p.append(last)
                        return p
                    }
                } else {
                    return [[element]]
                }
            }
    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(rows , id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { timeZone in
                            VStack {
                                ClockView(timeZone: timeZone)
                                    .scaledToFit()
                                Text(timeZone.identifier)
                                    .font(.system(.caption))
                                    .lineLimit(1)
                            }
                        }
                    }
                }
            }.padding(10)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
