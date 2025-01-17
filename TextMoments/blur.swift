//
//  blur.swift
//  TextMoments
//
//  Created by  玉城 on 2024/8/9.
//

import SwiftUI
import PhotosUI
import Foundation


let colors: [Color] = [DataColor.hexToColor(hex:"#9f96ec"), DataColor.hexToColor(hex:"#ec96dd"), DataColor.hexToColor(hex:"#96ecc5"),DataColor.hexToColor(hex:"#ffd0a7")
                       ,DataColor.hexToColor(hex:"#85f1f8"),DataColor.hexToColor(hex:"#f4e884")
                       ,DataColor.hexToColor(hex:"#ff6a6a")
]

func getRandomColor() -> Color {
    return colors.randomElement() ?? .black
}

struct Ball: Identifiable {
    let id = UUID()
    var color: Color
    var offset: CGSize
    var lastDragValue: CGSize = .zero
}
struct BlurView: View {
    @State private var selectedTab = 0
    let tabs = ["数量", "大小", "模糊", "文字"]
    @State private var balls: [Ball] = [Ball(color: .blue, offset: .zero)]
    @State private var circleSize: CGFloat = 200.0
    @State private var blurRadius: CGFloat = 50.0
    @State private var inputText: String = ""
    @State private var inputTextColor: Color = .black
    @State private var inputTextSize: CGFloat = 68.0
    

 
    @State private var showToast: Bool = false
    @State private var showToast1: Bool = false
    @AppStorage("isPurchased") var isPurchased: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    
    func createCardView() -> some View {
        
        ZStack {
            ForEach($balls) { $ball in
                Circle()
                    .fill(ball.color)
                    .frame(width: circleSize, height: circleSize)
                    .blur(radius: blurRadius)
                    .offset(ball.offset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                ball.offset = CGSize(
                                    width: ball.lastDragValue.width + value.translation.width,
                                    height: ball.lastDragValue.height + value.translation.height
                                )
                            }
                            .onEnded { value in
                                ball.lastDragValue = ball.offset
                            }
                    )
            }
            
            if inputText.isEmpty {
                Text("请输入文字")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: inputTextSize))
                    .allowsHitTesting(false)
                    .foregroundColor(inputTextColor)
                    .padding(.top, 10)     // 上边距
                    .padding(.bottom, 10)  // 下边距
                    .padding(.leading, 22) // 左边距
                    .padding(.trailing, 22) // 右边距
            }else {
                Text(inputText)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: inputTextSize))
                    .allowsHitTesting(false)
                    .foregroundColor(inputTextColor)
                    .padding(.top, 10)     // 上边距
                    .padding(.bottom, 10)  // 下边距
                    .padding(.leading, 22) // 左边距
                    .padding(.trailing, 22) // 右边距
            }
          
        
            
            
            VStack{
                Spacer()
                HStack{
                    //                    Spacer()
                    if !isPurchased {
                        Text("@DiffuseCard")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 10))
                            .allowsHitTesting(false)
                            .foregroundColor(.white)
                            .padding(.top, 10)     // 上边距
                            .padding(.bottom, 10)  // 下边距
                            .padding(.leading, 22) // 左边距
                            .padding(.trailing, 22) // 右边距
                            .shadow(color: DataColor.hexToColor(hex:"#4b495c").opacity(0.3), radius: 1)
                    }
                    
                    
                    
                }
                Spacer().frame(height: 40)
                
            }
            
            
            
            
        }
        //                .frame(maxWidth: .infinity, height: 1020)
        
        //                .frame(maxWidth: .infinity, height: 520)
        
        
        .frame(width: 400, height: 480)
        .background(.white)
        .clipped()
        //        .shadow(radius: 0)
        //        .padding(0)
        //        .cornerRadius(0)
        //        .shadow(color: DataColor.hexToColor(hex:"#4b495c").opacity(0.1), radius: 16)
    }
    
    
    
    
    var body: some View {
        let CoreCard = createCardView()
        NavigationStack {
            ZStack {
                
                DataColor.hexToColor(hex:"#f7f6ff")
                    .edgesIgnoringSafeArea(.all)
                
                
               
                VStack(spacing: 0) {
                    Spacer().frame(width: 400,height:40).background(DataColor.hexToColor(hex:"#f7f6ff")).padding(0)
                        .padding(.bottom, 2)  // 下边距
                    HStack{
                        Spacer().frame(width: 10)
                        
                        
                        NavigationLink(destination: SettingView()) {
                            Image(systemName: "gearshape")
                                .foregroundColor(DataColor.hexToColor(hex:"#6e61e5"))
                                .font(.system(size: 24))
                                .frame(width: 40,height: 40)
                        }
                        Spacer()
                        
                        if !isPurchased  {
                            NavigationLink(destination: SettingView()) {
                                
                                ZStack{
                                    ZStack{
                                        Rectangle().foregroundStyle(
                                            // c0a3e9
                                            LinearGradient(gradient: Gradient(colors: [
                                                DataColor.hexToColor(hex:"71c0fa"),
                                                DataColor.hexToColor(hex:"c0a3e9"),
                                                DataColor.hexToColor(hex:"fb92d3"),
                                                DataColor.hexToColor(hex:"fbb589")]),
                                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                                        ).frame(width: 80, height: 42)
                                            .cornerRadius(40)
                                        Text("Pro") .foregroundColor(.white)
                                            .font(.system(size: 16)).fontWeight(.bold)
                                        //                                    Image(systemName: "crown.fill")
                                        //                                        .foregroundColor(.white)
                                        //                                        .font(.system(size: 24))
                                    }
                                    //                            .offset(x: 100, y: 170)
                                }.frame(width: 50, height: 50).padding(.trailing, 20)
                                
                                
                                
                                
                                
                            }
                        }
                        
                        
                        Button(action: {
                            let renderer = ImageRenderer(content: CoreCard)
                            renderer.scale = UIScreen.main.scale
                            renderer.scale = 3.0
                            if let image = renderer.uiImage {
                                let imageSaver = ImageSever()
                                imageSaver.writeToPhotoAlbum(image: image)
                                
                                
                                showToast = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    showToast = false
                                }
                                
                            }}) {
                                Text("保存")
                                    .foregroundColor(DataColor.hexToColor(hex:"#eeecff"))
                                    .fontWeight(.bold)
                                    .padding(.top, 10)
                                    .padding(.bottom, 10)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                    .background(DataColor.hexToColor(hex:"#6e61e5"))
                                    .cornerRadius(40)
                                
                                
                                
                            }
                        
                    } .padding(.top, 10)     // 上边距
                        .padding(.leading, 10) // 左边距
                        .padding(.trailing, 22) // 右边距
                        .zIndex(10)
                    
                    
                    
                    CoreCard
                    
                    
                    
                    
                    
                    
                    // 现有的滑块和颜色选择器保持不变
                    VStack(spacing: 0) {
                        
                        // 横向的文字 Tab
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<tabs.count, id: \.self) { index in
                                    
                                    
                                    if(index == 0 ){
                                        Text("数量")
                                            .padding()
                                        //                                .background(selectedTab == index ? Color.blue : Color.clear)
                                            .fontWeight(selectedTab == index ? .bold  : .regular)
                                            .foregroundColor(selectedTab == index ? .black : DataColor.hexToColor(hex:"#b2b1be") )
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                withAnimation {
                                                    selectedTab = index
                                                }
                                            }
                                    }
                                    if(index == 1 ){
                                        Text("大小")
                                            .padding()
                                        //                                .background(selectedTab == index ? Color.blue : Color.clear)
                                            .fontWeight(selectedTab == index ? .bold  : .regular)
                                            .foregroundColor(selectedTab == index ? .black : DataColor.hexToColor(hex:"#b2b1be") )
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                withAnimation {
                                                    selectedTab = index
                                                }
                                            }
                                    }
                                   
                                    if(index == 2 ){
                                        Text("模糊")
                                            .padding()
                                        //                                .background(selectedTab == index ? Color.blue : Color.clear)
                                            .fontWeight(selectedTab == index ? .bold  : .regular)
                                            .foregroundColor(selectedTab == index ? .black : DataColor.hexToColor(hex:"#b2b1be") )
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                withAnimation {
                                                    selectedTab = index
                                                }
                                            }
                                    }
                                    
                                    if(index == 3 ){
                                        Text("文字")
                                            .padding()
                                        //                                .background(selectedTab == index ? Color.blue : Color.clear)
                                            .fontWeight(selectedTab == index ? .bold  : .regular)
                                            .foregroundColor(selectedTab == index ? .black : DataColor.hexToColor(hex:"#b2b1be") )
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                withAnimation {
                                                    selectedTab = index
                                                }
                                            }
                                    }

                                    
                                }
                                
                                
                                
                                
                            }
                            //                        .padding(.horizontal)
                            .padding(.top, 0)     // 上边距
                            .padding(.bottom, 0)  // 下边距
                            .padding(.leading, 25) // 左边距
                            .padding(.trailing, 10) // 右边距
                        }
                        
                        
                        
                        // 自定义标签栏
                        
                        
                        // 自定义内容显示
                        GeometryReader { geometry in
                            ZStack {
                                if selectedTab == 0 {
                                    VStack{
                                        HStack {
                                            Spacer().frame(width: 30)
                                            
                                            Button(action: {
                                                if !isPurchased {
                                                    let ballCount = balls.count
                                                    if ballCount > 1 {
                                                        showToast1 = true
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                            showToast1 = false
                                                        }
                                                    }else{
                                                        balls.append(Ball(color: getRandomColor(), offset: .zero))
                                                    }
                                                    
                                                }else {
                                                    balls.append(Ball(color: getRandomColor(), offset: .zero))
                                                }
                                                
                                                
                                            }) {
                                                Text("添加圆")
                                                    .foregroundColor(DataColor.hexToColor(hex:"#eeecff"))
                                                    .fontWeight(.bold)
                                                    .padding(.top, 10)
                                                    .padding(.bottom, 10)
                                                    .padding(.leading, 20)
                                                    .padding(.trailing, 20)
                                                    .background(DataColor.hexToColor(hex:"#6e61e5"))
                                                    .cornerRadius(40)
                                                
                                                
                                            }
                                            
                                            
                                            
                                            Spacer()
                                            
                                            Button("重置") {
                                                for i in 0..<balls.count {
                                                    balls[i].offset = .zero
                                                    balls[i].lastDragValue = .zero
                                                }
                                            }
                                            .foregroundColor(DataColor.hexToColor(hex:"#9c92f6"))
                                            .fontWeight(.bold)
                                            Spacer().frame(width: 30)
                                            
                                            
                                        }
                                        HStack{
                                            Spacer().frame(width: 30)
                                            Text("tips: 手指可以拖动圆形改变位置").font(.system(size: 12)) .foregroundColor(DataColor.hexToColor(hex:"#afafaf"))
                                            Spacer()
                                        }.padding(.top, 1)
                                        
                                        
                                        ScrollView(.horizontal, showsIndicators: false){
                                            HStack{
                                                ForEach($balls) { $ball in
                                                    VStack {
                                                        ColorPicker("", selection: $ball.color)
                                                        
                                                        Spacer().frame(height:20)
                                                        
                                                        
                                                        Button(action: {
                                                            deleteBall(ball: ball)
                                                        }) {
                                                            Image(systemName: "trash")
                                                                .foregroundColor(DataColor.hexToColor(hex:"#8b8a95"))
                                                        }.offset(x: 0)
                                                        
                                                        //                                                    .buttonStyle(PlainButtonStyle())
                                                        // 去掉按钮默认样式
                                                        Spacer()
                                                    } .padding(.top, 4)
                                                        .padding(.bottom, 1)
                                                        .padding(.leading, 3)
                                                        .padding(.trailing,3)
                                                }
                                            }
                                            //                                        .background(.red)
                                            .padding(.top, 0)
                                            .padding(.bottom, 10)
                                            .padding(.leading, 30)
                                            .padding(.trailing, 20)
                                            
                                        }
                                        
                                        
                                    }.background(DataColor.hexToColor(hex:"#f7f6ff")).cornerRadius(40)
                                    
                                }
                                
                                if selectedTab == 1 {
                                    
                                    VStack{
                                        
                                        
                                        Slider(value: $circleSize, in: 50...400, step: 1) {
                                            Text("大小")
                                        } .accentColor(DataColor.hexToColor(hex:"#6e61e5"))
                                        Spacer().frame(height: 20)
                                        
//                                        Text("大小: \(circleSize, specifier: "%.1f")")
                                    } .padding(.top, 0)
                                        .padding(.bottom, 70)
                                        .padding(.leading, 70)
                                        .padding(.trailing, 100)
                                    
                                }
                                if selectedTab == 2 {
                                    VStack{
                                        Slider(value: $blurRadius, in: 0...150, step: 1) {
                                            Text("半径")
                                        }.accentColor(DataColor.hexToColor(hex:"#6e61e5"))
                                        
                                        Spacer().frame(height: 20)
//                                        Text(blurRadius)
//                                        Text("半径: \(blurRadius, specifier: "%.1f")")
//                                        Text("大小: \(circleSize, specifier: "%.1f")")
                                        
                                        
                                    }.padding(.top, 0)
                                        .padding(.bottom, 70)
                                        .padding(.leading, 70)
                                        .padding(.trailing, 100)
                                    
                                }
                                
                                if selectedTab == 3 {
                                    VStack {
//                                        
//                                        TextField("请输入文字", text: $inputText)
//                                            .padding()
//                                            .background(Color.white)
//                                            .cornerRadius(30) // 调整这个值来改变圆角程度
//                                            .overlay(
//                                                RoundedRectangle(cornerRadius: 25)
//                                                    .stroke( DataColor.hexToColor(hex:"#6e61e5"), lineWidth: 1) // 自定义边框颜色和宽度
//                                            )
                                        
                            
                                                   VStack {
                                                       Spacer().frame(height: 20)
                                                       
                                                       TextField("请输入文字", text: $inputText)
                                                           .padding(.top, 14)
                                                               .padding(.bottom, 14)
                                                               .padding(.leading, 14)
                                                               .padding(.trailing, 14)
                                                           .background(Color.white)
                                                           .cornerRadius(25)
                                                           .overlay(
                                                               RoundedRectangle(cornerRadius: 25)
                                                                   .stroke(DataColor.hexToColor(hex:"#6e61e5"), lineWidth: 0)
                                                           ).padding()
                                                           
                                                   }
                                                   .padding(.bottom, keyboardHeight)
                                                   .animation(.easeOut(duration: 0.16))
                                                   .onAppear {
                                                       NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                                                           let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
                                                           keyboardHeight = keyboardFrame.height - geometry.safeAreaInsets.bottom + 100
                                                       }
                                                       
                                                       NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                                                           keyboardHeight = 0
                                                       }
                                                   }
                                        
                                        
                                        
                                        
                                        
                                        
                                        ColorPicker("文字颜色", selection: $inputTextColor) .padding(.leading, 30)
                                            .padding(.trailing, 20)
                                        
                                        
                                    
                                        Slider(value: $inputTextSize, in: 12...120, step: 1) {
//                                            Text("大小")
                                        }.accentColor(DataColor.hexToColor(hex:"#6e61e5"))
                                        .padding(.top, 0)
                                            .padding(.bottom, 0)
                                            .padding(.leading, 30)
                                            .padding(.trailing, 30)
//                                        Spacer().frame(height: 20)
                                        
                                        
                                        
                                        
                                    }.padding(.top, 0)
                                        .padding(.bottom, 80)
                                        .padding(.leading, 30)
                                        .padding(.trailing, 50)
                                }
                                
                                
                                
                                
                                
                                
                                
                                
                            }
                            .animation(.easeInOut, value: selectedTab)
                            .transition(.slide)
                            .frame(height: geometry.size.height)
                            //                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                        }.edgesIgnoringSafeArea(.all).ignoresSafeArea(.keyboard)
                        //                .background(.red)
                        
                        
                        
                        //                Divider()
                        
                        
                        
                        
                    }.zIndex(10)
                }.padding(0).edgesIgnoringSafeArea(.all)
                
                
               
                if showToast {
                    Toast(message: "saved!")
                }
                
                if showToast1 {
                    
                    Toast(message: "Exceeding the limit requires Pro")
                    
                }
                
                
                
                
                
                
                
                
                
                
            }
        }
    }
    
    func deleteBall(ball: Ball) {
        if let index = balls.firstIndex(where: { $0.id == ball.id }) {
            balls.remove(at: index)
        }
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}



