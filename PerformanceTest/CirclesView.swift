//
//  Circles.swift
//  PerformanceTest
//
//  Created by Ilya Belenkiy on 11/6/19.
//  Copyright © 2019 Ilya Belenkiy. All rights reserved.
//

import SwiftUI

struct CircleInfo {
    let origin: CGPoint
    let diameter: Int
}

enum CirclesAction {}

func circlesViewReducer(state: inout [CircleInfo], action: CirclesAction) -> [Effect<CirclesAction>] { [] }

struct CirclesView: View {
    @ObservedObject var store: Store<[CircleInfo], CirclesAction>

    var body: some View {
        Path { path in
            for circle in store.value {
                path.addEllipse(in: CGRect(origin: circle.origin, size: CGSize(width: circle.diameter, height: circle.diameter)))
            }
        }
        .stroke()
    }
}

