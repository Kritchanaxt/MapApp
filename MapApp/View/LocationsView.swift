//
//  LocationsView.swift
//  MapApp
//
//  Created by Kritchanat on 9/6/2567 BE.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    // ใช้ @EnvironmentObject เพื่อรับอินสแตนซ์ของ LocationsViewModel
    @EnvironmentObject private var vm: LocationsViewModel
    
    // กำหนดค่าคงที่ maxWidthForIpad เพื่อจัดการความกว้างสูงสุดสำหรับการแสดงผลบน iPad
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        
        // ใช้ ZStack เพื่อจัดเลเยอร์ของ views ให้ทับซ้อนกัน
        ZStack {
            
            // เป็น view ของแผนที่ที่ไม่สนใจ safe area เพื่อให้ครอบคลุมทั้งหน้าจอ
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // view พร้อม padding และความกว้างสูงสุดสำหรับ iPad
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                
                // เพื่อดัน locationsPreviewStack ไปที่ด้านล่าง
                Spacer()
                
                // ที่แสดงตัวอย่างของตำแหน่งปัจจุบัน
                locationsPreviewStack
            }
        }
        
        // ใช้ sheet เพื่อแสดง LocationDetailView เมื่อ vm.sheetLocation ถูกตั้งค่า
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView {
    
    private var header: some View {
        VStack {
            // ปุ่มแสดงชื่อและเมืองของตำแหน่งปัจจุบัน
            Button(action: vm.toggleLocationsList) {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        
                        // รูปภาพลูกศรที่บอกสถานะการเปิดหรือปิดของรายการตำแหน่ง พร้อมกับการหมุนลูกศรตามสถานะ
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            
                            // หมุนรูปภาพลูกศรเมื่อ vm.showLocationsList เป็นจริง จะหมุน 180 องศา
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
            }
            
            // หาก vm.showLocationsList เป็นจริง จะปรากฏ LocationsListView
            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        // Map ที่ผูกกับ vm.mapRegion สำหรับการกำหนดภูมิภาคของแผนที่
        Map(coordinateRegion: $vm.mapRegion,
            
            // ใช้ vm.locations เพื่อแสดงการระบุในแผนที่
            annotationItems: vm.locations,
            annotationContent: { location in
            
            // สำหรับแต่ละตำแหน่ง จะสร้าง MapAnnotation ที่มี LocationMapAnnotationView แบบกำหนดเอง
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                
                    // ระบุจะปรับขนาดตามว่าเป็นตำแหน่งปัจจุบันหรือไม่
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        // การแตะที่การระบุจะเปลี่ยนตำแหน่งปัจจุบันด้วย vm.showNextLocation
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            
            // ใช้เพื่อวนลูปผ่านรายการ locations ใน LocationsViewModel และสร้าง view สำหรับแต่ละ location
            ForEach(vm.locations) { location in
                
                // ตรวจสอบว่าตำแหน่งปัจจุบันในแผนที่ (vm.mapLocation) ตรงกับตำแหน่งในลูปหรือไม่
                // ถ้าตรงกัน จะสร้าง LocationPreviewView สำหรับตำแหน่งนั้น
                if vm.mapLocation == location {
                    
                    // สร้าง view LocationPreviewView สำหรับตำแหน่งที่กำลังถูกเลือก
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                    
                        // กำหนดการเคลื่อนไหวสำหรับการแสดงผลและการนำออกของ LocationPreviewView
                        .transition(.asymmetric(
                            
                            // ใช้เพื่อกำหนดการเคลื่อนไหวเมื่อ view ถูกเพิ่มเข้า
                            insertion: .move(edge: .trailing),
                            
                            // ใช้เพื่อกำหนดการเคลื่อนไหวเมื่อ view ถูกนำออก
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
    
}

