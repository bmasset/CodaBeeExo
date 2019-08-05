//
//  Video.swift
//  CodaBee
//
//  Created by Bernard Masset on 26/07/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import Foundation

struct APIResponse: Decodable {
    var items: [Video]
}

struct Video: Decodable {
    var id: ID
    var snippet: Snippet
}

struct ID: Decodable {
    var videoId: String
}

struct Snippet: Decodable {
    var title: String
    var description: String
    var thumbnails : Thumb
}

struct Thumb: Decodable {
    var medium: Image
    var high: Image
}

struct Image: Decodable {
    var url: String
}
