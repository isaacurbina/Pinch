//
//  ContentView.swift
//  Pinch
//
//  Created by Isaac Urbina on 3/29/25.
//

import SwiftUI

struct ContentView: View {
	
	
	// MARK: - property
	
	@State private var isAnimating: Bool = false
	@State private var imageScale: CGFloat = 1
	@State private var imageOffset: CGSize = .zero

	
	// MARK: - function
	
	func resetImageState() {
		return withAnimation(.spring()) {
			imageScale = 1
			imageOffset = .zero
		}
	}
	
	
	// MARK: - content
	
    var body: some View {
		NavigationView {
			ZStack {
				Color.clear
				
				// MARK: - page image
				Image("magazine-front-cover")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.cornerRadius(10)
					.padding()
					.shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
					.opacity(isAnimating ? 1 : 0)
					.offset(x: imageOffset.width, y: imageOffset.height)
					.scaleEffect(imageScale)
				
				
					// MARK: - 1. tap gesture
				
					.onTapGesture(count: 2, perform: {
						if imageScale == 1 {
							withAnimation(.spring()) {
								imageScale = 5
							}
						} else {
							resetImageState()
						}
					})
				
				
					// MARK: - 2. drag gesture
				
					.gesture(
						DragGesture()
							.onChanged { value in
								withAnimation(.linear(duration: 1)) {
									imageOffset = value.translation
								}
							}
							.onEnded { _ in
								if imageScale <= 1 {
									resetImageState()
								}
							}
						)
				
			} // Stack
			.navigationTitle("Pinch & Zoom")
			.navigationBarTitleDisplayMode(.inline)
			.onAppear(perform: {
				withAnimation(.linear(duration: 1)) {
					isAnimating = true
				}
			})
			
			// MARK: - info panel
			
			.overlay(
				InfoPanelView(scale: imageScale, offset: imageOffset)
					.padding(.horizontal)
					.padding(.top, 30)
				, alignment: .top
			)
			
		} // NavigationView
		.navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
