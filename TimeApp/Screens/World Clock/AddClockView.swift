//
//  AddClockView.swift
//  TimeApp
//
//  Created by rado on 08/01/2023.
//  Copyright © 2023 Radoslav Blasko. All rights reserved.
//

import SwiftUI

struct AddClockView: View {
    @State
    private var searchText = ""

    @StateObject
    private var model = AddClockViewModel()

    private let onSelect: ((TimeZoneModel) -> Void)?

    init(onSelect action: ((TimeZoneModel) -> Void)? = nil) {
        onSelect = action
    }

    var body: some View {
        List {
            ForEach(model.sections) { section in
                Section(section.name) {
                    ForEach(section.items) { item in
                        Button(
                            action: { onSelect?(item) },
                            label: { AddClockRowView(item) }
                        )
                    }
                }
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .listStyle(.plain)
        .onChange(of: searchText, perform: model.search(_:))
    }
}

struct AddClockView_Previews: PreviewProvider {
    static var previews: some View {
        AddClockView()
    }
}
