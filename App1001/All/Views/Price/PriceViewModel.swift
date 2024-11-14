//
//  PriceViewModel.swift
//  App1001
//
//  Created by IGOR on 11/11/2024.
//

import SwiftUI
import CoreData

final class PriceViewModel: ObservableObject {

    @Published var isAdd: Bool = false
    @Published var isAddImage: Bool = false
    @Published var isDetail: Bool = false
    @Published var isDelete: Bool = false
    @Published var isAddCat: Bool = false

    @Published var avatars: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @Published var curAvatar = ""
    
    @AppStorage("categories") var categories: [String] = []
    @Published var addingCategory: String = ""
    @Published var currentCategory: String = ""
    
    @Published var photos: [String] = ["im1", "im2"]
    @Published var currentPhoto = ""

    @Published var prName: String = ""
    @Published var prPrice: String = ""
    @Published var prCat: String = ""

    @Published var prices: [PriceModel] = []
    @Published var selectedPrice: PriceModel?

    func addPrice() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "PriceModel", into: context) as! PriceModel

        loan.prName = prName
        loan.prPrice = prPrice
        loan.prCat = prCat
        
        CoreDataStack.shared.saveContext()
    }

    func fetchPrices() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PriceModel>(entityName: "PriceModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.prices = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.prices = []
        }
    }
}
