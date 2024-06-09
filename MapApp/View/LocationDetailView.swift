//
//  LocationDetailView.swift
//  MapApp
//
//  Created by Kritchanat on 9/6/2567 BE.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    // ใช้ @EnvironmentObject เพื่อนำเข้า object นี้จาก environment ของ SwiftUI.
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                
                // ซึ่งมีเงาสีดำที่ความโปร่งใส 0.3, รัศมี 20, และเลื่อนไปตามแกน y 10 จุด.
                imagesection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    
                    // ตัวแบ่ง
                    Divider()
                    descriptionSection
                    
                    // ตัวแบ่ง
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        
        // เพิ่มพื้นหลังแบบโปร่งบาง
        .background(.ultraThinMaterial)
        
        // เพิ่ม backButton เป็น overlay โดยจัดเรียงที่ขอบด้านบนซ้าย
        .overlay(backButton, alignment: .topLeading)
    }
}

#Preview {
    
    // ใช้งาน location แรกจาก LocationsDataService.locations และกำหนด environmentObject เป็น LocationsViewModel().
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}

// สร้าง extension สำหรับ LocationDetailView เพื่อให้สามารถเพิ่มฟังก์ชันเพิ่มเติมได้.
extension LocationDetailView {
    
    private var imagesection: some View {
        
        // สร้าง TabView เพื่อแสดงรูปภาพในแบบเลื่อน.
        TabView {
            
            // สำหรับแต่ละชื่อรูปภาพใน location.imageNames, สร้าง Image จากชื่อรูปภาพนั้น.
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                
                    // กำหนดให้ปรับขนาดได้
                    .resizable()
                
                    // เติมเต็มพื้นที่ที่กำหนด
                    .scaledToFill()
                
                    // กำหนดขนาดกรอบตามประเภทอุปกรณ์
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    
                    // และตัดส่วนที่เกินออก
                    .clipped()
            }
        }
        // กำหนดความสูง
        .frame(height: 500)
        
        // ใช้ PageTabViewStyle() เพื่อแสดงเป็นหน้าแท็บ.
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // ถ้ามีลิงก์ (location.link)
            if let url = URL(string: location.link) {
                
                // เพิ่ม Link ที่มีข้อความว่า "Read more on Wikipedia"
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }
        
    private var mapLayer: some View {
        
        // สร้าง Map ที่มี coordinateRegion คงที่ (constant) ตั้งค่าเป็น MKCoordinateRegion
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            
            // ที่ศูนย์กลางของสถานที่ (location.coordinates)
            center: location.coordinates,
            
            // span คือ MKCoordinateSpan 0.01 องศาสำหรับทั้งละติจูดและลองจิจูด.
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            
            // กำหนด annotationItems เป็น array ของสถานที่ ([location]).
            annotationItems: [location]) { location in
            
            // สร้าง MapAnnotation สำหรับแต่ละสถานที่
            MapAnnotation(coordinate: location.coordinates) {
                
                // ใช้ LocationMapAnnotationView และเพิ่มเงา (shadow(radius: 10)).
                LocationMapAnnotationView()
                    .shadow(radius: 10)
            }
        }
        
        // ปิดการโต้ตอบ
        .allowsHitTesting(false)
        
        // กำหนดอัตราส่วนเป็น 1:1
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
    }
    
    private var backButton: some View {
        
        // กดแล้วจะกำหนดค่า vm.sheetLocation เป็น nil.
        Button {
            vm.sheetLocation = nil
        } label: {
             Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thinMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
        
    }
}
