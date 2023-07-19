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
    @State var isAnimating: Bool = false

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
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
        })
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
