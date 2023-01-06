//
//  ViewController.swift
//  houmuch
//
//  Created by uniess on 2023/01/06.
//

import UIKit
import NMapsMap

class ViewController: UIViewController, NMFMapViewCameraDelegate, NMFMapViewOptionDelegate {
    static var markers: [NMFMarker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let naverMapView = NMFNaverMapView(frame: view.frame)
        naverMapView.showZoomControls = true
        naverMapView.mapView.moveCamera(NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: 37, lng: 127), zoom: 9)))
        naverMapView.mapView.positionMode = .direction
        naverMapView.mapView.zoomLevel = 10
        naverMapView.mapView.addCameraDelegate(delegate: self)
        naverMapView.mapView.addOptionDelegate(delegate: self)
        
        view.addSubview(naverMapView)
    }
    
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        draw(mapView: nil)
        draw(mapView: mapView)
    }
    
    private func draw(mapView: NMFMapView?) {
        guard mapView != nil else {
            drawMarker(mapView: mapView)
            return
        }
        let coordinates = fetch()
        let zoomLevel = Int(mapView!.zoomLevel)
        for item in coordinates {
            if item.type! == 0 && zoomLevel > 8 {
                continue
            }
            if item.type! == 1 && zoomLevel <= 8 {
                continue
            }
            let marker = createMarker(address: item.short_address!, latitude: item.latitude!, longitude: item.longitude!, price: item.price!, count: item.count!)
            ViewController.markers.append(marker)
        }
        drawMarker(mapView: mapView)
    }
    
    private func drawMarker(mapView: NMFMapView?) {
        for marker in ViewController.markers {
            marker.mapView = mapView
        }
        if mapView == nil {
            ViewController.markers.removeAll()
        }
    }
    
    private func createMarker(address: String, latitude: Double, longitude: Double, price: Int, count: Int) -> NMFMarker {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: latitude, lng: longitude)
        marker.captionText = address
        marker.captionColor = UIColor.white
        marker.captionTextSize = 11
        marker.captionHaloColor = UIColor.clear
        marker.subCaptionText = "\(price)억\n\(count)건"
        marker.subCaptionColor = UIColor.white
        marker.subCaptionTextSize = 14
        marker.subCaptionHaloColor = UIColor.clear
        marker.captionOffset = -49
        marker.iconPerspectiveEnabled = true
        marker.iconImage = NMFOverlayImage(name: "SummaryOverlay")
        return marker
    }
    
    private func fetch() -> [Coordinate] {
        let decoded = try! JSONDecoder().decode([Coordinate].self, from: Data(list.utf8))
        return decoded
    }
}

struct Coordinate: Decodable {
    var short_address: String?
    var type: Int?
    var latitude: Double?
    var longitude: Double?
    var price: Int?
    var count: Int?
}

