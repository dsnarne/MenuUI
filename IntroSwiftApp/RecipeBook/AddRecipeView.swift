//
//  AddRecipeView.swift
//  IntroSwiftApp
//
//  View for adding new recipes
//

import SwiftUI

struct AddRecipeView: View {
    @Binding var recipes: [Recipe]
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @State private var prepTime = 15
    @State private var cookTime = 15
    @State private var servings = 4
    @State private var difficulty: Recipe.Difficulty = .easy
    @State private var category: Recipe.Category = .dinner
    @State private var ingredients: [Ingredient] = [Ingredient(name: "", amount: "", unit: "")]
    @State private var instructions: [String] = [""]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Basic Information") {
                    TextField("Recipe Name", text: $name)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                    
                    Picker("Category", selection: $category) {
                        ForEach(Recipe.Category.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    
                    Picker("Difficulty", selection: $difficulty) {
                        ForEach(Recipe.Difficulty.allCases, id: \.self) { difficulty in
                            Text(difficulty.rawValue).tag(difficulty)
                        }
                    }
                }
                
                Section("Time & Servings") {
                    Stepper("Prep Time: \(prepTime) min", value: $prepTime, in: 0...300, step: 5)
                    Stepper("Cook Time: \(cookTime) min", value: $cookTime, in: 0...300, step: 5)
                    Stepper("Servings: \(servings)", value: $servings, in: 1...20)
                }
                
                Section("Ingredients") {
                    ForEach($ingredients) { $ingredient in
                        HStack {
                            TextField("Amount", text: $ingredient.amount)
                                .frame(width: 60)
                            TextField("Unit", text: $ingredient.unit)
                                .frame(width: 60)
                            TextField("Ingredient Name", text: $ingredient.name)
                        }
                    }
                    .onDelete { indexSet in
                        ingredients.remove(atOffsets: indexSet)
                    }
                    
                    Button("Add Ingredient") {
                        ingredients.append(Ingredient(name: "", amount: "", unit: ""))
                    }
                }
                
                Section("Instructions") {
                    ForEach($instructions, id: \.self) { $instruction in
                        TextField("Step", text: $instruction, axis: .vertical)
                            .lineLimit(2...4)
                    }
                    .onDelete { indexSet in
                        instructions.remove(atOffsets: indexSet)
                    }
                    
                    Button("Add Step") {
                        instructions.append("")
                    }
                }
            }
            .navigationTitle("New Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveRecipe()
                    }
                    .disabled(name.isEmpty || description.isEmpty)
                }
            }
        }
    }
    
    func saveRecipe() {
        let newRecipe = Recipe(
            name: name,
            description: description,
            prepTime: prepTime,
            cookTime: cookTime,
            servings: servings,
            difficulty: difficulty,
            ingredients: ingredients.filter { !$0.name.isEmpty },
            instructions: instructions.filter { !$0.isEmpty },
            category: category
        )
        recipes.append(newRecipe)
        dismiss()
    }
}

#Preview {
    AddRecipeView(recipes: .constant([]))
}

