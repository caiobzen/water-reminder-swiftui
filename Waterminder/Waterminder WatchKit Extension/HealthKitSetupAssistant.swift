//
//  HealthKitSetupAssistant.swift
//  Waterminder
//
//  Created by Tobias Ruano on 8/02/21.
//  Copyright © 2021 Tobias Ruano. All rights reserved.
//

import HealthKit

class HealthKitSetupAssistant {
    
    public let healthStore = HKHealthStore()
    
    public func requestPermissions() {
        let dataTypesToWrite : Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)!]
        
        healthStore.requestAuthorization(toShare: dataTypesToWrite, read: nil, completion: { (success, error) in
            if success {
                print("Authorization complete")
            } else {
                print("Authorization error: \(String(describing: error?.localizedDescription))")
            }
        })
    }
    
    public func addWater(waterAmount: Double?, forDate : Date) {
        let quantityTypeWater = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)!
        let water = HKQuantitySample(type: quantityTypeWater, quantity: HKQuantity.init(unit: HKUnit.literUnit(with: .milli), doubleValue: waterAmount!), start: forDate, end: forDate)
        
        healthStore.save(water) { success, error in
            if (error != nil) {
                print("Water Error: \(String(describing: error))")
            }
            if success {
                print("\(String(describing: waterAmount)) ml of water were Saved: \(success)")
            }
        }
    }
}
