//
//  Movie.swift
//  MovieApp
//
//  Created by ZhuangYihan on 10/17/16.
//  Copyright © 2016 ZhuangYihan. All rights reserved.
//

import Foundation
import UIKit

struct Movie {
    var title:String
    var year:String
    var imdbID:String
    var type:String
    var poster:String

    
    init(title:String, year:String, imdbID:String, type:String, poster:String) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.poster = poster
    }
}