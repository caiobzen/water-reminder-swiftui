//
//  HealthKitSetupAssistant.swift
//  Waterminder
//
//  Created by Tobias Ruano on 8/02/21.
//  Copyright © 2021 Carlos Corrêa. All rights reserved.
//

import HealthKit

class HealthKitSetupAssistant {
    
    private let healthStore = HKHealthStore()
    
    func requestPermissions() {
        guard let dataTypes = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater) else {
            return
        }
        let dataTypesToWrite: Set = [dataTypes]
        
        healthStore.requestAuthorization(toShare: dataTypesToWrite, read: nil, completion: { (success, error) in
            if success {
                print("Authorization complete")
            } else {
                print("Authorization error: \(String(describing: error?.localizedDescription))")
            }
        })
    }
    
    func addWater(waterAmount: Double?, forDate : Date) {
        guard let quantityTypeWater = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater) else {
            return
        }
        let water = HKQuantitySample(type: quantityTypeWater, quantity: HKQuantity.init(unit: HKUnit.literUnit(with: .milli), doubleValue: waterAmount!), start: forDate, end: forDate)
        
        healthStore.save(water) { (success, error) in
            if success {
                print("\(String(describing: waterAmount)) ml of water were Saved: \(success)")
            } else {
                print("Water Error: \(String(describing: error))")
            }
        }
    }
}
