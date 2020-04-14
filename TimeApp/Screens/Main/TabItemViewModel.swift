//
//  TabItemViewModel.swift
//  TimeApp
//
//  Created by Radoslav Blasko on 14/04/2020.
//  Copyright © 2020 Radoslav Blasko. All rights reserved.
//

import SwiftUI

struct TabItemViewModel: Identifiable {
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
