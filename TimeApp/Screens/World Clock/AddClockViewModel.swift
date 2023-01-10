//
//  AddClockViewModel.swift
//  TimeApp
//
//  Created by rado on 09/01/2023.
//  Copyright © 2023 Radoslav Blasko. All rights reserved.
//

import Foundation

final class AddClockViewModel: ObservableObject {
    @Published
    private(set) var sections: [Section] = []

    private let timeZones = TimeZone
        .knownTimeZoneIdentifiers
        .compactMap(TimeZoneModel.init(identifier:))

    init() {
        _sections = .init(initialValue: createSections(timeZones: timeZones))
    }

    func search(_ text: String) {
        guard !text.isEmpty else {
            sections = createSections(timeZones: timeZones)
            return
        }

        func fieldFilter(_ field: String?) -> Bool {
            field?.lowercased().contains(text.lowercased()) ?? false
        }

        let results = timeZones.filter {
            fieldFilter($0.city) || fieldFilter($0.area)
        }

        sections = createSections(timeZones: results)
    }
}

extension AddClockViewModel {
    struct Section: Identifiable {
        var id: String { name }
        let name: String
        var items: [TimeZoneModel]
    }
}

private func createSections(timeZones: [TimeZoneModel]) -> [AddClockViewModel.Section] {
    var sections = [AddClockViewModel.Section]()

    timeZones
        .forEach { tz in
            let last = sections.last
            if last == nil || last?.name != tz.area {
                let section = AddClockViewModel.Section(
                    name: tz.area ?? "",
                    items: []
                )
                sections.append(section)
            }

            sections[sections.endIndex - 1].items.append(tz)
        }

    return sections
}
