//
//  ContentView.swift
//  Clicker
//
//  Created by Ростислав Гайда on 15.05.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var score = 0
    @State private var highestScore = 0
    
    @State private var circleScale = 1.0
    
    var body: some View {
        NavigationStack {
            // Background
            ZStack {
                // Game UI
                VStack {
                    Text("Score: \(score)")
                        .font(.largeTitle)
                        .foregroundStyle(.primary)
                    Text("Highest score: \(highestScore)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    // Main Button
                    Button {
                        userClick()
                    } label: {
                        Image("Button")
                            .resizable()
                            .scaledToFit()
                            // Circle animation
                            .overlay(
                                Circle()
                                    .stroke(.red)
                                    .frame(width: 350, height: 350)
                                    .scaleEffect(circleScale)
                                    .opacity(2.0 - circleScale)
                                    .animation(
                                        .easeOut(duration: 1.5)
                                        .repeatCount(3, autoreverses: false),
                                        value: circleScale
                                    )
                            )
                            .onAppear {
                                circleScale = 2.0
                            }
                    }
                    // Restart Button
                    Button {
                        gameRestart()
                    } label: {
                        RestartButton()
                    }
                }
                // Settings
                VStack {
                    HStack {
                        Spacer()
                        
                        NavigationLink() {
                            SettingsPage()
                        } label: {
                            Image(systemName: "gearshape")
                                .padding()
                                .foregroundStyle(.black)
                                .glassEffect(.regular.tint(.white).interactive())
                                .shadow(radius: 1)
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Achievements
                VStack {
                    HStack {
                        NavigationLink() {
                            AchievementsPage()
                        } label: {
                            Image(systemName: "trophy")
                                .padding()
                                .foregroundStyle(.black)
                                .glassEffect(.regular.tint(.white).interactive())
                                .shadow(radius: 1)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }
    }
    
    func userClick() {
        score += 1
        
        if score > highestScore {
            highestScore = score
        }
    }
    
    func gameRestart() {
        score = 0
    }
    
    func gameReset() {
        score = 0
        highestScore = 0
    }
}

struct RestartButton: View {
    var body: some View {
        Text("Restart")
            .padding()
            .foregroundStyle(.black)
            .glassEffect(.regular.tint(.white).interactive())
            .shadow(radius: 1)
        }
    }

struct ResetProgress: View {
    var body: some View {
        Text("Restart progress")
            .padding()
            .foregroundStyle(.red)
            .glassEffect(.regular.tint(.white).interactive())
    }
}

struct SettingsPage: View {
    @State private var sounds = true
    @State private var haptics = true
    @State private var darkMode = false
    @State private var showAlert = false
    
    let alertTitle = "Warning!"
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                    Toggle("Sounds", isOn: $sounds)
                    
                    Toggle("Haptics", isOn: $haptics)
                    
                    Toggle("Dark mode", isOn: $darkMode)
                    
                }
            }
            VStack {
                Spacer()
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Reset progress")
                        .padding()
                        .foregroundStyle(.white)
                        .glassEffect(.regular.tint(.red).interactive())
                }
            }
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button(role: .destructive) {
                // Delete progress
            } label: {
                Text("Delete")
            }
        } message: {
            Text("This will permanently erase all game data.")
        }
        .navigationTitle("Settings")
        
    }
}


struct AchievementsPage: View {
    
    var body: some View {
        VStack {
        }
        .navigationTitle("Achievements")
    }
}
    
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
