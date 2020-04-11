//
//  MainView.swift
//  TimeApp
//
//  Created by Radoslav Blasko on 11/04/2020.
//  Copyright © 2020 Radoslav Blasko. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var viewModel: MainViewModel { MainViewModel() }

    var body: some View {
        TabView {
            ForEach(self.viewModel.tabs) { tab in
                NavigationView {
                    tab.view()
                        .navigationBarTitle(tab.title)
                }.tabItem {
                    tab.image
                    Text(tab.title)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
