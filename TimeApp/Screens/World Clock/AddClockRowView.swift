//
//  AddClockRowView.swift
//  TimeApp
//
//  Created by rado on 09/01/2023.
//  Copyright © 2023 Radoslav Blasko. All rights reserved.
//

import SwiftUI

struct AddClockRowView: View {
    private let model: TimeZoneModel

    init(_ model: TimeZoneModel) {
        self.model = model
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(model.text)
            if let area = model.area {
                Text(area)
                    .font(.caption)
            }
        }
    }
}

struct AddClockRowView_Previews: PreviewProvider {
    static var previews: some View {
        AddClockRowView(.init(identifier: "Europe/London")!)
    }
}
