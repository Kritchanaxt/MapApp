//
//  LocationPreviewView.swift
//  MapApp
//
//  Created by Kritchanat on 9/6/2567 BE.
//

import SwiftUI

struct LocationPreviewView: View {
    
    // ประกาศใช้ @EnvironmentObject เพื่อนำเข้า object นี้จาก environment ของ SwiftUI.
    @EnvironmentObject private var vm: LocationsViewModel
    
    let location: Location
    
    var body: some View {
        
        // สร้าง HStack เพื่อจัดเรียงลูกมุมมองในแนวนอน, จัดเรียงลูกมุมมองที่ด้านล่าง (alignment: .bottom) และไม่ให้มีช่องว่างระหว่างลูกมุมมอง (spacing: 0).
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8) {
                learnMoreButton
                nextButton
            }
        }
        // เพิ่ม padding รอบๆ HStack 20 จุด.
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
               
                // เติมด้วยวัสดุโปร่งบาง
                .fill(.ultraThinMaterial)
            
                // เลื่อนพื้นหลังลงด้านล่าง 65 จุด
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

#Preview {
    ZStack {
        // พื้นหลังสีเขียวที่ครอบคลุมทุกพื้นที่ของหน้าจอ
        Color.green.ignoresSafeArea()
        
        // ใช้ location แรกจาก LocationsDataService.locations และเพิ่ม padding รอบๆ.
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .padding()
    }
    // กำหนด environment object เป็น LocationsViewModel().
    .environmentObject(LocationsViewModel())
}

// สร้างเพื่อให้สามารถเพิ่มฟังก์ชันเพิ่มเติมได้.
extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            
            // ถ้ามีชื่อรูปภาพแรก (location.imageNames.first) ให้สร้าง Image จากชื่อรูปภาพนั้น.
            if let imageName = location.imageNames.first {
                Image(imageName)
                
                    // กำหนดให้ปรับขนาดได้
                    .resizable()
                
                    // กำหนดให้เติมเต็มพื้นที่ที่กำหนด
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            // เพิ่ม Text สำหรับชื่อสถานที่
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            // เพิ่ม Text สำหรับชื่อเมือง
            Text(location.cityName)
                .font(.subheadline)
        }
        // กำหนดกรอบของให้มีความกว้างสูงสุดและจัดเรียงที่ขอบด้านซ้าย
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            // เมื่อกดแล้วจะกำหนดค่า vm.sheetLocation เป็น location.
            vm.sheetLocation = location
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        // กำหนดสไตล์ปุ่มเป็น
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            
            // เมื่อกดแล้วจะเรียกฟังก์ชัน vm.nextButtonPressed().
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        // กำหนดสไตล์ปุ่มเป็น
        .buttonStyle(.bordered)
    }
}
