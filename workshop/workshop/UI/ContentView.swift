//
//  ContentView.swift
//  workshop
//
//  Created by Emma Stålesjö on 2020-12-15.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        StartView(viewModel: .init())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
