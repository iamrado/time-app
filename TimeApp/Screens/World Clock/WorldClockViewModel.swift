//
//  WorldClockViewModel.swift
//  TimeApp
//
//  Created by rado on 07/01/2023.
//  Copyright © 2023 Radoslav Blasko. All rights reserved.
//

import Foundation
import SwiftUI

final class WorldClockViewModel: ObservableObject {
    @Published
    private(set) var saved = [TimeZoneModel]()

    @AppStorage("saved-timezones")
    private var stored: String = .init()

    init() {
        _saved = .init(initialValue: load())
    }

    func add(timeZone: TimeZoneModel) {
        guard !saved.contains(where: { $0.id == timeZone.id }) else {
            return
        }

        saved.append(timeZone)
        store()
    }

    func remove(at offsets: IndexSet) {
        saved.remove(atOffsets: offsets)
        store()
    }

    func move(fromOffsets offsets: IndexSet, toOffset offset: Int) {
        saved.move(fromOffsets: offsets, toOffset: offset)
        store()
    }

    private func load() -> [TimeZoneModel] {
        stored
            .components(separatedBy: ",")
            .compactMap { TimeZoneModel(identifier: $0) }
    }

    private func store() {
        stored = saved
            .map(\.timeZone.identifier)
            .joined(separator: ",")
    }
}