#Preview {
    BlurView()
}



class DataColor {
    
    static func hexToColor(hex: String, alpha: Double = 1.0) -> Color {
        var formattedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if formattedHex.hasPrefix("#") {
            formattedHex.remove(at: formattedHex.startIndex)
        }
        
        let scanner = Scanner(string: formattedHex)
        var color: UInt64 = 0
        
        if scanner.scanHexInt64(&color) {
            let red = Double((color & 0xFF0000) >> 16) / 255.0
            let green = Double((color & 0x00FF00) >> 8) / 255.0
            let blue = Double(color & 0x0000FF) / 255.0
            return Color(red: red, green: green, blue: blue, opacity: alpha)
        } else {
            // 返回默认颜色，当转换失败时
            return Color.black
        }
    }
    
}

extension Color {
    func toHexString() -> String {
        guard let components = UIColor(self).cgColor.components else {
            return "#000000"
        }
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        
        return String(format: "#%02lX%02lX%02lX", lroundf(Float(red * 255)), lroundf(Float(green * 255)), lroundf(Float(blue * 255)))
    }
}


struct MyTabView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // 自定义标签栏
            HStack {
                TabBarButton(title: "首页", isSelected: selectedIndex == 0) {
                    selectedIndex = 0
                }
                TabBarButton(title: "搜索", isSelected: selectedIndex == 1) {
                    selectedIndex = 1
                }
                TabBarButton(title: "设置", isSelected: selectedIndex == 2) {
                    selectedIndex = 2
                }
            }
            .frame(height: 50)
            .background(Color.white)
            .shadow(radius: 2)
            
            // 自定义内容显示
            ZStack {
                if selectedIndex == 0 {
                    Text("首页内容")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.green)
                } else if selectedIndex == 1 {
                    Text("搜索内容")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.blue)
                } else if selectedIndex == 2 {
                    Text("设置内容")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.orange)
                }
            }
            .animation(.easeInOut, value: selectedIndex)
            .transition(.slide)
        }
    }
}

struct TabBarButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(isSelected ? Color.blue : Color.gray)
                if isSelected {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(Color.clear)
                } else {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(Color.clear)
                }
            }
            .padding(.horizontal)
        }
    }
}


struct Toast: View {
    let message: String
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text(message)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
        .transition(.move(edge: .bottom))
    }
}

class ImageSever: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Saved!")
    }
}


