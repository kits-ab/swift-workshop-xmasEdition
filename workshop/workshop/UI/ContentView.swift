//
//  ContentView.swift
//  workshop
//
//  Created by Emma Stålesjö on 2020-12-15.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private(set) var VM: ViewModel
    
    init(viewModel: ViewModel) {
        self.VM = viewModel
    }

    var body: some View {
        StartView(viewModel: .init())
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        let container: DIContainer
        
        init(container: DIContainer) {
            self.container = container
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
