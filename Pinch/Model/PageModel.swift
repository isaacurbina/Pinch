//
//  PageModel.swift
//  Pinch
//
//  Created by Isaac Urbina on 4/5/25.
//

import Foundation

struct Page: Identifiable {
	let id: Int
	let imageName: String
}

extension Page {
	var thumbnailName: String {
		return "thumb-\(imageName)"
	}
}
