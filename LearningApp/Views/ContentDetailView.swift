//
//  ContenDetailView.swift
//  LearningApp
//
//  Created by Diogo Amaral on 02/07/2022.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            // Show video if we get a valid URL.
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            // TODO: Description
            CodeTextView()
            
            // Next lesson button only if there is a next lesson
            if model.hasNextLesson() {
                Button(action: {
                    model.nextLesson()
                }, label: {
                    ZStack {
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .bold()
                            .foregroundColor(Color.white)
                    }
                })
            } else {
                // Show the complete button
                Button(action: {
                    model.currentContentSelected = nil
                }, label: {
                    ZStack {
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        Text("Complete")
                            .bold()
                            .foregroundColor(Color.white)
                    }
                })
            }
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
    }
}

//struct ContentDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentDetailView()
//    }
//}
