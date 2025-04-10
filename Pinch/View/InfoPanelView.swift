//
//  InfoPanelView.swift
//  Pinch
//
//  Created by Isaac Urbina on 4/2/25.
//

import SwiftUI

struct InfoPanelView: View {
	
	
	// MARK: - properties
	
	var scale: CGFloat
	var offset: CGSize
	
	@State private var isInfoPanelVisible: Bool = false
	
    var body: some View {
		HStack {
			
			// MARK: - hotspot
			
			Image(systemName: "circle.circle")
				.symbolRenderingMode(.hierarchical)
				.resizable()
				.frame(width: 30, height: 30)
				.onLongPressGesture(minimumDuration: 1,) {
					isInfoPanelVisible.toggle()
				}
			Spacer()
			
			
			// MARK: - info panel
			
			HStack(spacing: 2) {
				Image(systemName: "arrow.up.left.and.arro.down.right")
				Text("\(scale)")
				
				Spacer()
				
				Image(systemName: "arrow.left.and.right")
				Text("\(offset.width)")
				
				Spacer()
				
				Image(systemName: "arrow.up.and.down")
				Text("\(offset.height)")
				
				Spacer()
			} // HStack
			.font(.footnote)
			.padding(8)
			.background(.ultraThinMaterial)
			.cornerRadius(8)
			.frame(maxWidth: 420)
			.opacity(isInfoPanelVisible ? 1 : 0)
			
			Spacer()
		} // HStack
    }
}

#Preview {
	InfoPanelView(scale: 1, offset: .zero)
		.preferredColorScheme(.dark)
		.previewLayout(.sizeThatFits)
		.padding()
}
