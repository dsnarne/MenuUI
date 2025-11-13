# IntroSwiftApp

A comprehensive iOS application built with SwiftUI featuring three advanced projects: Recipe Book, Expense Tracker, and Photo Gallery. Perfect for learning Swift and iOS development!

## 📱 Features

### 🍳 Recipe Book
- Browse and search recipes with category filtering
- View detailed recipes with ingredients and step-by-step instructions
- Add custom recipes with full ingredient lists
- Beautiful UI with category icons and difficulty indicators
- Sample recipes included

### 💰 Expense Tracker
- Track expenses by category (Food, Transportation, Shopping, etc.)
- Filter by time period (Today, This Week, This Month, All Time)
- Add, edit, and delete expenses
- Persistent storage using UserDefaults
- Summary card showing total expenses
- Search functionality

### 📸 Photo Gallery
- Beautiful grid layout with adjustable columns (1, 2, or 3)
- Full-screen photo detail view
- Pinch to zoom and drag to pan gestures
- Search photos by name or description
- Smooth animations and transitions
- 12 sample photos included

### 🎯 Counter App (Original)
- Simple counter with state management
- Demonstrates basic SwiftUI concepts
- Great starting point for beginners

## 🏗️ Project Structure

```
IntroSwiftApp/
├── IntroSwiftApp/
│   ├── IntroSwiftAppApp.swift          # App entry point
│   ├── MainMenuView.swift              # Main navigation menu
│   ├── ContentView.swift               # Original counter app
│   │
│   ├── RecipeBook/
│   │   ├── Recipe.swift                # Recipe data model
│   │   ├── RecipeListView.swift        # Recipe list with search/filter
│   │   ├── RecipeDetailView.swift       # Recipe detail view
│   │   └── AddRecipeView.swift          # Add/edit recipe form
│   │
│   ├── ExpenseTracker/
│   │   ├── Expense.swift                # Expense model & manager
│   │   ├── ExpenseListView.swift       # Expense list with filters
│   │   ├── AddExpenseView.swift         # Add expense form
│   │   └── EditExpenseView.swift        # Edit expense form
│   │
│   └── PhotoGallery/
│       ├── PhotoItem.swift              # Photo data model
│       ├── PhotoGalleryView.swift       # Grid gallery view
│       └── PhotoDetailView.swift        # Detail view with gestures
│
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- macOS (required for Xcode)
- Xcode 14.0 or later
- iOS 15.0+ deployment target

### Installation

1. **Clone the repository**
   ```bash
   git clone git@github.com:dsnarne/MenuUI.git
   cd MenuUI
   ```

2. **Open in Xcode**
   - Open Xcode
   - File → New → Project
   - Choose **iOS → App**
   - Name: `IntroSwiftApp`
   - Interface: **SwiftUI** ⚠️ (Important!)
   - Language: **Swift**

3. **Add Files to Project**
   - Drag all files from `IntroSwiftApp/` folder into Xcode's Project Navigator
   - When prompted:
     - ✅ Copy items if needed
     - ✅ Create groups
     - ✅ Add to targets: IntroSwiftApp

4. **Run the App**
   - Select an iOS Simulator (iPhone 15 Pro, etc.)
   - Press `⌘R` or click the Play button
   - The app will launch in the simulator!

## 📖 Key Concepts Demonstrated

### SwiftUI Fundamentals
- **Views**: Building UI with declarative syntax
- **State Management**: `@State`, `@StateObject`, `@ObservedObject`
- **Navigation**: `NavigationView`, `NavigationLink`
- **Lists**: Displaying data with `List` and `ForEach`
- **Forms**: User input with `Form` and various controls

### Advanced Features
- **Data Persistence**: UserDefaults for expense tracking
- **Search & Filtering**: Real-time search and category filters
- **Gestures**: Pinch-to-zoom and drag-to-pan in photo gallery
- **Custom Components**: Reusable UI components
- **Data Models**: Structs, enums, and Codable protocol

## 🎓 Learning Path

This project is organized to teach Swift and iOS development progressively:

1. **Start with Counter App** - Basic SwiftUI and state management
2. **Explore Recipe Book** - Complex data models and navigation
3. **Try Expense Tracker** - Data persistence and CRUD operations
4. **Check Photo Gallery** - Gestures and advanced UI interactions

## 🛠️ Technologies Used

- **SwiftUI** - Modern declarative UI framework
- **Swift** - Apple's programming language
- **UserDefaults** - Lightweight data persistence
- **iOS Simulator** - For testing and development

## 📝 Code Examples

### Adding a New Recipe
```swift
let newRecipe = Recipe(
    name: "Pasta Carbonara",
    description: "Classic Italian pasta dish",
    prepTime: 15,
    cookTime: 20,
    servings: 4,
    difficulty: .medium,
    ingredients: [...],
    instructions: [...],
    category: .dinner
)
```

### Adding an Expense
```swift
let expense = Expense(
    title: "Groceries",
    amount: 45.99,
    category: .food,
    date: Date(),
    notes: "Weekly shopping"
)
expenseManager.addExpense(expense)
```

## 🎨 Screenshots

*Add screenshots of your app here when you have them!*

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Built with SwiftUI and Swift
- Sample recipes and photos for demonstration
- Inspired by Apple's SwiftUI tutorials

## 📚 Resources

- [Swift Documentation](https://swift.org/documentation/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Apple Developer Documentation](https://developer.apple.com/documentation/)

## 🔮 Future Enhancements

- [ ] Recipe editing functionality
- [ ] Photo persistence and camera integration
- [ ] Expense charts and analytics
- [ ] Dark mode optimizations
- [ ] iCloud sync for expenses
- [ ] Recipe sharing
- [ ] Export expenses to CSV

---

Made with ❤️ using SwiftUI
