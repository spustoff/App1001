//
//  HomeViewModel.swift
//  App1001
//
//  Created by IGOR on 11/11/2024.
//

import SwiftUI
import CoreData

final class HomeViewModel: ObservableObject {

    @Published var isAdd: Bool = false
    @Published var isAddImage: Bool = false
    @Published var isDetail: Bool = false
    @Published var isDelete: Bool = false
    @Published var isAddPhoto: Bool = false

    @Published var daysOfWeek: [String] = ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"]
    @Published var currentDayOfWeek = ""
    @Published var dayOfWeekForAdd = ""
    
    @AppStorage("images") var images: [String] = []
    
    @Published var photos: [String] = ["im1", "im2"]
    @Published var currentPhoto = ""

    @Published var scName: String = ""
    @Published var scDay: String = ""
    @Published var scStTime: String = ""
    @Published var scFinTime: String = ""
    @Published var scTeach: String = ""

    @Published var schedules: [SchedModel] = []
    @Published var selectedSched: SchedModel?

    func addSched() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "SchedModel", into: context) as! SchedModel

        loan.scName = scName
        loan.scDay = scDay
        loan.scStTime = scStTime
        loan.scFinTime = scFinTime
        loan.scTeach = scTeach

        CoreDataStack.shared.saveContext()
    }

    func fetchScheds() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<SchedModel>(entityName: "SchedModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.schedules = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.schedules = []
        }
    }
}
