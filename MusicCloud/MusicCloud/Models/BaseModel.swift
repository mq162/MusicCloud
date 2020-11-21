//
//  BaseModel.swift
//  MusicCloud
//
//  Created by Quang Pham on 21/11/2020.
//

import ObjectMapper

class BaseModel: Mappable {
    init() {}

    required init?(map: Map) {

    }

    func mapping(map: Map) {
    }

    func getValue(key: String) -> Any! {
        let json = toJSON()
        let map : Map = Map(mappingType: .fromJSON, JSON: json)
        return map[key].currentValue
    }

    func updateValue(key: String, value: Any) {
        var json: [String: Any] = toJSON()
        json[key] = convertData(key: key, value: value)
        let map : Map = Map(mappingType: .fromJSON, JSON: json)
        mapping(map: map)
    }

    func convertData(key: String, value: Any) -> Any? {
        return value
    }

    func validate() -> String {
        return ""
    }
}
