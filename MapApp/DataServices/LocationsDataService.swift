//
//  LocationsDataService.swift
//  MapApp
//
//  Created by Kritchanat on 9/6/2567 BE.
//

// MARK: โค้ดนี้สร้างคลาส LocationsDataService ที่มี property แบบ static locations ซึ่งเป็นอาเรย์ของ Location
//  - และเก็บข้อมูลสถานที่สำคัญหลายแห่งทั้งใน Rome และ Paris โดยใช้ข้อมูลของแต่ละสถานที่ เช่น ชื่อเมือง พิกัด คำอธิบาย รายการชื่อภาพ และลิงก์ Wikipedia.
 
import Foundation
import MapKit

// MARK: ประกาศคลาส LocationsDataService ซึ่งใช้เพื่อเก็บข้อมูลของสถานที่ต่างๆ.
class LocationsDataService {
    
    // MARK: ประกาศ property แบบ static locations ซึ่งเป็นอาเรย์ของ Location. ทำให้สามารถเข้าถึงได้โดยไม่ต้องสร้างอินสแตนซ์ของคลาส LocationsDataService.
    static let locations: [Location] = [
        
        // MARK: เพิ่ม Location สำหรับ Colosseum ใน Rome, รวมถึงชื่อเมือง, พิกัด, คำอธิบาย, รายการชื่อภาพ, และลิงก์ Wikipedia.
        Location(
            name: "Colossum",
            cityName: "Rome",
            coordinates: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922),
            description: "The Colosseum is an oval amphitheatre in the centre of the city of Rome, Italy, just east of the Roman Forum. It is the largest ancient amphitheatre ever built, and is still the largest standing amphitheatre in the world today, despite its age.",
            imageNames: [
                "rome-colosseum-1",
                "rome-colosseum-2",
                "rome-colosseum-3",
            ],
            link: "https://en.wikipedia.org/wiki/Colosseum"),
        
        // MARK: เพิ่ม Location สำหรับ Pantheon ใน Rome, รวมถึงชื่อเมือง, พิกัด, คำอธิบาย, รายการชื่อภาพ, และลิงก์ Wikipedia.
        Location(
            name: "Pantheon",
            cityName: "Rome",
            coordinates: CLLocationCoordinate2D(latitude: 41.8986, longitude: 12.4769),
            description: "The Pantheon is a former Roman temple and since the year 609 a Catholic church, in Rome, Italy, on the site of an earlier temple commissioned by Marcus Agrippa during the reign of Augustus.",
            imageNames: [
                "rome-pantheon-1",
                "rome-pantheon-2",
                "rome-pantheon-3",
            ],
            link: "https://en.wikipedia.org/wiki/Pantheon,_Rome"),
        
        // MARK: เพิ่ม Location สำหรับ Trevi Fountain ใน Rome, รวมถึงชื่อเมือง, พิกัด, คำอธิบาย, รายการชื่อภาพ, และลิงก์ Wikipedia.
        Location(
            name: "Trevi Fountain",
            cityName: "Rome",
            coordinates: CLLocationCoordinate2D(latitude: 41.9009, longitude: 12.4833),
            description: "The Trevi Fountain is a fountain in the Trevi district in Rome, Italy, designed by Italian architect Nicola Salvi and completed by Giuseppe Pannini and several others. Standing 26.3 metres high and 49.15 metres wide, it is the largest Baroque fountain in the city and one of the most famous fountains in the world.",
            imageNames: [
                "rome-trevifountain-1",
                "rome-trevifountain-2",
                "rome-trevifountain-3",
            ],
            link: "https://en.wikipedia.org/wiki/Trevi_Fountain"),
        
        // MARK: เพิ่ม Location สำหรับ Eiffel Tower ใน Paris, รวมถึงชื่อเมือง, พิกัด, คำอธิบาย, รายการชื่อภาพ, และลิงก์ Wikipedia.
        Location(
            name: "Eiffel Tower",
            cityName: "Paris",
            coordinates: CLLocationCoordinate2D(latitude: 48.8584, longitude: 2.2945),
            description: "The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars in Paris, France. It is named after the engineer Gustave Eiffel, whose company designed and built the tower. Locally nicknamed 'La dame de fer', it was constructed from 1887 to 1889 as the centerpiece of the 1889 World's Fair and was initially criticized by some of France's leading artists and intellectuals for its design, but it has become a global cultural icon of France and one of the most recognizable structures in the world.",
            imageNames: [
                "paris-eiffeltower-1",
                "paris-eiffeltower-2",
            ],
            link: "https://en.wikipedia.org/wiki/Eiffel_Tower"),
        
        // MARK: เพิ่ม Location สำหรับ Louvre Museum ใน Paris, รวมถึงชื่อเมือง, พิกัด, คำอธิบาย, รายการชื่อภาพ, และลิงก์ Wikipedia.
        Location(
            name: "Louvre Museum",
            cityName: "Paris",
            coordinates: CLLocationCoordinate2D(latitude: 48.8606, longitude: 2.3376),
            description: "The Louvre, or the Louvre Museum, is the world's most-visited museum and a historic monument in Paris, France. It is the home of some of the best-known works of art, including the Mona Lisa and the Venus de Milo. A central landmark of the city, it is located on the Right Bank of the Seine in the city's 1st arrondissement.",
            imageNames: [
                "paris-louvre-1",
                "paris-louvre-2",
                "paris-louvre-3",
            ],
            link: "https://en.wikipedia.org/wiki/Louvre"),
    ]
}
