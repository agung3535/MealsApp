//
//  CategoryMapper.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 29/05/22.
//

import Foundation

final class CategoryMapper {
    
    static func mapCategoryResponseToDomain(input: [CategoryResponse]) -> [CategoryModel] {
        return input.map { result in
            return CategoryModel(id: result.id ?? "",
                                 title: result.title ?? "Unknown",
                                 image: result.image ?? "Unknown",
                                 description: result.description ?? "Unknown")
        }
    }
    
    static func mapCategoryEntityToDomain(input: [CategoryEntity]) -> [CategoryModel] {
        return input.map { result in
            return CategoryModel(id: result.id,
                                 title: result.title,
                                 image: result.image,
                                 description: result.desc)
        }
    }
    
    static func mapCategoryResponsesToEntity(input: [CategoryResponse]) -> [CategoryEntity] {
        return input.map { result in
            let newCategory = CategoryEntity()
            newCategory.id = result.id ?? ""
            newCategory.title = result.title ?? "Unknown"
            newCategory.image = result.image ?? "Unknown"
            newCategory.desc = result.description ?? "Unknown"
            return newCategory
        }
    }
    
}
