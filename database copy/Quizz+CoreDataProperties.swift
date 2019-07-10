//
//  Quizz+CoreDataProperties.swift
//  dz1
//
//  Created by five on 6/27/19.
//  Copyright © 2019 five. All rights reserved.
//
//

import Foundation
import CoreData


extension Quizz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quizz> {
        return NSFetchRequest<Quizz>(entityName: "Quizz")
    }

    @NSManaged public var category: String
    @NSManaged public var descr: String
    @NSManaged public var id: Int32
    @NSManaged public var image: String
    @NSManaged public var level: Int32
    @NSManaged public var questions: [Questionn]
    @NSManaged public var title: String

}
