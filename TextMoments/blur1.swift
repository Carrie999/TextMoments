//
//  blur1.swift
//  TextMoments
//
//  Created by  玉城 on 2024/8/9.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct NoiseEffect: ViewModifier {
    let intensity: Double
    let noiseOpacity: Double
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    Image(uiImage: generateNoiseImage(size: geometry.size, intensity: intensity))
                        .resizable()
                        .blendMode(.overlay)
                        .opacity(noiseOpacity)
                }
            )
    }
    
    private func generateNoiseImage(size: CGSize, intensity: Double) -> UIImage {
        let context = CIContext()
        
        let noiseFilter = CIFilter.randomGenerator()
        
        let noiseImage = noiseFilter.outputImage!
        
        let clampFilter = CIFilter.affineClamp()
        clampFilter.inputImage = noiseImage
        let transform = CGAffineTransform(scaleX: 1 / size.width, y: 1 / size.height)
        clampFilter.transform = transform.inverted()
        
        let colorFilter = CIFilter.colorControls()
        colorFilter.inputImage = clampFilter.outputImage
        colorFilter.contrast = Float(intensity)
        colorFilter.saturation = 1.5 // 增加饱和度以产生彩色噪点
        
        if let outputImage = colorFilter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: CGRect(origin: .zero, size: size)) {
            return UIImage(cgImage: cgImage)
        }
        
        return UIImage()
    }
}

extension View {
    func noiseEffect(intensity: Double, opacity: Double) -> some View {
        self.modifier(NoiseEffect(intensity: intensity, noiseOpacity: opacity))
    }
}

struct Content1View: View {
    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 0) {
                Image("1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
//                    .frame(width: geometry.size.width * 0.95)
                    .cornerRadius(20)
                    .shadow(radius: 10)
//                TextWithBackground(text:"这", imageName: "t1")
//                TextWithBackground(text:"里", imageName: "t1")
//                TextWithBackground(text:"是", imageName: "t1")
//                TextWithBackground(text:"文", imageName: "t2")
//                TextWithBackground(text:"字", imageName: "t2")
            }
            .noiseEffect(intensity: 10.0, opacity: 1) // 增加intensity，添加opacity控制
            
            // ... 其他 HStack
        }
        .background(Color.gray) // 添加背景色以便更容易看到效果
    }
}


#Preview {
    Content1View()
}
