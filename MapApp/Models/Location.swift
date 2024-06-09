//
//  Location.swift
//  MapApp
//
//  Created by Kritchanat on 9/6/2567 BE.
//

import Foundation
import MapKit

// MARK: ประกาศ struct ชื่อ Location
// และทำให้แต่ละ instance ของ Location จะมี id ที่ไม่ซ้ำกัน และสามารถเปรียบเทียบความเท่ากันได้
struct Location: Identifiable, Equatable {
    
    let name: String // ชื่อของสถานที่
    let cityName: String // ชื่อเมืองที่สถานที่นั้นตั้งอยู่
    let coordinates: CLLocationCoordinate2D // พิกัดของสถานที่ในรูปแบบ CLLocationCoordinate2D
    let description: String // คำอธิบายของสถานที่
    let imageNames: [String] // ชื่อของภาพที่เกี่ยวข้องกับสถานที่ในรูปแบบอาเรย์ของสตริง
    let link: String // ลิงก์ที่เกี่ยวข้องกับสถานที่
    
    // MARK: Identifiable
    // ประกาศ computed property id ซึ่งเป็นการ concatenation ของ name และ cityName
    // ใช้เป็น id ที่ไม่ซ้ำกันสำหรับแต่ละ Location (เพื่อตอบสนองการ conform กับ Identifiable)
    var id: String {
//        name = "Colosseum"
//        cityName = "Rome"
//        id = "ColosseumRome"
        name + cityName
    }
    
    // MARK: Equatable
    // ประกาศ static method == ซึ่งเป็นการ override operator ==
    // เพื่อให้สามารถเปรียบเทียบสอง Location object ได้
    // โดยการเปรียบเทียบ id ของทั้งสองฝั่ง (lhs และ rhs)
    // ถ้า id ของทั้งสองฝั่งเหมือนกันจะคืนค่า true มิฉะนั้นจะคืนค่า false
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
