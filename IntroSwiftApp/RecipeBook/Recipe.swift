//
//  Recipe.swift
//  IntroSwiftApp
//
//  Data model for Recipe Book app
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id = UUID()
    var name: String
    var description: String
    var prepTime: Int // in minutes
    var cookTime: Int // in minutes
    var servings: Int
    var difficulty: Difficulty
    var ingredients: [Ingredient]
    var instructions: [String]
    var category: Category
    
    enum Difficulty: String, Codable, CaseIterable {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
    }
    
    enum Category: String, Codable, CaseIterable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case dessert = "Dessert"
        case snack = "Snack"
        case beverage = "Beverage"
    }
    
    var totalTime: Int {
        prepTime + cookTime
    }
}

struct Ingredient: Identifiable, Codable {
    let id = UUID()
    var name: String
    var amount: String
    var unit: String
}

// Sample recipes for demonstration
extension Recipe {
    static let sampleRecipes: [Recipe] = [
        Recipe(
            name: "Classic Pancakes",
            description: "Fluffy and delicious pancakes perfect for breakfast",
            prepTime: 10,
            cookTime: 15,
            servings: 4,
            difficulty: .easy,
            ingredients: [
                Ingredient(name: "All-purpose flour", amount: "1", unit: "cup"),
                Ingredient(name: "Sugar", amount: "2", unit: "tbsp"),
                Ingredient(name: "Baking powder", amount: "2", unit: "tsp"),
                Ingredient(name: "Salt", amount: "1/4", unit: "tsp"),
                Ingredient(name: "Milk", amount: "1", unit: "cup"),
                Ingredient(name: "Egg", amount: "1", unit: ""),
                Ingredient(name: "Butter, melted", amount: "2", unit: "tbsp")
            ],
            instructions: [
                "Mix dry ingredients in a large bowl",
                "In another bowl, whisk together milk, egg, and melted butter",
                "Pour wet ingredients into dry ingredients and stir until just combined",
                "Heat a griddle or pan over medium heat",
                "Pour 1/4 cup batter for each pancake",
                "Cook until bubbles form, then flip and cook until golden brown",
                "Serve hot with syrup and butter"
            ],
            category: .breakfast
        ),
        Recipe(
            name: "Chocolate Chip Cookies",
            description: "Classic homemade chocolate chip cookies",
            prepTime: 15,
            cookTime: 12,
            servings: 24,
            difficulty: .easy,
            ingredients: [
                Ingredient(name: "Butter, softened", amount: "1", unit: "cup"),
                Ingredient(name: "Brown sugar", amount: "3/4", unit: "cup"),
                Ingredient(name: "White sugar", amount: "3/4", unit: "cup"),
                Ingredient(name: "Eggs", amount: "2", unit: ""),
                Ingredient(name: "Vanilla extract", amount: "2", unit: "tsp"),
                Ingredient(name: "All-purpose flour", amount: "2 1/4", unit: "cups"),
                Ingredient(name: "Baking soda", amount: "1", unit: "tsp"),
                Ingredient(name: "Salt", amount: "1", unit: "tsp"),
                Ingredient(name: "Chocolate chips", amount: "2", unit: "cups")
            ],
            instructions: [
                "Preheat oven to 375°F (190°C)",
                "Cream together butter and both sugars until smooth",
                "Beat in eggs and vanilla extract",
                "In a separate bowl, combine flour, baking soda, and salt",
                "Gradually blend flour mixture into butter mixture",
                "Stir in chocolate chips",
                "Drop rounded tablespoons onto ungreased cookie sheets",
                "Bake for 9-11 minutes until golden brown",
                "Cool on baking sheet for 2 minutes before removing"
            ],
            category: .dessert
        ),
        Recipe(
            name: "Caesar Salad",
            description: "Fresh and crisp Caesar salad with homemade dressing",
            prepTime: 15,
            cookTime: 0,
            servings: 4,
            difficulty: .medium,
            ingredients: [
                Ingredient(name: "Romaine lettuce", amount: "1", unit: "head"),
                Ingredient(name: "Parmesan cheese", amount: "1/2", unit: "cup"),
                Ingredient(name: "Croutons", amount: "1", unit: "cup"),
                Ingredient(name: "Anchovy fillets", amount: "2", unit: ""),
                Ingredient(name: "Garlic cloves", amount: "2", unit: ""),
                Ingredient(name: "Lemon juice", amount: "2", unit: "tbsp"),
                Ingredient(name: "Dijon mustard", amount: "1", unit: "tsp"),
                Ingredient(name: "Olive oil", amount: "1/4", unit: "cup"),
                Ingredient(name: "Black pepper", amount: "1/4", unit: "tsp")
            ],
            instructions: [
                "Wash and chop romaine lettuce into bite-sized pieces",
                "Mash anchovies and garlic together",
                "Whisk together lemon juice, mustard, and olive oil",
                "Combine anchovy-garlic mixture with dressing",
                "Toss lettuce with dressing",
                "Add parmesan cheese and croutons",
                "Season with black pepper and serve immediately"
            ],
            category: .lunch
        )
    ]
}

