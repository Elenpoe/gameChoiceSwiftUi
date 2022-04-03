//
//  ContentView.swift
//  gameChoiceSwiftUi
//
//  Created by Helen Poe on 26.03.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Greece","Sweden","Italy","Israel","Poland","UK","USA","Ukraine","Japan"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var totalScore = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack{
            Color.init(#colorLiteral(red: 1, green: 0.9599953294, blue: 0.9191313386, alpha: 1))
                .ignoresSafeArea()
            VStack(spacing: 15){
                VStack{
                    Text("Choose a flag:")
                        .font(.headline)
                        .foregroundColor(Color.init(#colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)))
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.init(#colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1))))
                    }
                }
                Text("Total score: \(totalScore)")
                    .font(.largeTitle)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)))
            }
            
        } .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Total score: \(totalScore)"), dismissButton: .default(Text("Next")) {
                self.askQestion()
            })
        }
    }
    func askQestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Great!"
            totalScore += 1
        } else {
            scoreTitle = "Oh no! This is \(countries[number]) flag."
            totalScore -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
