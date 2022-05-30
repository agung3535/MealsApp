//
//  CategoryEntity.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 30/05/22.
//

import Foundation

import RealmSwift
class CategoryEntity: Object {
 
  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var desc: String = ""
 
  override static func primaryKey() -> String? {
    return "id"
  }
 
}
