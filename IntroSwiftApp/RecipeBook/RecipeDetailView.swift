//
//  RecipeDetailView.swift
//  IntroSwiftApp
//
//  Detail view showing full recipe information
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(recipe.description)
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    // Recipe metadata
                    HStack(spacing: 20) {
                        InfoBadge(icon: "clock", text: "\(recipe.totalTime) min")
                        InfoBadge(icon: "person.2", text: "\(recipe.servings) servings")
                        InfoBadge(icon: "chart.bar.fill", text: recipe.difficulty.rawValue)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal)
                
                Divider()
                
                // Ingredients section
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Ingredients", icon: "list.bullet")
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(recipe.ingredients) { ingredient in
                            IngredientRow(ingredient: ingredient)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Divider()
                
                // Instructions section
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Instructions", icon: "number")
                    
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                            InstructionStep(number: index + 1, instruction: instruction)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoBadge: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
            Text(text)
                .font(.subheadline)
        }
        .foregroundColor(.secondary)
    }
}

struct SectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
        }
        .padding(.horizontal)
    }
}

struct IngredientRow: View {
    let ingredient: Ingredient
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "circle.fill")
                .font(.system(size: 6))
                .foregroundColor(.blue)
                .padding(.top, 8)
            
            HStack(spacing: 4) {
                if !ingredient.amount.isEmpty {
                    Text(ingredient.amount)
                        .fontWeight(.semibold)
                }
                if !ingredient.unit.isEmpty {
                    Text(ingredient.unit)
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: 80, alignment: .leading)
            
            Text(ingredient.name)
                .foregroundColor(.primary)
        }
        .font(.body)
    }
}

struct InstructionStep: View {
    let number: Int
    let instruction: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Step number
            Text("\(number)")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 28, height: 28)
                .background(Color.blue)
                .clipShape(Circle())
            
            // Instruction text
            Text(instruction)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    NavigationView {
        RecipeDetailView(recipe: Recipe.sampleRecipes[0])
    }
}

