//
//  PhotoItem.swift
//  IntroSwiftApp
//
//  Data model for Photo Gallery app
//

import Foundation
import SwiftUI

struct PhotoItem: Identifiable {
    let id = UUID()
    let name: String
    let systemImage: String
    let color: Color
    let description: String
    
    static let samplePhotos: [PhotoItem] = [
        PhotoItem(
            name: "Sunset",
            systemImage: "sunset.fill",
            color: .orange,
            description: "A beautiful sunset over the horizon"
        ),
        PhotoItem(
            name: "Mountain",
            systemImage: "mountain.2.fill",
            color: .blue,
            description: "Majestic mountain peaks covered in snow"
        ),
        PhotoItem(
            name: "Ocean",
            systemImage: "water.waves",
            color: .cyan,
            description: "Calm ocean waves on a sunny day"
        ),
        PhotoItem(
            name: "Forest",
            systemImage: "tree.fill",
            color: .green,
            description: "Dense forest with tall trees"
        ),
        PhotoItem(
            name: "City",
            systemImage: "building.2.fill",
            color: .gray,
            description: "Modern city skyline at night"
        ),
        PhotoItem(
            name: "Flower",
            systemImage: "flower",
            color: .pink,
            description: "Colorful flowers in bloom"
        ),
        PhotoItem(
            name: "Star",
            systemImage: "star.fill",
            color: .yellow,
            description: "Bright stars in the night sky"
        ),
        PhotoItem(
            name: "Heart",
            systemImage: "heart.fill",
            color: .red,
            description: "A symbol of love and affection"
        ),
        PhotoItem(
            name: "Moon",
            systemImage: "moon.fill",
            color: .indigo,
            description: "Full moon on a clear night"
        ),
        PhotoItem(
            name: "Cloud",
            systemImage: "cloud.fill",
            color: .white,
            description: "Fluffy white clouds in the sky"
        ),
        PhotoItem(
            name: "Rainbow",
            systemImage: "rainbow",
            color: .purple,
            description: "Colorful rainbow after the rain"
        ),
        PhotoItem(
            name: "Butterfly",
            systemImage: "butterfly",
            color: .mint,
            description: "Beautiful butterfly in the garden"
        )
    ]
}

