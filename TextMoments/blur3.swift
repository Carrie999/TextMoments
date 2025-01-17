//
//  blur3.swift
//  TextMoments
//
//  Created by  玉城 on 2024/8/9.
//

import SwiftUI

//struct MyTabView: View {
//    @State private var selectedIndex = 0
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            // 自定义标签栏
//            HStack {
//                TabBarButton(title: "首页", isSelected: selectedIndex == 0) {
//                    selectedIndex = 0
//                }
//                TabBarButton(title: "搜索", isSelected: selectedIndex == 1) {
//                    selectedIndex = 1
//                }
//                TabBarButton(title: "设置", isSelected: selectedIndex == 2) {
//                    selectedIndex = 2
//                }
//            }
//            .frame(height: 50)
//            .background(Color.white)
//            .shadow(radius: 2)
//
//            // 自定义内容显示
//            ZStack {
//                if selectedIndex == 0 {
//                    Text("首页内容")
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .background(Color.green)
//                } else if selectedIndex == 1 {
//                    Text("搜索内容")
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .background(Color.blue)
//                } else if selectedIndex == 2 {
//                    Text("设置内容")
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .background(Color.orange)
//                }
//            }
//            .animation(.easeInOut, value: selectedIndex)
//            .transition(.slide)
//        }
//    }
//}
//
//struct TabBarButton: View {
//    let title: String
//    let isSelected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            VStack {
//                Text(title)
//                    .font(.system(size: 16, weight: .bold))
//                    .foregroundColor(isSelected ? Color.blue : Color.gray)
//                if isSelected {
//                    Rectangle()
//                        .frame(height: 2)
//                        .foregroundColor(Color.clear)
//                } else {
//                    Rectangle()
//                        .frame(height: 2)
//                        .foregroundColor(Color.clear)
//                }
//            }
//            .padding(.horizontal)
//        }
//    }
//}




#Preview {
    MyTabView()
}
