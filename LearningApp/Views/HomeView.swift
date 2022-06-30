//
//  ContentView.swift
//  LearningApp
//
//  Created by Diogo Amaral on 30/06/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mode: ContentModel
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
