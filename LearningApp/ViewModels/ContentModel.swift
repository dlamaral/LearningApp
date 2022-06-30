//
//  ContentModel.swift
//  LearningApp
//
//  Created by Diogo Amaral on 30/06/2022.
//

import Foundation

class ContentModel: ObservableObject {
    @Published var modules = [Module]()
    
    var styleData: Data?
    
    init () {
        getLocalData()
    }
    
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
}
