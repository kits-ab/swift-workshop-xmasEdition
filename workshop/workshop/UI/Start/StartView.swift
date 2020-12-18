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
            Text("Photo enhancer!").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text(VM.xmas).foregroundColor(.gray)
        }.padding(.top, 10)
        Spacer()
        VStack {
            VStack {
                Image(systemName: "camera.viewfinder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        VM.pickerBool.toggle()
                    }
            }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            content
        }
        .sheet(isPresented: $VM.pickerBool) {
            SwiftUIImagePickerView(images: $VM.image, showPicker: $VM.pickerBool, selectionLimit: 1)
        }
        Spacer()
    }
    
    private var content : AnyView {
        switch VM.loadableImage {
        case .notRequested:
            VM.loadImage()
            return AnyView(Text("Not requested"))
        case .isLoading(_, _):
            return AnyView(Text("Loading..."))
        case let .loaded(image):
            return AnyView(loadedView(image))
        case .failed(_):
            return AnyView(Text("Nothing to show"))
        }
    }
    
    private func loadedView(_ image: Images) -> some View {
        VStack {
            Image(uiImage: image.img)
                .resizable()
                .frame(width: 300, height: 200)
                .cornerRadius(20)
            HStack {
                Button("Xmas Colors") {
                    VM.processImage()
                }.accentColor(.red)
                .background(Color.green)
                .cornerRadius(5.0)
                .padding()
                .disabled(VM.imageIsProcessing)
                Button("Export") {
                    VM.save()
                    print("Export")
                }.accentColor(.red)
                .background(Color.green)
                .cornerRadius(5.0)
                .padding()
                .disabled(VM.imageIsProcessing)
            }
            if VM.imageIsProcessing {
                ProgressView("Processing Image...")
            } else {
                if let processedImage = VM.processedImage {
                    Image(uiImage: processedImage)
                        .resizable()
                        .frame(width: 300, height: 200)
                        .cornerRadius(20)
                }
            }
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
//
//                images.count > 0 ?
//                Stepper("Index: \(index)", value: $index.animation(.easeInOut), in: 0...images.count-1)
//                    .font(Font.body.monospacedDigit()) : nil
            }
            .padding()
        }
    }
}

// MARK: - Previewer
#if DEBUG
struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(viewModel: .init(container: .preview))
    }
}
#endif
