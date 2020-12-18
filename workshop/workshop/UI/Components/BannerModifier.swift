//
//  BannerModifier.swift
//  shibun (iOS)
//
//  Created by Emma Stålesjö on 2020-09-14.
//

import SwiftUI

struct BannerModifier: ViewModifier {
    struct BannerData {
        var title: LocalizedStringKey
        var detail: LocalizedStringKey
        var type: BannerType
    }
    
    @Binding var data: BannerData
    @Binding var show: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content.zIndex(0)
            if show {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(data.title)
                                .bold()
                            Text(data.detail)
                                .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                        }
                        Spacer()
                    }
                    .foregroundColor(Color.white)
                    .padding(12)
                    .background(data.type.tintColor)
                    .cornerRadius(8)
                    Spacer()
                }
                .padding()
                .animation(.easeInOut)
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                .onTapGesture {
                    withAnimation {
                        self.show = false
                    }
                }.onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation {
                            self.show = false
                        }
                    }
                })
                .zIndex(1)
                Spacer()
            }
        }
    }
}

enum BannerType {
    case Info
    case Warning
    case Success
    case Error
    
    var tintColor: Color {
        switch self {
        case .Info:
            return Color(red: 67/255, green: 154/255, blue: 215/255)
        case .Success:
            return Color.blue
        case .Warning:
            return Color.yellow
        case .Error:
            return Color.red
        }
    }
}

extension View {
    func banner(data: Binding<BannerModifier.BannerData>, show: Binding<Bool>) -> some View {
        self.modifier(BannerModifier(data: data, show: show))
    }
}

struct BannerModifier_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper(bannerData: BannerModifier.BannerData(title: "Success!", detail: "You made a banner appear", type: .Success))
    }
    
    struct PreviewWrapper: View {
        @State var showBanner: Bool = false
        @State var bannerData: BannerModifier.BannerData
        
        var body: some View {
            VStack {
                Button("Success") {
                    showBanner = true
                    bannerData = BannerModifier.BannerData(title: "Success!", detail: "You made a banner appear", type: .Success)
                }
                
                Button("Warning") {
                    showBanner = true
                    bannerData = BannerModifier.BannerData(title: "Warning!", detail: "You made a banner appear", type: .Warning)
                }
                
                Button("Info") {
                    showBanner = true
                    bannerData = BannerModifier.BannerData(title: "Info!", detail: "You made a banner appear", type: .Info)
                }
                
                Button("Error") {
                    showBanner = true
                    bannerData = BannerModifier.BannerData(title: "Error!", detail: "You made a banner appear", type: .Error)
                }
            }.banner(data: $bannerData, show: $showBanner)
        }
    }
}
