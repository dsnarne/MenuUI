//
//  EditExpenseView.swift
//  IntroSwiftApp
//
//  View for editing existing expenses
//

import SwiftUI

struct EditExpenseView: View {
    let expense: Expense
    @ObservedObject var expenseManager: ExpenseManager
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String
    @State private var amount: String
    @State private var category: Expense.Category
    @State private var date: Date
    @State private var notes: String
    
    init(expense: Expense, expenseManager: ExpenseManager) {
        self.expense = expense
        self.expenseManager = expenseManager
        _title = State(initialValue: expense.title)
        _amount = State(initialValue: String(format: "%.2f", expense.amount))
        _category = State(initialValue: expense.category)
        _date = State(initialValue: expense.date)
        _notes = State(initialValue: expense.notes)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Expense Details") {
                    TextField("Title", text: $title)
                    
                    HStack {
                        Text("Amount")
                        Spacer()
                        TextField("0.00", text: $amount)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                    }
                    
                    Picker("Category", selection: $category) {
                        ForEach(Expense.Category.allCases, id: \.self) { category in
                            HStack {
                                Image(systemName: category.icon)
                                Text(category.rawValue)
                            }
                            .tag(category)
                        }
                    }
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                
                Section("Notes") {
                    TextField("Add notes (optional)", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section {
                    Button(role: .destructive) {
                        expenseManager.deleteExpense(expense)
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Delete Expense")
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Edit Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveExpense()
                    }
                    .disabled(title.isEmpty || amount.isEmpty || Double(amount) == nil)
                }
            }
        }
    }
    
    func saveExpense() {
        guard let amountValue = Double(amount) else { return }
        
        var updatedExpense = expense
        updatedExpense.title = title
        updatedExpense.amount = amountValue
        updatedExpense.category = category
        updatedExpense.date = date
        updatedExpense.notes = notes
        
        expenseManager.updateExpense(updatedExpense)
        dismiss()
    }
}

#Preview {
    EditExpenseView(
        expense: Expense(
            title: "Sample Expense",
            amount: 25.50,
            category: .food,
            date: Date(),
            notes: "Lunch"
        ),
        expenseManager: ExpenseManager()
    )
}

