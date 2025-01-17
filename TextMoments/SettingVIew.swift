//
//  SettingView.swift
//  EdgeSnap
//
//  Created by  玉城 on 2024/8/10.
//


import SwiftUI
import MessageUI
import AppIntents
import StoreKit
import UIKit

struct SettingView: View {
    @State private var isShowingMailView = false
    @State private var isShowingActivityView = false
    @StateObject var storeKit = StoreKitManager()
    @State var isPurchased: Bool = false
    
    
    
    //    private func mailView() -> some View {
    //          MFMailComposeViewController.canSendMail() ?
    //              AnyView(MailView(isShowing: $isShowingMailView, result: $result)) :
    //              AnyView(Text("Can't send emails from this device"))
    //      }
    //  }
    
    func getAppShareText() -> String {
        // Customize the share text with your app's description
        return "Check out this amazing Diffuse Card app! It's the best app ever!"
    }
    func getAppStoreLink() -> URL {
        // Replace "your_app_id" with your actual App Store ID
        let appStoreID = "6624303246"
        let appStoreURL = "https://apps.apple.com/app/id\(appStoreID)?action=write-review"
        return URL(string: appStoreURL)!
    }
    
    
    
    
    
    
    var body: some View {
        
        ZStack {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Spacer().frame(height: 100)
                    
                    Divider().offset(y:isPurchased ? 0 : 10)
                    
                    if storeKit.storeProducts.isEmpty {
                        // 占位符视图
                        Text("Network issue, please exit and retry")
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                    ForEach(storeKit.storeProducts) {
                        product in VStack{
                            Button(action: {
                                if isPurchased {
                                    return
                                }
                                Task{
                                    try await storeKit.purchase(product)
                                }
                                
                                
                            }) {
                                if isPurchased {
                                    Text("Pro User")
                                        .foregroundStyle(
                                            // c0a3e9
                                            LinearGradient(gradient: Gradient(colors: [
                                                DataColor.hexToColor(hex:"71c0fa"),
                                                DataColor.hexToColor(hex:"c0a3e9"),
                                                DataColor.hexToColor(hex:"fb92d3"),
                                                DataColor.hexToColor(hex:"fbb589")]),
                                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                                        ).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding()
                                    
                                } else {
                                    ZStack(alignment: .leading){
                                        
                                        Text("DiffuseCard Pro")
                                            .font(.system(size: 26))
                                            .foregroundStyle(
                                                // c0a3e9
                                                LinearGradient(gradient: Gradient(colors: [
                                                    DataColor.hexToColor(hex:"71c0fa"),
                                                    DataColor.hexToColor(hex:"c0a3e9"),
                                                    DataColor.hexToColor(hex:"fb92d3"),
                                                    DataColor.hexToColor(hex:"fbb589")]),
                                                               startPoint: .topLeading, endPoint: .bottomTrailing)
                                            )
                                            .fontWeight(.bold)
                                            .frame(width: 300, height: 40, alignment: .leading)
                                            .padding()
                                        //                                Text("EdgeSnap Premium").foregroundColor(DataColor.hexToColor(hex:"f560e9")).fontWeight(.bold)
                                        //                                    .frame(width: 300, height: 40, alignment: .leading)
                                        //                                    .padding()
                                        Text("Unlock Full Access, No Watermark").opacity(0.7).offset(x:18, y:20)  .font(.system(size: 12)).foregroundStyle(
                                            LinearGradient(gradient: Gradient(colors:[
                                                DataColor.hexToColor(hex:"71c0fa"),
                                                DataColor.hexToColor(hex:"c0a3e9"),
                                                DataColor.hexToColor(hex:"fb92d3"),
                                                DataColor.hexToColor(hex:"fbb589")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                        
                                        
                                        //                                        .font(.system(size: 14))
                                    }
                                }
                                
                                
                                
                                
                                
                            }
                            .onChange(of: storeKit.purchasedCourses) { _ in
                                Task {
                                    isPurchased = (try? await storeKit.isPurchased(product)) ?? false
                                    UserDefaults.standard.set(isPurchased, forKey: "isPurchased")
                                }
                            }
                            
                            
                        }
                    }
                    
                    
                    
                    Divider()
                    Button(action: {
                        Task {
                            
                            try? await AppStore.sync()
                        }
                        
                    }) {
                        Text("Restore Purchase")
                    }.padding()
                    
                    
                    
                    
                    Divider()
                    Button(action: {
                        if let url = URL(string: "itms-apps://itunes.apple.com/app/6624303246?action=write-review"),
                           
                            UIApplication.shared.canOpenURL(url){
                            
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            
                        }
                        
                        
                    }) {
                        Text("Rate app")
                        
                    }.padding()
                    Divider()
                    //                    Text("建议吐槽")
                    
                    Button(action: {
                        // 分享给朋友的操作
                        self.isShowingActivityView = true
                        
                        
                    }) {
                        Text("Share app")
                    }   .sheet(isPresented: $isShowingActivityView, content: {
                        ActivityViewController(activityItems: [self.getAppShareText(), self.getAppStoreLink()])
                        
                    }).padding()
                    
                    
                    Divider()
                    SendEmailView().padding()
                    Divider()
                    
                    //                    }.foregroundColor( DataColor.hexToColor(hex:"494949"))
                    //                        .padding()
                    
                    
                    
                    
                    //                    Section(header: Text("1").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)) {
                    //                        NavigationLink(destination: ChargeView( )) {
                    //                            Text("Gradient Pro").foregroundColor( DataColor.hexToColor(hex:"ff0000")).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    //                        }
                    //                        Text("Restore Purchase")
                    //                    }.frame(height: 100)
                    
                    
                    
                    Spacer()
                    
                    
                    
                    
                    
                }.padding(.leading,20)
                
                VStack{
                    Spacer()
                    //                Text("version(v1.0.7) ").foregroundColor( DataColor.hexToColor(hex:"494949")).opacity(0.5)
                    Spacer().frame(height: 50)
                }     .frame(width: geometry.size.width) // 使用GeometryReader中获取的宽度
            }
            
        }.ignoresSafeArea(.all)
        
        //        .foregroundColor(DataColor.hexToColor(hex:"#595959"))
        //        .navigationTitle("")
        
    }
}


#Preview {
    SettingView()
}






struct ActivityViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController
    var activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Do nothing
    }
}
