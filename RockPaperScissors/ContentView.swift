//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Daniel Pape on 13/04/2021.
//

// - Each turn of the game the app will randomly pick either rock, paper, or scissors.
// - Each turn the app will either prompt the player to win or lose.
// - The player must then tap the correct move to win or lose the game.
// - If they are correct they score a point; otherwise they lose a point.
// - The game ends after 10 questions, at which point their score is shown.

import SwiftUI

struct ContentView: View {
    
    @State var randomPick:Int = 1
    @State var shouldWin:Bool = true
    @State var pickRequired:Int = 0
    @State var displayingResult = false
    @State var AlertTitle:String = ""
    
    @State var score:Int = 0
    @State var CompletedQuestions: Int = 0
    @State var finishedQuiz = false
    let options = ["Rock 🪨","Paper 📃","Scissors ✂️"]
    var availableOptions = [String]()
    
    
    func optionTapped(_ option:Int){
        if(option == pickRequired){
            AlertTitle="That's right!"
            score += 1
            CompletedQuestions += 1
            ResetGame()

        } else {
            AlertTitle="That's wrong!"
            CompletedQuestions += 1
            ResetGame()

        }
        if CompletedQuestions == 10 {
            finishedQuiz = true
            displayAlert()
        }
    }
    func displayAlert(){
        displayingResult.toggle()
    }
    
    func StartNewGame(){
        score = 0
        CompletedQuestions = 0
        ResetGame()
    }
    
    func ResetGame(){
        randomPick = Int.random(in: 0...2)
        shouldWin = Bool.random()
        
        if(randomPick == 0 && shouldWin){
            pickRequired = 1
        }else if(randomPick == 1 && shouldWin){
            pickRequired = 2
        }else if(randomPick == 2 && shouldWin){
            pickRequired = 0
        }else if(randomPick == 0 && !shouldWin){
            pickRequired = 2
        }else if(randomPick == 1 && !shouldWin){
            pickRequired = 0
        }else if(randomPick == 2 && !shouldWin){
            pickRequired = 1
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.green,.blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .opacity(0.3)
                VStack(spacing: 20){
                    Text("I choose \(options[randomPick])")
                    Text(shouldWin ? "Which should you choose to win?" : "Which should you choose to lose?")
                    ForEach(0..<3){ option in
                        Button(action: {
                            self.optionTapped(option)
                        }){
                            Text(options[option])
                        }
                        .frame(minWidth: 300, minHeight: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16.0)
                        
                    }
                }
                .alert(isPresented: $displayingResult, content: {
                    Alert(title: Text("Quiz finished"), message: Text("You have scored \(score) / \(CompletedQuestions)"), dismissButton: .default(Text("Reset"), action: StartNewGame))
                })
                .navigationTitle(Text("Rock Paper Scissors"))
                .navigationBarItems(trailing: Text("\(score) / \(CompletedQuestions)"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(randomPick: 0, shouldWin: true)
    }
}
