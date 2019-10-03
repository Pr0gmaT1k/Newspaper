//
//  ListTransform.swift
//  Meteo
//
//  Created by azerty on 04/06/2018.
//  Copyright © 2018 Pr0g. All rights reserved.
//


import ObjectMapper
import RealmSwift

class ListTransform<T: RealmSwift.Object>: TransformType where T: Mappable {
    typealias Object = List<T>
    typealias JSON = [AnyObject]
    
    let mapper = Mapper<T>()
    
    func transformFromJSON(_ value: Any?) -> List<T>? {
        let results = List<T>()
        if let value = value as? [AnyObject] {
            for json in value {
                if let obj = mapper.map(JSONObject: json) {
                    results.append(obj)
                }
            }
        }
        return results
    }
    
    func transformToJSON(_ value: Object?) -> [AnyObject]? {
        var results = [AnyObject]()
        if let value = value {
            for obj in value {
                let json = mapper.toJSON(obj)
                results.append(json as AnyObject)
            }
        }
        return results
    }
}
