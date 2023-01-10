//
//  TimeZoneModel.swift
//  TimeApp
//
//  Created by rado on 08/01/2023.
//  Copyright © 2023 Radoslav Blasko. All rights reserved.
//

import Foundation

struct TimeZoneModel: Identifiable {
    var id: String { timeZone.identifier }
    let timeZone: TimeZone
    let area: String?
    let city: String?
    var text: String { city ?? "-" }

    init?(identifier: String) {
        guard let zone = TimeZone(identifier: identifier) else { return nil }

        timeZone = zone
        (area, city) = parseIdentifier(identifier)
    }
}

private func parseIdentifier(_ identifier: String) -> (String?, String?) {
    let components = identifier
        .split(separator: "/")
        .map { component in
            String(
                component
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .replacingOccurrences(of: "_", with: " ")
            )
        }

    return (components.first, components.last)
}
