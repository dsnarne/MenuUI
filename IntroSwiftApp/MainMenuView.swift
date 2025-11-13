//
//  MainMenuView.swift
//  IntroSwiftApp
//
//  Main menu to navigate between different apps
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Swift Projects")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Advanced iOS Apps")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    
                    // App cards
                    VStack(spacing: 20) {
                        AppCard(
                            title: "Recipe Book",
                            description: "Browse, search, and manage your favorite recipes with ingredients and step-by-step instructions",
                            icon: "book.fill",
                            color: .orange,
                            destination: AnyView(RecipeListView())
                        )
                        
                        AppCard(
                            title: "Expense Tracker",
                            description: "Track your expenses by category, view totals, and manage your budget with persistent storage",
                            icon: "creditcard.fill",
                            color: .blue,
                            destination: AnyView(ExpenseListView())
                        )
                        
                        AppCard(
                            title: "Photo Gallery",
                            description: "Browse photos in a beautiful grid layout with zoom, pan, and detail views",
                            icon: "photo.fill",
                            color: .purple,
                            destination: AnyView(PhotoGalleryView())
                        )
                    }
                    .padding(.horizontal)
                    
                    // Original counter app
                    VStack(spacing: 12) {
                        Text("Original App")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        NavigationLink(destination: ContentView()) {
                            HStack {
                                Image(systemName: "hand.tap.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .frame(width: 50)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Counter App")
                                        .font(.headline)
                                    Text("Simple counter with state management")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                .padding(.bottom, 40)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct AppCard: View {
    let title: String
    let description: String
    let icon: String
    let color: Color
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 16) {
                    // Icon
                    ZStack {
                        Circle()
                            .fill(color.opacity(0.2))
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: icon)
                            .font(.system(size: 30))
                            .foregroundColor(color)
                    }
                    
                    // Title
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    // Arrow
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                
                // Description
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    MainMenuView()
}

