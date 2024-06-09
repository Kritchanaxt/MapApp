//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Kritchanat on 9/6/2567 BE.
//

import Foundation // สำหรับฟังก์ชันพื้นฐาน
import MapKit // สำหรับการทำงานกับแผนที่
import SwiftUI

// MARK: ประกาศคลาส LocationsViewModel ที่ conform กับ ObservableObject protocol 
// ซึ่งทำให้สามารถใช้ร่วมกับ SwiftUI เพื่ออัพเดต UI อัตโนมัติเมื่อมีการเปลี่ยนแปลงข้อมูล.
class LocationsViewModel: ObservableObject {
    
    // MARK: All loaded locations
    // ใช้ @Published เพื่อให้ SwiftUI รับรู้เมื่อมีการเปลี่ยนแปลงค่า.
    @Published var locations: [Location]
    
    // MARK: Current location on map
    // เก็บสถานที่ปัจจุบันที่แสดงบนแผนที่ และเรียก updateMapRegion เมื่อค่าเปลี่ยนแปลง.
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // MARK: Current region on map
    // เก็บข้อมูลของภูมิภาคที่แสดงบนแผนที่ และ mapSpan เพื่อกำหนดขอบเขตการมองเห็นของแผนที่.
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // MARK: Show list of locations
    // ควบคุมการแสดง/ซ่อนรายชื่อสถานที่.
    @Published var showLocationsList: Bool = false
    
    // MARK: Show location detail via sheet
    // แสดงรายละเอียดใน sheet.
    @Published var sheetLocation: Location? = nil
    
    // MARK: init เป็น initializer
    // กำหนดค่าเริ่มต้นให้กับ locations และ mapLocation
    // จากข้อมูลใน LocationsDataService, และอัพเดตภูมิภาคของแผนที่ตามสถานที่แรกในรายการ.
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    
    // MARK: ฟังก์ชันนี้ใช้เพื่ออัพเดตภูมิภาคของแผนที่
    // โดยใช้ค่า coordinates ของ location ที่ได้รับมา พร้อมกับการใช้แอนิเมชัน.
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    // MARK: ฟังก์ชันสลับสถานะการแสดง/ซ่อนรายชื่อสถานที่พร้อมกับการใช้แอนิเมชัน.
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
//            showLocationsList = !showLocationsList
            showLocationsList.toggle()
        }
    }
    
    // MARK: ฟังก์ชันเปลี่ยนสถานที่ปัจจุบันบนแผนที่
    // ให้เป็น location ที่ได้รับมา และซ่อนรายการสถานที่ พร้อมกับการใช้แอนิเมชัน.
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    // MARK: ฟังก์ชันนีี้ทำงานเพื่อเปลี่ยนสถานที่ปัจจุบันไปยังสถานที่ถัดไปในรายการ:
    func nextButtonPressed() {
        
        // MARK: Get the current index
        // หาดัชนีของสถานที่ปัจจุบัน (mapLocation) ในอาเรย์ locations.
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find current index in locations array! Should never happen.")
            return
        }
        
        // MARK: Check if the currentIndex is valid
        // ถ้าพบดัชนีปัจจุบัน (currentIndex)
        let nextIndex = currentIndex + 1
        
        // ตรวจสอบว่ามีดัชนีถัดไป (nextIndex) อยู่ในขอบเขตของอาเรย์หรือไม่.
        guard locations.indices.contains(nextIndex) else {
            
            // MARK: Next index is NOT valid
            // ถ้า nextIndex ไม่อยู่ในขอบเขต (เช่น เป็นสถานที่สุดท้าย)
            guard let firstLocation = locations.first else { return }
            
            // MARK: Restart from 0
            // จะเปลี่ยนไปที่สถานที่แรก.
            showNextLocation(location: firstLocation)
            return
        }
        
        // MARK: Next index IS valid
        // ถ้า nextIndex อยู่ในขอบเขต
        let nextLocation = locations[nextIndex]
        
        // จะเปลี่ยนไปที่สถานที่ถัดไป.
        showNextLocation(location: nextLocation)
    }
    
}
