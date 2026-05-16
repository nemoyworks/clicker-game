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
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                Text("Highest score: \(highestScore)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                VStack {
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
        Image(systemName: "arrow.trianglehead.clockwise")
            .foregroundStyle(.black)
            .padding()
            .glassEffect(.regular.tint(.white).interactive())
        }
    }


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
