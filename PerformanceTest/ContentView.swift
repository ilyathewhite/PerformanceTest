//
//  ContentView.swift
//  PerformanceTest
//
//  Created by Ilya Belenkiy on 11/6/19.
//  Copyright © 2019 Ilya Belenkiy. All rights reserved.
//

import SwiftUI

struct AppState {
    var circles: [CircleInfo] = []
    var dragPosition: CGPoint

    init() {
        for _ in 0..<1000 {
            circles.append(
                CircleInfo(
                    origin: CGPoint(
                        x: CGFloat.random(in: 0..<1000),
                        y: CGFloat.random(in: 0..<1000)
                    ),
                    diameter: Int.random(in: 10..<100)
                )
            )
        }

        dragPosition = CGPoint(x: 50, y: 50)
    }
}

enum AppAction {
    case circlesView(CirclesAction)
    case draggingView(DragAction)

    var circlesView: CirclesAction? {
        get {
            guard case let .circlesView(value) = self else { return nil }
            return value
        }
        set {
            guard case .circlesView = self, let newValue = newValue else { return }
            self = .circlesView(newValue)
        }
    }

    var draggingView: DragAction? {
        get {
            guard case let .draggingView(value) = self else { return nil }
            return value
        }
        set {
            guard case .draggingView = self, let newValue = newValue else { return }
            self = .draggingView(newValue)
        }
    }
}

let appReducer = combine(
    pullback(circlesViewReducer, value: \AppState.circles, action: \AppAction.circlesView),
    pullback(draggingViewReducer, value: \AppState.dragPosition, action: \AppAction.draggingView)
)

struct ContentViewGlobal: View {
    @ObservedObject var store: Store<AppState, AppAction>

    var body: some View {
        ZStack {
            CirclesView(store: self.store.view(value: { $0.circles }, action: { .circlesView($0) }))
            DraggingView(store: self.store.view(value: { $0.dragPosition }, action: {.draggingView($0) }))
        }
    }
}

struct ContentViewLocal: View {
    @ObservedObject var store: Store<AppState, AppAction>

    var body: some View {
        ZStack {
            CirclesView(store: Store(initialValue: store.value.circles, reducer: circlesViewReducer))
            DraggingView(store: Store(initialValue: store.value.dragPosition, reducer: draggingViewReducer))
        }
    }
}
