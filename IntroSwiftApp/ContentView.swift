//
//  ContentView.swift
//  IntroSwiftApp
//
//  Main view of the application
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    @State private var message = "Welcome to Swift!"
    
    var body: some View {
        VStack(spacing: 30) {
            // Title
            Text("Intro Swift App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // Message display
            Text(message)
                .font(.title2)
                .foregroundColor(.blue)
                .padding()
            
            // Counter display
            Text("Counter: \(counter)")
                .font(.title)
                .padding()
            
            // Button to increment counter
            Button(action: {
                counter += 1
                message = counter % 5 == 0 ? "Great job! 🎉" : "Keep going!"
            }) {
                Text("Tap Me!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            // Reset button
            Button(action: {
                counter = 0
                message = "Welcome to Swift!"
            }) {
                Text("Reset")
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
