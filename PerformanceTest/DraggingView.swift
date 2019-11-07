//
//  DraggingView.swift
//  PerformanceTest
//
//  Created by Ilya Belenkiy on 11/6/19.
//  Copyright © 2019 Ilya Belenkiy. All rights reserved.
//

import SwiftUI

enum DragAction {
    case update(CGPoint)
}

func draggingViewReducer(state: inout CGPoint, action: DragAction) -> [Effect<DragAction>] {
    switch action {
    case .update(let value):
        state = value
    }

    return []
}

struct DraggingView: View {
    @ObservedObject var store: Store<CGPoint, DragAction>

    var body: some View {
        Rectangle()
            .foregroundColor(.blue)
            .position(store.value)
            .frame(width: 200, height: 200)
        .gesture(DragGesture()
            .onChanged { value in
                self.store.send(.update(value.location))
            }
        )
    }
}
