//
//  MapAppApp.swift
//  MapApp
//
//  Created by Kritchanat on 9/6/2567 BE.
//

import SwiftUI

@main
struct SwiftfulMapAppApp: App {
    
    // สร้าง instance และใช้ @StateObject เพื่อให้ SwiftUI จัดการวงจรชีวิตของ ViewModel นี้
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        
        // เป็น container สำหรับ simulator หลักของแอป
        WindowGroup {
            
            // สร้าง LocationsView ซึ่งเป็น View หลักของแอป
            LocationsView()
                
                // ส่ง vm ไปยัง view hierarchy เพื่อให้ View อื่นๆ ใน hierarchy นี้สามารถเข้าถึงได้
                .environmentObject(vm)
        }
    }
}
