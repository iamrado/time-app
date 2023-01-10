//
//  WorldClockView.swift
//  TimeApp
//
//  Created by Radoslav Blasko on 11/04/2020.
//  Copyright © 2020 Radoslav Blasko. All rights reserved.
//

import SwiftUI

struct WorldClockView: View {
    @StateObject
    private var model = WorldClockViewModel()

    @State
    private var isShowingAdd = false

    var body: some View {
        ZStack {
            List {
                ForEach(model.saved) { item in
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            ClockView(timeZone: item.timeZone)
                                .scaledToFit()
                            Text(item.text)
                                .font(.title2)
                        }
                        Spacer()
                    }
                    .frame(height: 260)
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: { idx in
                    withAnimation {
                        model.remove(at: idx)
                    }
                })
                .onMove(perform: model.move(fromOffsets:toOffset:))
            }
            .listStyle(.plain)

            Text("Start by adding a time zone")
                .foregroundColor(.gray)
                .opacity(model.saved.isEmpty ? 1 : 0)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) { EditButton() }

            ToolbarItem {
                Button {
                    isShowingAdd = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isShowingAdd, content: createAddClockSheet)
    }

    private func createAddClockSheet() -> some View {
        NavigationStack {
            AddClockView(onSelect: { tz in
                model.add(timeZone: tz)
                isShowingAdd = false
            })
            .navigationTitle("Add")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .destructive) { isShowingAdd = false }
                }
            }
        }
    }
}

struct WorldClockView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WorldClockView()
        }
    }
}
