//
//  StaffViewModel.swift
//  App1001
//
//  Created by IGOR on 11/11/2024.
//

import SwiftUI
import CoreData

final class StaffViewModel: ObservableObject {

    @Published var isAdd: Bool = false
    @Published var isAddImage: Bool = false
    @Published var isDetail: Bool = false
    @Published var isDelete: Bool = false

    @Published var avatars: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @Published var curAvatar = ""
    
    @AppStorage("images") var images: [String] = []
    
    @Published var photos: [String] = ["im1", "im2"]
    @Published var currentPhoto = ""
    
    @AppStorage("categories") var categories: [String] = []
    @Published var addingCategory: String = ""
    @Published var currentCategory: String = ""

    @Published var stName: String = ""
    @Published var stProf: String = ""
    @Published var stSal: String = ""
    @Published var stTask: String = ""
    @Published var stType: String = ""
    @Published var stPhoto: String = ""

    @Published var staffs: [StaffModel] = []
    @Published var selectedStaff: StaffModel?

    func addStaff() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "StaffModel", into: context) as! StaffModel

        loan.stName = stName
        loan.stProf = stProf
        loan.stSal = stSal
        loan.stTask = stTask
        loan.stType = stType
        loan.stPhoto = stPhoto

        CoreDataStack.shared.saveContext()
    }

    func fetchStaffs() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<StaffModel>(entityName: "StaffModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.staffs = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.staffs = []
        }
    }
}