var list = """
[
  {
    "short_address": "서울",
    "type": 0,
    "latitude": 37.5666103,
    "longitude": 126.9783882,
    "price": 7,
    "count": 95
  },
  {
    "short_address": "종로구",
    "type": 1,
    "latitude": 37.5735207,
    "longitude": 126.9788345,
    "price": 1,
    "count": 43
  },
  {
    "short_address": "중구",
    "type": 1,
    "latitude": 37.563843,
    "longitude": 126.997602,
    "price": 7,
    "count": 32
  },
  {
    "short_address": "용산구",
    "type": 1,
    "latitude": 37.532527,
    "longitude": 126.99049,
    "price": 10,
    "count": 28
  },
  {
    "short_address": "성동구",
    "type": 1,
    "latitude": 37.563456,
    "longitude": 127.036821,
    "price": 8,
    "count": 45
  },
  {
    "short_address": "광진구",
    "type": 1,
    "latitude": 37.538617,
    "longitude": 127.082375,
    "price": 2,
    "count": 41
  },
  {
    "short_address": "동대문구",
    "type": 1,
    "latitude": 37.574524,
    "longitude": 127.03965,
    "price": 4,
    "count": 70
  },
  {
    "short_address": "중랑구",
    "type": 1,
    "latitude": 37.6063242,
    "longitude": 127.0925842,
    "price": 7,
    "count": 28
  },
  {
    "short_address": "성북구",
    "type": 1,
    "latitude": 37.5894,
    "longitude": 127.016749,
    "price": 0,
    "count": 29
  },
  {
    "short_address": "강북구",
    "type": 1,
    "latitude": 37.6397819,
    "longitude": 127.0256135,
    "price": 2,
    "count": 62
  },
  {
    "short_address": "도봉구",
    "type": 1,
    "latitude": 37.668768,
    "longitude": 127.047163,
    "price": 9,
    "count": 21
  },
  {
    "short_address": "노원구",
    "type": 1,
    "latitude": 37.654358,
    "longitude": 127.056473,
    "price": 7,
    "count": 21
  },
  {
    "short_address": "은평구",
    "type": 1,
    "latitude": 37.602784,
    "longitude": 126.929164,
    "price": 10,
    "count": 42
  },
  {
    "short_address": "서대문구",
    "type": 1,
    "latitude": 37.579225,
    "longitude": 126.9368,
    "price": 8,
    "count": 45
  },
  {
    "short_address": "마포구",
    "type": 1,
    "latitude": 37.5663245,
    "longitude": 126.901491,
    "price": 9,
    "count": 98
  },
  {
    "short_address": "양천구",
    "type": 1,
    "latitude": 37.517016,
    "longitude": 126.866642,
    "price": 2,
    "count": 57
  },
  {
    "short_address": "강서구",
    "type": 1,
    "latitude": 37.550937,
    "longitude": 126.849642,
    "price": 2,
    "count": 93
  },
  {
    "short_address": "구로구",
    "type": 1,
    "latitude": 37.495472,
    "longitude": 126.887536,
    "price": 6,
    "count": 91
  },
  {
    "short_address": "금천구",
    "type": 1,
    "latitude": 37.4568644,
    "longitude": 126.8955105,
    "price": 3,
    "count": 77
  },
  {
    "short_address": "영등포구",
    "type": 1,
    "latitude": 37.526436,
    "longitude": 126.896004,
    "price": 6,
    "count": 13
  },
  {
    "short_address": "동작구",
    "type": 1,
    "latitude": 37.51245,
    "longitude": 126.9395,
    "price": 10,
    "count": 35
  },
  {
    "short_address": "관악구",
    "type": 1,
    "latitude": 37.4781549,
    "longitude": 126.9514847,
    "price": 1,
    "count": 35
  },
  {
    "short_address": "서초구",
    "type": 1,
    "latitude": 37.483569,
    "longitude": 127.032598,
    "price": 8,
    "count": 70
  },
  {
    "short_address": "강남구",
    "type": 1,
    "latitude": 37.517305,
    "longitude": 127.047502,
    "price": 8,
    "count": 45
  },
  {
    "short_address": "송파구",
    "type": 1,
    "latitude": 37.5145636,
    "longitude": 127.1059186,
    "price": 5,
    "count": 13
  },
  {
    "short_address": "강동구",
    "type": 1,
    "latitude": 37.530126,
    "longitude": 127.1237708,
    "price": 0,
    "count": 31
  },
  {
    "short_address": "부산",
    "type": 0,
    "latitude": 35.179816,
    "longitude": 129.0750223,
    "price": 6,
    "count": 16
  },
  {
    "short_address": "중구",
    "type": 1,
    "latitude": 35.106214,
    "longitude": 129.032352,
    "price": 1,
    "count": 87
  },
  {
    "short_address": "서구",
    "type": 1,
    "latitude": 35.0979321,
    "longitude": 129.0244125,
    "price": 7,
    "count": 87
  },
  {
    "short_address": "동구",
    "type": 1,
    "latitude": 35.1292746,
    "longitude": 129.0453253,
    "price": 1,
    "count": 76
  },
  {
    "short_address": "영도구",
    "type": 1,
    "latitude": 35.091199,
    "longitude": 129.067875,
    "price": 5,
    "count": 17
  },
  {
    "short_address": "부산진구",
    "type": 1,
    "latitude": 35.162913,
    "longitude": 129.053157,
    "price": 2,
    "count": 56
  },
  {
    "short_address": "동래구",
    "type": 1,
    "latitude": 35.1964382,
    "longitude": 129.0938569,
    "price": 5,
    "count": 32
  },
  {
    "short_address": "남구",
    "type": 1,
    "latitude": 35.136577,
    "longitude": 129.084163,
    "price": 7,
    "count": 89
  },
  {
    "short_address": "북구",
    "type": 1,
    "latitude": 35.197185,
    "longitude": 128.990438,
    "price": 1,
    "count": 48
  },
  {
    "short_address": "해운대구",
    "type": 1,
    "latitude": 35.163177,
    "longitude": 129.163634,
    "price": 4,
    "count": 75
  },
  {
    "short_address": "사하구",
    "type": 1,
    "latitude": 35.104585,
    "longitude": 128.974817,
    "price": 5,
    "count": 31
  },
  {
    "short_address": "금정구",
    "type": 1,
    "latitude": 35.243068,
    "longitude": 129.0921,
    "price": 6,
    "count": 29
  },
  {
    "short_address": "강서구",
    "type": 1,
    "latitude": 35.2122179,
    "longitude": 128.98045,
    "price": 6,
    "count": 51
  },
  {
    "short_address": "연제구",
    "type": 1,
    "latitude": 35.176242,
    "longitude": 129.079764,
    "price": 9,
    "count": 68
  },
  {
    "short_address": "수영구",
    "type": 1,
    "latitude": 35.145694,
    "longitude": 129.113186,
    "price": 8,
    "count": 86
  },
  {
    "short_address": "사상구",
    "type": 1,
    "latitude": 35.152624,
    "longitude": 128.99125,
    "price": 2,
    "count": 29
  },
  {
    "short_address": "기장군",
    "type": 1,
    "latitude": 35.244498,
    "longitude": 129.222312,
    "price": 9,
    "count": 85
  },
  {
    "short_address": "대구",
    "type": 0,
    "latitude": 35.87139,
    "longitude": 128.601763,
    "price": 6,
    "count": 40
  },
  {
    "short_address": "중구",
    "type": 1,
    "latitude": 35.8693404,
    "longitude": 128.6062,
    "price": 6,
    "count": 43
  },
  {
    "short_address": "동구",
    "type": 1,
    "latitude": 35.886664,
    "longitude": 128.635609,
    "price": 1,
    "count": 94
  },
  {
    "short_address": "서구",
    "type": 1,
    "latitude": 35.871757,
    "longitude": 128.559175,
    "price": 7,
    "count": 41
  },
  {
    "short_address": "남구",
    "type": 1,
    "latitude": 35.846,
    "longitude": 128.597486,
    "price": 0,
    "count": 22
  },
  {
    "short_address": "북구",
    "type": 1,
    "latitude": 35.885684,
    "longitude": 128.582947,
    "price": 2,
    "count": 87
  },
  {
    "short_address": "수성구",
    "type": 1,
    "latitude": 35.8581654,
    "longitude": 128.630625,
    "price": 8,
    "count": 72
  },
  {
    "short_address": "달서구",
    "type": 1,
    "latitude": 35.8298667,
    "longitude": 128.5327375,
    "price": 3,
    "count": 96
  },
  {
    "short_address": "달성군",
    "type": 1,
    "latitude": 35.7746,
    "longitude": 128.431445,
    "price": 1,
    "count": 63
  },
  {
    "short_address": "인천",
    "type": 0,
    "latitude": 37.4559418,
    "longitude": 126.7051505,
    "price": 8,
    "count": 29
  },
  {
    "short_address": "중구",
    "type": 1,
    "latitude": 37.473781,
    "longitude": 126.621588,
    "price": 7,
    "count": 57
  },
  {
    "short_address": "동구",
    "type": 1,
    "latitude": 37.4738846,
    "longitude": 126.6432125,
    "price": 9,
    "count": 97
  },
  {
    "short_address": "미추홀구",
    "type": 1,
    "latitude": 37.4635229,
    "longitude": 126.6505841,
    "price": 6,
    "count": 12
  },
  {
    "short_address": "연수구",
    "type": 1,
    "latitude": 37.4101675,
    "longitude": 126.67828,
    "price": 1,
    "count": 72
  },
  {
    "short_address": "남동구",
    "type": 1,
    "latitude": 37.447342,
    "longitude": 126.731488,
    "price": 10,
    "count": 22
  },
  {
    "short_address": "부평구",
    "type": 1,
    "latitude": 37.5070563,
    "longitude": 126.7218378,
    "price": 4,
    "count": 93
  },
  {
    "short_address": "계양구",
    "type": 1,
    "latitude": 37.5374147,
    "longitude": 126.7377757,
    "price": 10,
    "count": 1
  },
  {
    "short_address": "서구",
    "type": 1,
    "latitude": 37.545449,
    "longitude": 126.675994,
    "price": 8,
    "count": 23
  },
  {
    "short_address": "강화군",
    "type": 1,
    "latitude": 37.746498,
    "longitude": 126.488052,
    "price": 1,
    "count": 15
  },
  {
    "short_address": "옹진군",
    "type": 1,
    "latitude": 37.446607,
    "longitude": 126.63676,
    "price": 1,
    "count": 5
  },
  {
    "short_address": "광주",
    "type": 0,
    "latitude": 35.160032,
    "longitude": 126.851338,
    "price": 3,
    "count": 78
  },
  {
    "short_address": "동구",
    "type": 1,
    "latitude": 35.1460818,
    "longitude": 126.9232859,
    "price": 10,
    "count": 76
  },
  {
    "short_address": "서구",
    "type": 1,
    "latitude": 35.151969,
    "longitude": 126.890272,
    "price": 1,
    "count": 48
  },
  {
    "short_address": "남구",
    "type": 1,
    "latitude": 35.1330039,
    "longitude": 126.902402,
    "price": 4,
    "count": 9
  },
  {
    "short_address": "북구",
    "type": 1,
    "latitude": 35.17406,
    "longitude": 126.911963,
    "price": 9,
    "count": 1
  },
  {
    "short_address": "광산구",
    "type": 1,
    "latitude": 35.1395085,
    "longitude": 126.7936834,
    "price": 1,
    "count": 80
  },
  {
    "short_address": "대전",
    "type": 0,
    "latitude": 36.3504396,
    "longitude": 127.3849508,
    "price": 10,
    "count": 95
  },
  {
    "short_address": "동구",
    "type": 1,
    "latitude": 36.312169,
    "longitude": 127.454884,
    "price": 6,
    "count": 36
  },
  {
    "short_address": "중구",
    "type": 1,
    "latitude": 36.3256594,
    "longitude": 127.4215464,
    "price": 1,
    "count": 96
  },
  {
    "short_address": "서구",
    "type": 1,
    "latitude": 36.355504,
    "longitude": 127.383844,
    "price": 5,
    "count": 73
  },
  {
    "short_address": "유성구",
    "type": 1,
    "latitude": 36.3623219,
    "longitude": 127.3562683,
    "price": 5,
    "count": 74
  },
  {
    "short_address": "대덕구",
    "type": 1,
    "latitude": 36.346735,
    "longitude": 127.415502,
    "price": 6,
    "count": 52
  },
  {
    "short_address": "울산",
    "type": 0,
    "latitude": 35.5394773,
    "longitude": 129.3112994,
    "price": 9,
    "count": 37
  },
  {
    "short_address": "중구",
    "type": 1,
    "latitude": 35.56945,
    "longitude": 129.3327,
    "price": 5,
    "count": 30
  },
  {
    "short_address": "남구",
    "type": 1,
    "latitude": 35.543798,
    "longitude": 129.330109,
    "price": 9,
    "count": 38
  },
  {
    "short_address": "동구",
    "type": 1,
    "latitude": 35.504844,
    "longitude": 129.416632,
    "price": 8,
    "count": 0
  },
  {
    "short_address": "북구",
    "type": 1,
    "latitude": 35.582709,
    "longitude": 129.361313,
    "price": 5,
    "count": 88
  },
  {
    "short_address": "울주군",
    "type": 1,
    "latitude": 35.5220885,
    "longitude": 129.2422295,
    "price": 1,
    "count": 38
  },
  {
    "short_address": "세종",
    "type": 0,
    "latitude": 36.4803512,
    "longitude": 127.2894325,
    "price": 9,
    "count": 25
  },
  {
    "short_address": "세종시",
    "type": 1,
    "latitude": 36.4803512,
    "longitude": 127.2894325,
    "price": 1,
    "count": 12
  },
  {
    "short_address": "경기",
    "type": 0,
    "latitude": 37.4363177,
    "longitude": 127.550802,
    "price": 9,
    "count": 83
  },
  {
    "short_address": "수원시",
    "type": 1,
    "latitude": 37.263476,
    "longitude": 127.028646,
    "price": 3,
    "count": 82
  },
  {
    "short_address": "장안구",
    "type": 1,
    "latitude": 37.3039709,
    "longitude": 127.0101225,
    "price": 6,
    "count": 58
  },
  {
    "short_address": "권선구",
    "type": 1,
    "latitude": 37.257687,
    "longitude": 126.971911,
    "price": 4,
    "count": 47
  },
  {
    "short_address": "팔달구",
    "type": 1,
    "latitude": 37.2825695,
    "longitude": 127.0200976,
    "price": 10,
    "count": 58
  },
  {
    "short_address": "영통구",
    "type": 1,
    "latitude": 37.2596,
    "longitude": 127.046525,
    "price": 7,
    "count": 50
  },
  {
    "short_address": "성남시",
    "type": 1,
    "latitude": 37.4200267,
    "longitude": 127.1267772,
    "price": 7,
    "count": 76
  },
  {
    "short_address": "수정구",
    "type": 1,
    "latitude": 37.4503957,
    "longitude": 127.1456335,
    "price": 2,
    "count": 30
  },
  {
    "short_address": "중원구",
    "type": 1,
    "latitude": 37.4305233,
    "longitude": 127.1372098,
    "price": 9,
    "count": 21
  },
  {
    "short_address": "분당구",
    "type": 1,
    "latitude": 37.3828195,
    "longitude": 127.1189255,
    "price": 9,
    "count": 16
  },
  {
    "short_address": "의정부시",
    "type": 1,
    "latitude": 37.738083,
    "longitude": 127.033753,
    "price": 10,
    "count": 17
  },
  {
    "short_address": "안양시",
    "type": 1,
    "latitude": 37.3942905,
    "longitude": 126.9567534,
    "price": 1,
    "count": 35
  },
  {
    "short_address": "만안구",
    "type": 1,
    "latitude": 37.386649,
    "longitude": 126.932325,
    "price": 5,
    "count": 25
  },
  {
    "short_address": "동안구",
    "type": 1,
    "latitude": 37.3925739,
    "longitude": 126.9513539,
    "price": 3,
    "count": 20
  },
  {
    "short_address": "부천시",
    "type": 1,
    "latitude": 37.5035917,
    "longitude": 126.766,
    "price": 9,
    "count": 26
  },
  {
    "short_address": "광명시",
    "type": 1,
    "latitude": 37.4786176,
    "longitude": 126.8646504,
    "price": 6,
    "count": 71
  },
  {
    "short_address": "평택시",
    "type": 1,
    "latitude": 36.9923537,
    "longitude": 127.1126947,
    "price": 4,
    "count": 77
  },
  {
    "short_address": "동두천시",
    "type": 1,
    "latitude": 37.903662,
    "longitude": 127.060671,
    "price": 0,
    "count": 71
  },
  {
    "short_address": "안산시",
    "type": 1,
    "latitude": 37.3219123,
    "longitude": 126.8308176,
    "price": 10,
    "count": 24
  },
  {
    "short_address": "상록구",
    "type": 1,
    "latitude": 37.3010813,
    "longitude": 126.8466515,
    "price": 9,
    "count": 6
  },
  {
    "short_address": "단원구",
    "type": 1,
    "latitude": 37.3210171,
    "longitude": 126.8152642,
    "price": 4,
    "count": 58
  },
  {
    "short_address": "고양시",
    "type": 1,
    "latitude": 37.6583981,
    "longitude": 126.8319831,
    "price": 6,
    "count": 72
  },
  {
    "short_address": "덕양구",
    "type": 1,
    "latitude": 37.637471,
    "longitude": 126.832397,
    "price": 5,
    "count": 88
  },
  {
    "short_address": "일산동구",
    "type": 1,
    "latitude": 37.6586218,
    "longitude": 126.7751907,
    "price": 8,
    "count": 25
  },
  {
    "short_address": "일산서구",
    "type": 1,
    "latitude": 37.6779915,
    "longitude": 126.7452891,
    "price": 4,
    "count": 59
  },
  {
    "short_address": "과천시",
    "type": 1,
    "latitude": 37.4292013,
    "longitude": 126.987675,
    "price": 6,
    "count": 22
  },
  {
    "short_address": "구리시",
    "type": 1,
    "latitude": 37.594266,
    "longitude": 127.129632,
    "price": 6,
    "count": 33
  },
  {
    "short_address": "남양주시",
    "type": 1,
    "latitude": 37.635985,
    "longitude": 127.216467,
    "price": 6,
    "count": 100
  },
  {
    "short_address": "오산시",
    "type": 1,
    "latitude": 37.149887,
    "longitude": 127.077462,
    "price": 8,
    "count": 100
  },
  {
    "short_address": "시흥시",
    "type": 1,
    "latitude": 37.380177,
    "longitude": 126.802934,
    "price": 5,
    "count": 99
  },
  {
    "short_address": "군포시",
    "type": 1,
    "latitude": 37.361523,
    "longitude": 126.935338,
    "price": 2,
    "count": 94
  },
  {
    "short_address": "의왕시",
    "type": 1,
    "latitude": 37.3448869,
    "longitude": 126.9682786,
    "price": 2,
    "count": 73
  },
  {
    "short_address": "하남시",
    "type": 1,
    "latitude": 37.5393014,
    "longitude": 127.2148742,
    "price": 7,
    "count": 86
  },
  {
    "short_address": "용인시",
    "type": 1,
    "latitude": 37.2412522,
    "longitude": 127.1774916,
    "price": 8,
    "count": 8
  },
  {
    "short_address": "처인구",
    "type": 1,
    "latitude": 37.234346,
    "longitude": 127.201344,
    "price": 7,
    "count": 82
  },
  {
    "short_address": "기흥구",
    "type": 1,
    "latitude": 37.28045,
    "longitude": 127.114662,
    "price": 3,
    "count": 86
  },
  {
    "short_address": "수지구",
    "type": 1,
    "latitude": 37.3222422,
    "longitude": 127.0977799,
    "price": 2,
    "count": 84
  },
  {
    "short_address": "파주시",
    "type": 1,
    "latitude": 37.760186,
    "longitude": 126.779883,
    "price": 1,
    "count": 62
  },
  {
    "short_address": "이천시",
    "type": 1,
    "latitude": 37.272342,
    "longitude": 127.435034,
    "price": 10,
    "count": 57
  },
  {
    "short_address": "안성시",
    "type": 1,
    "latitude": 37.0080546,
    "longitude": 127.2797732,
    "price": 6,
    "count": 98
  },
  {
    "short_address": "김포시",
    "type": 1,
    "latitude": 37.61535,
    "longitude": 126.715544,
    "price": 9,
    "count": 21
  },
  {
    "short_address": "화성시",
    "type": 1,
    "latitude": 37.199565,
    "longitude": 126.831405,
    "price": 8,
    "count": 11
  },
  {
    "short_address": "광주시",
    "type": 1,
    "latitude": 37.4294306,
    "longitude": 127.2550476,
    "price": 4,
    "count": 93
  },
  {
    "short_address": "양주시",
    "type": 1,
    "latitude": 37.785329,
    "longitude": 127.045847,
    "price": 6,
    "count": 33
  },
  {
    "short_address": "포천시",
    "type": 1,
    "latitude": 37.894867,
    "longitude": 127.2002404,
    "price": 6,
    "count": 84
  },
  {
    "short_address": "여주시",
    "type": 1,
    "latitude": 37.298342,
    "longitude": 127.637082,
    "price": 2,
    "count": 21
  },
  {
    "short_address": "연천군",
    "type": 1,
    "latitude": 38.096738,
    "longitude": 127.074755,
    "price": 3,
    "count": 53
  },
  {
    "short_address": "가평군",
    "type": 1,
    "latitude": 37.831508,
    "longitude": 127.509541,
    "price": 1,
    "count": 0
  },
  {
    "short_address": "양평군",
    "type": 1,
    "latitude": 37.491791,
    "longitude": 127.487597,
    "price": 3,
    "count": 44
  },
  {
    "short_address": "강원",
    "type": 0,
    "latitude": 37.8603672,
    "longitude": 128.3115261,
    "price": 3,
    "count": 18
  },
  {
    "short_address": "춘천시",
    "type": 1,
    "latitude": 37.8813739,
    "longitude": 127.7300034,
    "price": 7,
    "count": 60
  },
  {
    "short_address": "원주시",
    "type": 1,
    "latitude": 37.3423179,
    "longitude": 127.9199688,
    "price": 6,
    "count": 44
  },
  {
    "short_address": "강릉시",
    "type": 1,
    "latitude": 37.752175,
    "longitude": 128.875836,
    "price": 7,
    "count": 40
  },
  {
    "short_address": "동해시",
    "type": 1,
    "latitude": 37.5247583,
    "longitude": 129.1142625,
    "price": 8,
    "count": 68
  },
  {
    "short_address": "태백시",
    "type": 1,
    "latitude": 37.164132,
    "longitude": 128.985735,
    "price": 10,
    "count": 21
  },
  {
    "short_address": "속초시",
    "type": 1,
    "latitude": 38.207169,
    "longitude": 128.59184,
    "price": 4,
    "count": 99
  },
  {
    "short_address": "삼척시",
    "type": 1,
    "latitude": 37.4499354,
    "longitude": 129.1651479,
    "price": 0,
    "count": 34
  },
  {
    "short_address": "홍천군",
    "type": 1,
    "latitude": 37.697207,
    "longitude": 127.888518,
    "price": 9,
    "count": 73
  },
  {
    "short_address": "횡성군",
    "type": 1,
    "latitude": 37.491803,
    "longitude": 127.985022,
    "price": 3,
    "count": 63
  },
  {
    "short_address": "영월군",
    "type": 1,
    "latitude": 37.183774,
    "longitude": 128.46185,
    "price": 0,
    "count": 94
  },
  {
    "short_address": "평창군",
    "type": 1,
    "latitude": 37.37077,
    "longitude": 128.390193,
    "price": 2,
    "count": 81
  },
  {
    "short_address": "정선군",
    "type": 1,
    "latitude": 37.380609,
    "longitude": 128.660871,
    "price": 8,
    "count": 23
  },
  {
    "short_address": "철원군",
    "type": 1,
    "latitude": 38.146861,
    "longitude": 127.313472,
    "price": 4,
    "count": 72
  },
  {
    "short_address": "화천군",
    "type": 1,
    "latitude": 38.106181,
    "longitude": 127.708216,
    "price": 7,
    "count": 93
  },
  {
    "short_address": "양구군",
    "type": 1,
    "latitude": 38.109992,
    "longitude": 127.99,
    "price": 3,
    "count": 46
  },
  {
    "short_address": "인제군",
    "type": 1,
    "latitude": 38.069732,
    "longitude": 128.170352,
    "price": 2,
    "count": 52
  },
  {
    "short_address": "고성군",
    "type": 1,
    "latitude": 38.3806154,
    "longitude": 128.4678625,
    "price": 1,
    "count": 23
  },
  {
    "short_address": "양양군",
    "type": 1,
    "latitude": 38.075493,
    "longitude": 128.619145,
    "price": 1,
    "count": 57
  },
  {
    "short_address": "충북",
    "type": 0,
    "latitude": 36.7853718,
    "longitude": 127.6551404,
    "price": 1,
    "count": 18
  },
  {
    "short_address": "청주시",
    "type": 1,
    "latitude": 36.6424987,
    "longitude": 127.488975,
    "price": 2,
    "count": 20
  },
  {
    "short_address": "상당구",
    "type": 1,
    "latitude": 36.5897552,
    "longitude": 127.5051229,
    "price": 5,
    "count": 43
  },
  {
    "short_address": "서원구",
    "type": 1,
    "latitude": 36.63769,
    "longitude": 127.469488,
    "price": 1,
    "count": 55
  },
  {
    "short_address": "흥덕구",
    "type": 1,
    "latitude": 36.6289675,
    "longitude": 127.3758644,
    "price": 8,
    "count": 47
  },
  {
    "short_address": "청원구",
    "type": 1,
    "latitude": 36.651581,
    "longitude": 127.486671,
    "price": 6,
    "count": 69
  },
  {
    "short_address": "충주시",
    "type": 1,
    "latitude": 36.991105,
    "longitude": 127.926012,
    "price": 8,
    "count": 3
  },
  {
    "short_address": "제천시",
    "type": 1,
    "latitude": 37.132646,
    "longitude": 128.191037,
    "price": 2,
    "count": 8
  },
  {
    "short_address": "보은군",
    "type": 1,
    "latitude": 36.489455,
    "longitude": 127.729485,
    "price": 7,
    "count": 30
  },
  {
    "short_address": "옥천군",
    "type": 1,
    "latitude": 36.3064369,
    "longitude": 127.5714191,
    "price": 7,
    "count": 28
  },
  {
    "short_address": "영동군",
    "type": 1,
    "latitude": 36.175047,
    "longitude": 127.783423,
    "price": 6,
    "count": 47
  },
  {
    "short_address": "증평군",
    "type": 1,
    "latitude": 36.785345,
    "longitude": 127.581507,
    "price": 8,
    "count": 55
  },
  {
    "short_address": "진천군",
    "type": 1,
    "latitude": 36.85542,
    "longitude": 127.435602,
    "price": 4,
    "count": 31
  },
  {
    "short_address": "괴산군",
    "type": 1,
    "latitude": 36.815381,
    "longitude": 127.786704,
    "price": 3,
    "count": 90
  },
  {
    "short_address": "음성군",
    "type": 1,
    "latitude": 36.940282,
    "longitude": 127.690487,
    "price": 2,
    "count": 59
  },
  {
    "short_address": "단양군",
    "type": 1,
    "latitude": 36.984539,
    "longitude": 128.365589,
    "price": 3,
    "count": 25
  },
  {
    "short_address": "충남",
    "type": 0,
    "latitude": 36.6173379,
    "longitude": 126.8453965,
    "price": 0,
    "count": 47
  },
  {
    "short_address": "천안시",
    "type": 1,
    "latitude": 36.815147,
    "longitude": 127.113892,
    "price": 2,
    "count": 61
  },
  {
    "short_address": "동남구",
    "type": 1,
    "latitude": 36.8068502,
    "longitude": 127.1516356,
    "price": 8,
    "count": 63
  },
  {
    "short_address": "서북구",
    "type": 1,
    "latitude": 36.878467,
    "longitude": 127.154648,
    "price": 2,
    "count": 32
  },
  {
    "short_address": "공주시",
    "type": 1,
    "latitude": 36.446556,
    "longitude": 127.11904,
    "price": 10,
    "count": 70
  },
  {
    "short_address": "보령시",
    "type": 1,
    "latitude": 36.333452,
    "longitude": 126.612803,
    "price": 1,
    "count": 53
  },
  {
    "short_address": "아산시",
    "type": 1,
    "latitude": 36.790013,
    "longitude": 127.002474,
    "price": 7,
    "count": 58
  },
  {
    "short_address": "서산시",
    "type": 1,
    "latitude": 36.7849216,
    "longitude": 126.4502766,
    "price": 10,
    "count": 28
  },
  {
    "short_address": "논산시",
    "type": 1,
    "latitude": 36.1872399,
    "longitude": 127.0986227,
    "price": 9,
    "count": 68
  },
  {
    "short_address": "계룡시",
    "type": 1,
    "latitude": 36.274554,
    "longitude": 127.248633,
    "price": 4,
    "count": 57
  },
  {
    "short_address": "당진시",
    "type": 1,
    "latitude": 36.8899744,
    "longitude": 126.6459003,
    "price": 5,
    "count": 78
  },
  {
    "short_address": "금산군",
    "type": 1,
    "latitude": 36.108857,
    "longitude": 127.488213,
    "price": 0,
    "count": 22
  },
  {
    "short_address": "부여군",
    "type": 1,
    "latitude": 36.275658,
    "longitude": 126.909775,
    "price": 8,
    "count": 76
  },
  {
    "short_address": "서천군",
    "type": 1,
    "latitude": 36.080286,
    "longitude": 126.6917418,
    "price": 0,
    "count": 12
  },
  {
    "short_address": "청양군",
    "type": 1,
    "latitude": 36.459151,
    "longitude": 126.802238,
    "price": 7,
    "count": 34
  },
  {
    "short_address": "홍성군",
    "type": 1,
    "latitude": 36.601324,
    "longitude": 126.660775,
    "price": 6,
    "count": 35
  },
  {
    "short_address": "예산군",
    "type": 1,
    "latitude": 36.6808995,
    "longitude": 126.8447382,
    "price": 7,
    "count": 73
  },
  {
    "short_address": "전북",
    "type": 0,
    "latitude": 35.6910153,
    "longitude": 127.2368291,
    "price": 7,
    "count": 60
  },
  {
    "short_address": "완산구",
    "type": 1,
    "latitude": 35.8122,
    "longitude": 127.1198125,
    "price": 5,
    "count": 80
  },
  {
    "short_address": "덕진구",
    "type": 1,
    "latitude": 35.8294,
    "longitude": 127.134362,
    "price": 3,
    "count": 19
  },
  {
    "short_address": "군산시",
    "type": 1,
    "latitude": 35.9676263,
    "longitude": 126.736875,
    "price": 2,
    "count": 55
  },
  {
    "short_address": "익산시",
    "type": 1,
    "latitude": 35.948295,
    "longitude": 126.957786,
    "price": 9,
    "count": 17
  },
  {
    "short_address": "남원시",
    "type": 1,
    "latitude": 35.416432,
    "longitude": 127.390438,
    "price": 0,
    "count": 21
  },
  {
    "short_address": "김제시",
    "type": 1,
    "latitude": 35.8035917,
    "longitude": 126.8808375,
    "price": 3,
    "count": 55
  },
  {
    "short_address": "진안군",
    "type": 1,
    "latitude": 35.7917621,
    "longitude": 127.424875,
    "price": 4,
    "count": 13
  },
  {
    "short_address": "장수군",
    "type": 1,
    "latitude": 35.647366,
    "longitude": 127.5215208,
    "price": 3,
    "count": 1
  },
  {
    "short_address": "임실군",
    "type": 1,
    "latitude": 35.6178286,
    "longitude": 127.2890774,
    "price": 3,
    "count": 63
  },
  {
    "short_address": "순창군",
    "type": 1,
    "latitude": 35.374476,
    "longitude": 127.137489,
    "price": 3,
    "count": 12
  },
  {
    "short_address": "부안군",
    "type": 1,
    "latitude": 35.731755,
    "longitude": 126.733199,
    "price": 8,
    "count": 73
  },
  {
    "short_address": "전남",
    "type": 0,
    "latitude": 34.9007274,
    "longitude": 126.9571667,
    "price": 3,
    "count": 29
  },
  {
    "short_address": "목포시",
    "type": 1,
    "latitude": 34.811875,
    "longitude": 126.3923375,
    "price": 8,
    "count": 26
  },
  {
    "short_address": "순천시",
    "type": 1,
    "latitude": 34.9506984,
    "longitude": 127.487243,
    "price": 10,
    "count": 42
  },
  {
    "short_address": "담양군",
    "type": 1,
    "latitude": 35.321175,
    "longitude": 126.988175,
    "price": 7,
    "count": 34
  },
  {
    "short_address": "구례군",
    "type": 1,
    "latitude": 35.2025096,
    "longitude": 127.4629375,
    "price": 5,
    "count": 41
  },
  {
    "short_address": "장흥군",
    "type": 1,
    "latitude": 34.681622,
    "longitude": 126.9070507,
    "price": 4,
    "count": 5
  },
  {
    "short_address": "영암군",
    "type": 1,
    "latitude": 34.8001638,
    "longitude": 126.6967961,
    "price": 6,
    "count": 99
  },
  {
    "short_address": "완도군",
    "type": 1,
    "latitude": 34.3110391,
    "longitude": 126.7548524,
    "price": 8,
    "count": 84
  },
  {
    "short_address": "경북",
    "type": 0,
    "latitude": 36.6308397,
    "longitude": 128.962578,
    "price": 3,
    "count": 21
  },
  {
    "short_address": "포항시",
    "type": 1,
    "latitude": 36.0190333,
    "longitude": 129.3433898,
    "price": 1,
    "count": 51
  },
  {
    "short_address": "안동시",
    "type": 1,
    "latitude": 36.568425,
    "longitude": 128.7295375,
    "price": 6,
    "count": 95
  },
  {
    "short_address": "영주시",
    "type": 1,
    "latitude": 36.805667,
    "longitude": 128.624063,
    "price": 7,
    "count": 20
  },
  {
    "short_address": "경산시",
    "type": 1,
    "latitude": 35.82509,
    "longitude": 128.741201,
    "price": 7,
    "count": 15
  },
  {
    "short_address": "청송군",
    "type": 1,
    "latitude": 36.4362793,
    "longitude": 129.0571263,
    "price": 4,
    "count": 14
  },
  {
    "short_address": "영덕군",
    "type": 1,
    "latitude": 36.415034,
    "longitude": 129.365267,
    "price": 8,
    "count": 26
  },
  {
    "short_address": "고령군",
    "type": 1,
    "latitude": 35.726177,
    "longitude": 128.263074,
    "price": 8,
    "count": 90
  },
  {
    "short_address": "칠곡군",
    "type": 1,
    "latitude": 35.9955753,
    "longitude": 128.401679,
    "price": 7,
    "count": 71
  },
  {
    "short_address": "봉화군",
    "type": 1,
    "latitude": 36.893114,
    "longitude": 128.732503,
    "price": 2,
    "count": 86
  },
  {
    "short_address": "경남",
    "type": 0,
    "latitude": 35.4414209,
    "longitude": 128.2417453,
    "price": 9,
    "count": 18
  },
  {
    "short_address": "창원시",
    "type": 1,
    "latitude": 35.2278771,
    "longitude": 128.6818746,
    "price": 7,
    "count": 31
  },
  {
    "short_address": "마산합포구",
    "type": 1,
    "latitude": 35.196874,
    "longitude": 128.567863,
    "price": 9,
    "count": 0
  },
  {
    "short_address": "진주시",
    "type": 1,
    "latitude": 35.180325,
    "longitude": 128.107646,
    "price": 6,
    "count": 9
  },
  {
    "short_address": "사천시",
    "type": 1,
    "latitude": 35.0034774,
    "longitude": 128.0638649,
    "price": 1,
    "count": 46
  },
  {
    "short_address": "밀양시",
    "type": 1,
    "latitude": 35.503856,
    "longitude": 128.746712,
    "price": 8,
    "count": 0
  },
  {
    "short_address": "의령군",
    "type": 1,
    "latitude": 35.3222239,
    "longitude": 128.261676,
    "price": 5,
    "count": 64
  },
  {
    "short_address": "창녕군",
    "type": 1,
    "latitude": 35.544611,
    "longitude": 128.492346,
    "price": 2,
    "count": 20
  },
  {
    "short_address": "남해군",
    "type": 1,
    "latitude": 34.837707,
    "longitude": 127.892475,
    "price": 6,
    "count": 8
  },
  {
    "short_address": "함양군",
    "type": 1,
    "latitude": 35.520536,
    "longitude": 127.725245,
    "price": 5,
    "count": 79
  },
  {
    "short_address": "합천군",
    "type": 1,
    "latitude": 35.56666,
    "longitude": 128.165799,
    "price": 7,
    "count": 72
  },
  {
    "short_address": "제주",
    "type": 0,
    "latitude": 33.4273366,
    "longitude": 126.5758344,
    "price": 8,
    "count": 22
  },
  {
    "short_address": "제주시",
    "type": 1,
    "latitude": 33.499568,
    "longitude": 126.531138,
    "price": 9,
    "count": 93
  }
]
"""
