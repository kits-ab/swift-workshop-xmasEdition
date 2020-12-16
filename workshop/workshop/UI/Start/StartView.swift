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
                ImagesView(images: VM.images)
            }
        }
        .sheet(isPresented: $VM.pickerBool) {
            SwiftUIImagePickerView(images: $VM.images, showPicker: $VM.pickerBool, selectionLimit: 3)
        }
    }
    
    struct ImagesView: View {
        @State var index = 0

        var images: [UIImage] = []

        var body: some View {
            VStack(spacing: 20) {
                PagingView(index: $index.animation(), maxIndex: images.count - 1) {
                    ForEach(self.images, id: \.self) { imageName in
                        Image(uiImage: imageName)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .aspectRatio(4/3, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 15))

//                PagingView(index: $index.animation(), maxIndex: images.count > 0 ? (images.count - 1) : 0) {
//                    ForEach(self.images, id: \.self) { imageName in
//                        Image(uiImage: imageName)
//                            .resizable()
//                            .scaledToFill()
//                    }
//                }
//                .aspectRatio(3/4, contentMode: .fit)
//                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                images.count > 0 ?
                Stepper("Index: \(index)", value: $index.animation(.easeInOut), in: 0...images.count-1)
                    .font(Font.body.monospacedDigit()) : nil
            }
            .padding()
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
