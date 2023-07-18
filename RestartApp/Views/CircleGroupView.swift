//
//  CircleGroupView.swift
//  RestartApp
//
//  Created by Salvador on 18/7/23.
//

import SwiftUI

struct CircleGroupView: View {
    // MARK: - PROPERTY

    @State var ShapeColor: Color
    @State var ShapeOpacity: Double

    // MARK: - BODY

    var body: some View {
        ZStack {
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)

            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
        } //: ZSTACK
        .frame(maxWidth: 500)
        .padding(80)
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
        }
    }
}
