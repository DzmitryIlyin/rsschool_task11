//
//  File.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/15/21.
//

import UIKit

struct Section {
    var title: String
    var data: [[String:String]]
    var kind: SectionKind
}


enum SectionKind {
    case description
    case regularSection
    case image
    case map
}
