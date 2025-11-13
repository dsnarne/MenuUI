//
//  ExpenseListView.swift
//  IntroSwiftApp
//
//  Main list view for Expense Tracker app
//

import SwiftUI

struct ExpenseListView: View {
    @StateObject private var expenseManager = ExpenseManager()
    @State private var showingAddExpense = false
    @State private var selectedExpense: Expense?
    @State private var selectedCategory: Expense.Category? = nil
    @State private var searchText = ""
    @State private var selectedPeriod: Period = .all
    
    enum Period: String, CaseIterable {
        case today = "Today"
        case week = "This Week"
        case month = "This Month"
        case all = "All Time"
    }
    
    var filteredExpenses: [Expense] {
        var filtered = expenseManager.expenses
        
        // Filter by period
        let calendar = Calendar.current
        let now = Date()
        
        switch selectedPeriod {
        case .today:
            filtered = filtered.filter { calendar.isDateInToday($0.date) }
        case .week:
            if let weekStart = calendar.dateInterval(of: .weekOfYear, for: now)?.start {
                filtered = filtered.filter { $0.date >= weekStart }
            }
        case .month:
            if let monthStart = calendar.dateInterval(of: .month, for: now)?.start {
                filtered = filtered.filter { $0.date >= monthStart }
            }
        case .all:
            break
        }
        
        // Filter by category
        if let category = selectedCategory {
            filtered = filtered.filter { $0.category == category }
        }
        
        // Filter by search text
        if !searchText.isEmpty {
            filtered = filtered.filter { expense in
                expense.title.localizedCaseInsensitiveContains(searchText) ||
                expense.notes.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return filtered.sorted { $0.date > $1.date }
    }
    
    var totalForFiltered: Double {
        filteredExpenses.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Summary card
                SummaryCard(total: totalForFiltered, count: filteredExpenses.count)
                    .padding()
                    .background(Color(.systemGray6))
                
                // Period filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(Period.allCases, id: \.self) { period in
                            PeriodFilterButton(
                                period: period,
                                selectedPeriod: $selectedPeriod
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(Color(.systemGray6))
                
                // Category filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        CategoryFilterButton(
                            category: nil,
                            selectedCategory: $selectedCategory,
                            label: "All"
                        )
                        
                        ForEach(Expense.Category.allCases, id: \.self) { category in
                            CategoryFilterButton(
                                category: category,
                                selectedCategory: $selectedCategory,
                                label: category.rawValue,
                                icon: category.icon
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(Color(.systemGray6))
                
                // Expenses list
                if filteredExpenses.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "creditcard")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("No expenses found")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text("Tap + to add your first expense")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(filteredExpenses) { expense in
                            ExpenseRowView(expense: expense)
                                .onTapGesture {
                                    selectedExpense = expense
                                }
                        }
                        .onDelete { indexSet in
                            let expensesToDelete = indexSet.map { filteredExpenses[$0] }
                            for expense in expensesToDelete {
                                expenseManager.deleteExpense(expense)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Expense Tracker")
            .searchable(text: $searchText, prompt: "Search expenses...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView(expenseManager: expenseManager)
            }
            .sheet(item: $selectedExpense) { expense in
                EditExpenseView(expense: expense, expenseManager: expenseManager)
            }
        }
    }
}

struct SummaryCard: View {
    let total: Double
    let count: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Total Expenses")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(formatCurrency(total))
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("Count")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(count)")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }
}

struct PeriodFilterButton: View {
    let period: ExpenseListView.Period
    @Binding var selectedPeriod: ExpenseListView.Period
    
    var body: some View {
        Button {
            selectedPeriod = period
        } label: {
            Text(period.rawValue)
                .font(.subheadline)
                .fontWeight(selectedPeriod == period ? .semibold : .regular)
                .foregroundColor(selectedPeriod == period ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(selectedPeriod == period ? Color.blue : Color(.systemGray5))
                .cornerRadius(20)
        }
    }
}

struct CategoryFilterButton: View {
    let category: Expense.Category?
    @Binding var selectedCategory: Expense.Category?
    let label: String
    var icon: String? = nil
    
    var isSelected: Bool {
        selectedCategory == category
    }
    
    var body: some View {
        Button {
            selectedCategory = isSelected ? nil : category
        } label: {
            HStack(spacing: 4) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.caption)
                }
                Text(label)
                    .font(.subheadline)
            }
            .fontWeight(isSelected ? .semibold : .regular)
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.blue : Color(.systemGray5))
            .cornerRadius(20)
        }
    }
}

struct ExpenseRowView: View {
    let expense: Expense
    
    var body: some View {
        HStack(spacing: 12) {
            // Category icon
            Image(systemName: expense.category.icon)
                .font(.title2)
                .foregroundColor(Color(expense.category.color))
                .frame(width: 40, height: 40)
                .background(Color(expense.category.color).opacity(0.1))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.title)
                    .font(.headline)
                
                HStack(spacing: 8) {
                    Text(expense.category.rawValue)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("•")
                        .foregroundColor(.secondary)
                    
                    Text(expense.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Text(formatCurrency(expense.amount))
                .font(.headline)
                .foregroundColor(.red)
        }
        .padding(.vertical, 4)
    }
    
    func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }
}

#Preview {
    ExpenseListView()
}

