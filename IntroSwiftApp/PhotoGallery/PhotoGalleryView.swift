//
//  PhotoGalleryView.swift
//  IntroSwiftApp
//
//  Main gallery view for Photo Gallery app
//

import SwiftUI

struct PhotoGalleryView: View {
    @State private var photos: [PhotoItem] = PhotoItem.samplePhotos
    @State private var selectedPhoto: PhotoItem?
    @State private var searchText = ""
    @State private var gridColumns = 2
    
    var filteredPhotos: [PhotoItem] {
        if searchText.isEmpty {
            return photos
        } else {
            return photos.filter { photo in
                photo.name.localizedCaseInsensitiveContains(searchText) ||
                photo.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Grid columns selector
                HStack {
                    Text("Grid Size")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        ForEach([1, 2, 3], id: \.self) { columns in
                            Button {
                                withAnimation {
                                    gridColumns = columns
                                }
                            } label: {
                                Image(systemName: "square.grid.\(columns)x\(columns)")
                                    .font(.title3)
                                    .foregroundColor(gridColumns == columns ? .blue : .gray)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(Color(.systemGray6))
                
                // Photo grid
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: gridColumns), spacing: 16) {
                        ForEach(filteredPhotos) { photo in
                            PhotoThumbnailView(photo: photo)
                                .onTapGesture {
                                    selectedPhoto = photo
                                }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Photo Gallery")
            .searchable(text: $searchText, prompt: "Search photos...")
            .sheet(item: $selectedPhoto) { photo in
                PhotoDetailView(photo: photo)
            }
        }
    }
}

struct PhotoThumbnailView: View {
    let photo: PhotoItem
    
    var body: some View {
        VStack(spacing: 0) {
            // Photo placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [photo.color, photo.color.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .aspectRatio(1, contentMode: .fit)
                
                Image(systemName: photo.systemImage)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
            }
            
            // Photo info
            VStack(alignment: .leading, spacing: 4) {
                Text(photo.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(photo.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .background(Color(.systemBackground))
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    PhotoGalleryView()
}

