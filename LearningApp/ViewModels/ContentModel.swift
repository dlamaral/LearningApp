//
//  ContentModel.swift
//  LearningApp
//
//  Created by Diogo Amaral on 30/06/2022.
//

import Foundation

class ContentModel: ObservableObject {
    // List of Modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current lesson explanation
    @Published var codeText = NSAttributedString()
    
    // Current question
    @Published var currentQuestion: Questions?
    var currentQuestionIndex = 0
    
    // Current selected content and test
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    var styleData: Data?
    
    init () {
        getLocalData()
    }
    
    // MARK: Data Methods
    func getLocalData() {
        let filePath = Bundle.main.path(forResource: "data", ofType: "json")
        
        guard filePath != nil else {
            return
        }
        
        let url = URL(fileURLWithPath: filePath!)
        
        do {
            let jsonData = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            self.modules = modules
        }
        catch {
            print(error)
        }
        
        // parse the style data
        let stylePath = Bundle.main.path(forResource: "style", ofType: "html")
        
        guard stylePath != nil else {
            return
        }
        
        let styleUrl = URL(fileURLWithPath: stylePath!)
        
        do {
            // read into a data object
            let styleData = try Data(contentsOf: styleUrl)
            
            self.styleData = styleData
        }
        catch {
            print("Couldn't parse the style data.")
        }
        
    }
    
    // MARK: Module navigation methods
    func beginModule(_ moduleid: Int) {
        // Find the index for the module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                // Found the matching module
                currentModuleIndex = index
                break;
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex: Int) {
        // Check that the lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }
        // Set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        // Advance the lesson index
        currentLessonIndex += 1
        
        // Check that is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        } else {
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool {
        return (currentLessonIndex+1 < currentModule!.content.lessons.count)
    }
    
    func beginTest(_ moduleId: Int) {
        // Set the current module
        beginModule(moduleId)
        // Set the current question
        currentQuestionIndex = 0
        // If htere are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 >  0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            // Set the question content
            codeText = addStyling(currentQuestion!.content) 
        }
    }
    
    func nextQuestion() {
        // Advance the question index
        currentQuestionIndex += 1
        
        // Check that is within range
        if currentQuestionIndex < currentModule!.test.questions.count {
            // Set the current question property
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        } else {
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    // MARK: Code Styling
    
    private func addStyling (_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add the styling data
        if styleData != nil {
            data.append(self.styleData!)
        }
        // Add the HMTL data
        data.append(Data(htmlString.utf8))
        
        // Convert to NSAttributedString
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        }
        
        return resultString
    }
}
