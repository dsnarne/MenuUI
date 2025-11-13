//
//  RecipeListView.swift
//  IntroSwiftApp
//
//  Main list view for Recipe Book app
//

import SwiftUI

struct RecipeListView: View {
    @State private var recipes: [Recipe] = Recipe.sampleRecipes
    @State private var searchText = ""
    @State private var selectedCategory: Recipe.Category? = nil
    @State private var showingAddRecipe = false
    
    var filteredRecipes: [Recipe] {
        var filtered = recipes
        
        // Filter by category
        if let category = selectedCategory {
            filtered = filtered.filter { $0.category == category }
        }
        
        // Filter by search text
        if !searchText.isEmpty {
            filtered = filtered.filter { recipe in
                recipe.name.localizedCaseInsensitiveContains(searchText) ||
                recipe.description.localizedCaseInsensitiveContains(searchText) ||
                recipe.ingredients.contains { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        return filtered
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Category filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        CategoryFilterButton(
                            category: nil,
                            selectedCategory: $selectedCategory,
                            label: "All"
                        )
                        
                        ForEach(Recipe.Category.allCases, id: \.self) { category in
                            CategoryFilterButton(
                                category: category,
                                selectedCategory: $selectedCategory,
                                label: category.rawValue
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(Color(.systemGray6))
                
                // Recipe list
                if filteredRecipes.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "book.closed")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("No recipes found")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text("Try adjusting your search or filters")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(filteredRecipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeRowView(recipe: recipe)
                            }
                        }
                        .onDelete(perform: deleteRecipes)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Recipe Book")
            .searchable(text: $searchText, prompt: "Search recipes...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddRecipe = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddRecipe) {
                AddRecipeView(recipes: $recipes)
            }
        }
    }
    
    func deleteRecipes(at offsets: IndexSet) {
        let recipesToDelete = offsets.map { filteredRecipes[$0] }
        recipes.removeAll { recipe in
            recipesToDelete.contains { $0.id == recipe.id }
        }
    }
}

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 12) {
            // Category icon
            Image(systemName: categoryIcon)
                .font(.title2)
                .foregroundColor(categoryColor)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                
                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack(spacing: 12) {
                    Label("\(recipe.totalTime) min", systemImage: "clock")
                    Label("\(recipe.servings) servings", systemImage: "person.2")
                    Text(recipe.difficulty.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(difficultyColor.opacity(0.2))
                        .foregroundColor(difficultyColor)
                        .cornerRadius(8)
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
    
    var categoryIcon: String {
        switch recipe.category {
        case .breakfast: return "sunrise.fill"
        case .lunch: return "sun.max.fill"
        case .dinner: return "moon.fill"
        case .dessert: return "birthday.cake.fill"
        case .snack: return "leaf.fill"
        case .beverage: return "cup.and.saucer.fill"
        }
    }
    
    var categoryColor: Color {
        switch recipe.category {
        case .breakfast: return .orange
        case .lunch: return .yellow
        case .dinner: return .blue
        case .dessert: return .pink
        case .snack: return .green
        case .beverage: return .brown
        }
    }
    
    var difficultyColor: Color {
        switch recipe.difficulty {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
}

struct CategoryFilterButton: View {
    let category: Recipe.Category?
    @Binding var selectedCategory: Recipe.Category?
    let label: String
    
    var isSelected: Bool {
        selectedCategory == category
    }
    
    var body: some View {
        Button {
            selectedCategory = isSelected ? nil : category
        } label: {
            Text(label)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .cornerRadius(20)
        }
    }
}

#Preview {
    RecipeListView()
}

