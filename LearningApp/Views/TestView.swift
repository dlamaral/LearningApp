//
//  TestView.swift
//  LearningApp
//
//  Created by Diogo Amaral on 07/07/2022.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack {
                // Question Number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                // Question
                CodeTextView()
                
                // Answer
                
                
                // Button
                
            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
        } else {
            // Test hasn't loaded
            ProgressView()
        }
    }
    
    
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
