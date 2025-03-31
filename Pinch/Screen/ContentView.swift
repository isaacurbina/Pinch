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

	
	// MARK: - function
	
	
	
	// MARK: - content
	
    var body: some View {
		NavigationView {
			ZStack {
				
				
				// MARK: - page image
				Image("magazine-front-cover")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.cornerRadius(10)
					.padding()
					.shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
					.opacity(isAnimating ? 1 : 0)
					.scaleEffect(imageScale)
				
				
					// MARK: - 1. tap gesture
				
					.onTapGesture(count: 2, perform: {
						if imageScale == 1 {
							withAnimation(.spring()) {
								imageScale = 5
							}
						} else {
							withAnimation(.spring()) {
								imageScale = 1
							}
						}
					})
				
			} // Stack
			.navigationTitle("Pinch & Zoom")
			.navigationBarTitleDisplayMode(.inline)
			.onAppear(perform: {
				withAnimation(.linear(duration: 1)) {
					isAnimating = true
				}
			})
			
		} // NavigationView
		.navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
