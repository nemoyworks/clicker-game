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
    
    var body: some View {
        NavigationStack {
            // Background
            ZStack {
                Color.white
                    .ignoresSafeArea()
                // Game UI
                VStack {
                    Text("Score: \(score)")
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    Text("Highest score: \(highestScore)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    Button {
                        userClick()
                    } label: {
                        ClickButton()
                    }
                    
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
                            AnalyticsPage()
                        } label: {
                            Image(systemName: "trophy")
                                .padding()
                                .foregroundStyle(.black)
                                .glassEffect(.regular.tint(.white).interactive())
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
}

struct ClickButton: View {
    var body: some View {
        Image("Button")
            .resizable()
            .scaledToFit()
    }
}

struct RestartButton: View {
    var body: some View {
        Text("Restart")
            .padding()
            .foregroundStyle(.black)
            .glassEffect(.regular.tint(.white).interactive())
        }
    }

struct SettingsPage: View {
    @State private var sounds = true
    
    var body: some View {
        VStack {
            Toggle("Sounds", isOn: $sounds)
                .padding()
                .glassEffect(.regular.tint(.white).interactive())
            
            Spacer()
        }
        .navigationTitle("Settings")
        .padding()
    }
}

struct AnalyticsPage: View {
    
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
