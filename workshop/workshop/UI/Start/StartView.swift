//
//  StartView.swift
//  workshop
//
//  Created by Emma Stålesjö on 2020-12-15.
//

import SwiftUI

struct StartView: View {
    
    @ObservedObject var VM: ViewModel
    
    init(viewModel: ViewModel) {
        VM = viewModel
    }
    
    var body: some View {
        
        VStack {
            Text("Swift Workshop!").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding()
            Text(VM.xmas).foregroundColor(.gray)
            Image(systemName: "camera.viewfinder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onTapGesture {
                    self.pickerBool.toggle()
                }
        }
        .sheet(isPresented: self.$pickerBool) {
            SwiftUIImagePickerView(images: self.$images, showPicker: self.$pickerBool, selectionLimit: 3)
        }
    }
}

// MARK: - Previewer
#if DEBUG
struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(viewModel: StartView.ViewModel.init())
    }
}
#endif
