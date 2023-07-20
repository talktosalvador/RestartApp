//
//  OnboardingView.swift
//  RestartApp
//
//  Created by Salvador on 16/7/23.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: PROPERTY

    let draggableCircleSize = 80.0
    let translationLimit = 150.0
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var circleWidth: Double = UIScreen.main.bounds.width * 0.1
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset = CGSize.zero
    @State private var arrowsOpacity = 0.0
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                    buttonOffset = gesture.translation.width
                    withAnimation(.linear(duration: 0.25)) {
                        arrowsOpacity = 0
                    }
                }
            }
            .onEnded { _ in
                if buttonOffset > buttonWidth / 2 {
                    buttonOffset = buttonWidth - 80
                    isOnboardingViewActive = false
                } else {
                    buttonOffset = 0
                    withAnimation(.linear(duration: 0.25)) {
                        arrowsOpacity = 1
                    }
                }
            }
    }
    
    var imageDrag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                if abs(imageOffset.width) <= translationLimit {
                    imageOffset = gesture.translation
                }
            }
            .onEnded { _ in
                withAnimation {
                    imageOffset = .zero
                }
            }
    }

    // MARK: BODY

    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // MARK: HEADER
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("Share")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                } //: HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                // MARK: CENTER
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2, lineWidth: circleWidth)
                        .offset(x: -imageOffset.width)
                        .blur(radius: abs(imageOffset.width) * 0.1)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: abs(imageOffset.width) * 0.1)
                        .rotationEffect(.degrees(Double(imageOffset.width * 0.1)))
                        .gesture(imageDrag)
                } //: CENTER
                .animation(.spring(response: 1, dampingFraction: 0.5), value: imageOffset)
                .overlay(alignment: .center) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .padding()
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .foregroundColor(.white)
//                    .opacity(0.5 - abs(imageOffset.width) / translationLimit * 0.5)
                    .opacity(arrowsOpacity)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                }
                
                Spacer()
                
                // MARK: FOOTER
                
                ZStack {
                    // PARTS OF THE CUSTOM BUTTON
                    
                    // 1. BACKGROUND (STATIC)
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2. CALL-TO-ACTION (STATIC)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    // 3. CAPSULE (DYNAMIC WIDTH)
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }
                    
                    // 4. CIRCLE (DRAGGABLE)
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: draggableCircleSize, height: draggableCircleSize, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(drag)
                        
                        Spacer()
                    } //: HSTACK
                } //: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            } //: VSTACK
        } //: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
