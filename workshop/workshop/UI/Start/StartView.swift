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
            VStack {
                Image(systemName: "camera.viewfinder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        VM.pickerBool.toggle()
                    }
            }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            VStack {
                List(0..<VM.images.count) { i in
                    Image(uiImage: VM.images[i]).resizable().aspectRatio(contentMode: .fit)
                }.id(UUID())
            }.frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .sheet(isPresented: $VM.pickerBool) {
            SwiftUIImagePickerView(images: $VM.images, showPicker: $VM.pickerBool, selectionLimit: 3)
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
