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
	@State private var isDrawerOpen: Bool = false
	
	
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
				
				
				// MARK: - magnification
				
					.gesture(
						MagnificationGesture()
							.onChanged { value in
								withAnimation(.linear(duration: 1)) {
									if imageScale >= 1 && imageScale <= 5 {
										imageScale = value
									} else if imageScale > 5 {
										imageScale = 5
									}
								}
							}
							.onEnded { _ in
								if imageScale > 5 {
									imageScale = 5
								} else if imageScale <= 1 {
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
			
			
			// MARK: - controls
			.overlay(
				Group {
					HStack {
						// scale down
						Button {
							withAnimation(.spring()) {
								if imageScale > 1 {
									imageScale -= 1
									
									if imageScale <= 1 {
										resetImageState()
									}
								}
							}
						} label: {
							ControlImageView(icon: "minus.magnifyingglass")
						}
						
						// reset
						Button {
							resetImageState()
						} label: {
							ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
						}
						
						// scale up
						Button {
							withAnimation(.spring()) {
								if imageScale < 5 {
									imageScale += 1
									
									if imageScale > 5 {
										imageScale = 5
									}
								}
							}
						} label: {
							ControlImageView(icon: "plus.magnifyingglass")
						}
						
					} // HStack
					.padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
					.background(.ultraThinMaterial)
					.cornerRadius(12)
					.opacity(isAnimating ? 1 : 0)
				}
					.padding(.bottom, 30)
				, alignment: .bottom
			)
			
			
			// MARK: - drawer
			.overlay(
				HStack(spacing: 12) {
					
					
					// MARK: - drawer handle
					Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
						.resizable()
						.scaledToFit()
						.frame(height: 40)
						.padding(8)
						.foregroundStyle(.secondary)
						.onTapGesture(perform: {
							withAnimation(.easeOut) {
								isDrawerOpen.toggle()
							}
						})
					
					
					// MARK: - thumbnails
					Spacer()
					
				} // HStack
					.padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
					.background(.ultraThinMaterial)
					.cornerRadius(12)
					.opacity(isAnimating ? 1 : 0)
					.frame(width: 260)
					.padding(.top, UIScreen.main.bounds.height / 12)
					.offset(x: isDrawerOpen ? 20: 215)
				, alignment: .topTrailing
				
			) // drawer
		} // NavigationView
		.navigationViewStyle(.stack)
	}
}

#Preview {
	ContentView()
}
