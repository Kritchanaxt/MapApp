//
//  LocationMapAnnotationView.swift
//  MapApp
//
//  Created by Kritchanat on 9/6/2567 BE.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
    // ประกาศ accentColor ซึ่งเป็นสีที่ถูกกำหนดใน Assets.xcassets ของโปรเจ็กต์.
    let accentColor = Color("AccentColor")
    
    var body: some View {
        
        // สร้าง VStack เพื่อจัดเรียงลูกมุมมองในแนวตั้ง โดยมีค่า spacing ระหว่างลูกมุมมองเป็น 0.
        VStack(spacing: 0) {
            
            Image(systemName: "map.circle.fill")
                
                // ทำให้ภาพสามารถปรับขนาดได้
                .resizable()
            
                //  ทำให้ภาพปรับขนาดตามอัตราส่วนเดิม
                .scaledToFit()
            
                // กำหนดขนาดของภาพ
                .frame(width: 30, height: 30)
                
                // กำหนดฟอนต์
                .font(.headline)
            
                // กำหนดสีของภาพเป็นสีขาว
                .foregroundColor(.white)
            
                // เพิ่ม padding รอบภาพ
                .padding(6)
            
                // กำหนดพื้นหลังเป็นสีที่ประกาศไว้
                .background(accentColor)
            
                // ทำให้ภาพมีรูปร่างเป็นวงกลม
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .resizable()
            
                // ทำให้ภาพปรับขนาดตามอัตราส่วนเดิม
                .scaledToFit()
                .foregroundColor(accentColor)
                .frame(width: 10, height: 10)
            
                // หมุนภาพ 180 องศา
                .rotationEffect(Angle(degrees: 180))
               
                // เลื่อนตำแหน่งภาพในแนวแกน y ขึ้นไป 3 จุด
                .offset(y: -3)
            
                // เพิ่ม padding ที่ด้านล่างของภาพ 40 จุด
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    ZStack {
        
        // กำหนดพื้นหลังเป็นสีดำที่ขยายเต็มพื้นที่ปลอดภัย (safe area)
        Color.black.ignoresSafeArea()
        
        LocationMapAnnotationView()
    }
}
