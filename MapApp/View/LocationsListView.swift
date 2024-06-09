//
//  LocationsListView.swift
//  MapApp
//
//  Created by Kritchanat on 9/6/2567 BE.
//

import SwiftUI

struct LocationsListView: View {
    
    // ประกาศใช้ @EnvironmentObject เพื่อนำเข้า object นี้จาก environment ของ SwiftUI.
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        
        // สร้าง List ซึ่งเป็นมุมมองที่ใช้แสดงรายการของไอเท็มหลาย ๆ ไอเท็มในรูปแบบเลื่อนขึ้นลงได้.
        List {
            
            // วนลูปผ่านรายการ locations ใน vm และสร้างมุมมองสำหรับแต่ละ location.
            ForEach(vm.locations) { location in
                Button {
                    // เรียกฟังก์ชัน showNextLocation(location:) ใน vm
                    vm.showNextLocation(location: location)
                    
                // ป้ายของปุ่มจะใช้มุมมองที่คืนค่าจากฟังก์ชัน
                } label: {
                    listRowView(location: location)
                }
                
                // เพิ่ม padding แนวตั้งให้กับปุ่ม 4 จุด
                .padding(.vertical, 4)
                
                // กำหนดพื้นหลังของแถวใน List เป็นสีใส
                .listRowBackground(Color.clear)
            }
        }
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}

//สร้างเพื่อให้สามารถเพิ่มฟังก์ชันเพิ่มเติมได้.
extension LocationsListView {
    
    // ประกาศฟังก์ชันที่จะคืนค่ามุมมองสำหรับแถวใน List แต่ละแถว.
    private func listRowView(location: Location) -> some View {
        
        // จัดเรียงมุมมองในแนวนอน.
        HStack {
            
            // ถ้า location.imageNames.first มีค่า (ไม่เป็น nil)
            if let imageName = location.imageNames.first {
                
                // สร้าง Image จากชื่อรูป
                Image(imageName)
                   
                    // กำหนดให้ปรับขนาดได้
                    .resizable()
                    
                    // กำหนดให้เติมเต็มพื้นที่ที่กำหนด
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                
                    // เพิ่มมุมโค้ง 10 จุดให้กับรูปภาพ
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                
                // เพิ่ม Text สำหรับชื่อสถานที่
                Text(location.name)
                    .font(.headline)
                
                // เพิ่ม Text สำหรับชื่อเมือง
                Text(location.cityName)
                    .font(.subheadline)
            }
            
            // กำหนดกรอบของ VStack ให้มีความกว้างสูงสุดและจัดเรียงที่ขอบด้านซ้าย
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}
