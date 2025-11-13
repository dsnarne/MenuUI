//
//  Expense.swift
//  IntroSwiftApp
//
//  Data model for Expense Tracker app
//

import Foundation

struct Expense: Identifiable, Codable {
    let id = UUID()
    var title: String
    var amount: Double
    var category: Category
    var date: Date
    var notes: String
    
    enum Category: String, Codable, CaseIterable {
        case food = "Food"
        case transportation = "Transportation"
        case shopping = "Shopping"
        case entertainment = "Entertainment"
        case bills = "Bills"
        case healthcare = "Healthcare"
        case education = "Education"
        case other = "Other"
        
        var icon: String {
            switch self {
            case .food: return "fork.knife"
            case .transportation: return "car.fill"
            case .shopping: return "bag.fill"
            case .entertainment: return "tv.fill"
            case .bills: return "doc.text.fill"
            case .healthcare: return "cross.case.fill"
            case .education: return "book.fill"
            case .other: return "ellipsis.circle.fill"
            }
        }
        
        var color: String {
            switch self {
            case .food: return "orange"
            case .transportation: return "blue"
            case .shopping: return "purple"
            case .entertainment: return "pink"
            case .bills: return "red"
            case .healthcare: return "green"
            case .education: return "indigo"
            case .other: return "gray"
            }
        }
    }
}

// Expense Manager for persistence
class ExpenseManager: ObservableObject {
    @Published var expenses: [Expense] = []
    
    private let expensesKey = "SavedExpenses"
    
    init() {
        loadExpenses()
    }
    
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
        saveExpenses()
    }
    
    func deleteExpense(_ expense: Expense) {
        expenses.removeAll { $0.id == expense.id }
        saveExpenses()
    }
    
    func updateExpense(_ expense: Expense) {
        if let index = expenses.firstIndex(where: { $0.id == expense.id }) {
            expenses[index] = expense
            saveExpenses()
        }
    }
    
    var totalExpenses: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    func expensesByCategory(_ category: Expense.Category) -> [Expense] {
        expenses.filter { $0.category == category }
    }
    
    func totalByCategory(_ category: Expense.Category) -> Double {
        expensesByCategory(category).reduce(0) { $0 + $1.amount }
    }
    
    func expensesForDate(_ date: Date) -> [Expense] {
        let calendar = Calendar.current
        return expenses.filter { calendar.isDate($0.date, inSameDayAs: date) }
    }
    
    private func saveExpenses() {
        if let encoded = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(encoded, forKey: expensesKey)
        }
    }
    
    private func loadExpenses() {
        if let data = UserDefaults.standard.data(forKey: expensesKey),
           let decoded = try? JSONDecoder().decode([Expense].self, from: data) {
            expenses = decoded
        }
    }
}

