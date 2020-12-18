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
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                ScrollView {
                    
                    VStack {
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                VM.pickerBool.toggle()
                            }                            .foregroundColor(.accentColor)

                    }.frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    content
                    Spacer()
                }
                
            }.padding(.top, 100)
            .sheet(isPresented: $VM.pickerBool) {
                SwiftUIImagePickerView(images: $VM.image, showPicker: $VM.pickerBool, selectionLimit: 1)
            }
            VStack {
                Text("Photo enhancer!").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text(VM.xmas).foregroundColor(.gray)
                Spacer()
            }.padding(.top, 10)
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        VM.processImage()
                    }){
                        Text("Xmas Colors").bold()
                    }.accentColor(.white)
                    .frame(width: 150,height: 79)
                    .background(Color(red: 0, green:0.5, blue:0))
                    .cornerRadius(30.0)
                    .disabled(VM.imageIsProcessing)
                    
                    Button(action: {
                        VM.save()
                    }){
                        Text("Export").bold()
                    }.accentColor(.white)
                    .frame(width: 150,height: 79)
                    .background(Color(red: 0, green:0.5, blue:0))
                    .cornerRadius(30.0)
                    .disabled(VM.imageIsProcessing || VM.processedImage == nil)
                }
            }
        }.banner(data: $VM.bannerData, show: $VM.showBanner)
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
