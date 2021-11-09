//
//  RocketHelper.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/15/21.
//

import Foundation

class RocketHelper {
    
    private var splitObjects: [Section] = []
        
    func splitRocket(rocket: RocketCard) -> [Section] {
        
        if rocket.isDescription() {
            splitObjects.append(Section(title: "Description", data: [["description": rocket.description!]], kind: .description))
        }
        
        if rocket.isOverview() {
            var data: [[String:String]] = []
            data.append(["First Launch":unwrapProperty(item: rocket.firstFlight)])
            data.append(["Launch cost": "\(unwrapProperty(item: rocket.costPerLaunch))$"])
            data.append(["Success":"\(unwrapProperty(item: rocket.successRatePct))%"])
            data.append(["Mass":"\(unwrapProperty(item: rocket.mass?.kg)) meters"])
            data.append(["Height":"\(unwrapProperty(item: rocket.height?.meters)) meters"])
            data.append(["Diameter":"\(unwrapProperty(item: rocket.diameter?.meters)) meters"])
         
            splitObjects.append(Section(title: "Overview", data: data.removeEmptyProperties(), kind: .regularSection))
        }
        
        if rocket.isImages() {
            var data: [[String:String]] = []
            for (index, value) in rocket.flickrImages!.enumerated() {
                data.append(["\(index)":"\(value)"])
            }
            splitObjects.append(Section(title: "Images", data: data.removeEmptyProperties(), kind: .image))
        }
        
        if rocket.isEngines() {
            var data: [[String:String]] = []
            data.append(["Type":unwrapProperty(item: rocket.engines!.type)])
            data.append(["Layout":unwrapProperty(item: rocket.engines!.layout)])
            data.append(["Version":unwrapProperty(item: rocket.engines!.version)])
            data.append(["Amount":unwrapProperty(item: rocket.engines!.number)])
            data.append(["Propellant 1":unwrapProperty(item: rocket.engines!.propellant1)])
            data.append(["Propellant 2":unwrapProperty(item: rocket.engines!.propellant2)])
            data.append(["ISP":unwrapProperty(item: rocket.engines!.isp?.seaLevel)])
            data.append(["Thrust Sea Level":unwrapProperty(item: rocket.engines!.thrustSeaLevel?.kN)])
            data.append(["Thrust Vacuum":unwrapProperty(item: rocket.engines!.thrustVacuum?.kN)])
            data.append(["Thrust To Weight":unwrapProperty(item: rocket.engines!.thrustToWeight)])

            splitObjects.append(Section(title: "Engines", data: data.removeEmptyProperties(), kind: .regularSection))
        }
        
        if rocket.isFirstStage() {
            var data: [[String:String]] = []
            data.append(["Reusable":unwrapProperty(item: rocket.firstStage!.reusable)])
            data.append(["Engines amount":unwrapProperty(item: rocket.firstStage!.engines)])
            data.append(["Fuel amount": "\(unwrapProperty(item: rocket.firstStage!.fuelAmountTons)) tons"])
            data.append(["Burning time":"\(unwrapProperty(item: rocket.firstStage!.burnTimeSec)) seconds"])
            data.append(["Thrust (sea level)":"\(unwrapProperty(item: rocket.firstStage!.thrustSeaLevel?.kN)) kN"])
            data.append(["Thrust (vacuum)":"\(unwrapProperty(item: rocket.firstStage!.thrustVacuum?.kN)) kN"])
            
            splitObjects.append(Section(title: "First stage", data: data.removeEmptyProperties(), kind: .regularSection))
        }
        
        if rocket.isSecondStage() {
            var data: [[String:String]] = []
            data.append(["Reusable":unwrapProperty(item: rocket.secondStage?.reusable)])
            data.append(["Engines amount":unwrapProperty(item: rocket.secondStage?.engines)])
            data.append(["Fuel amount": "\(unwrapProperty(item: rocket.secondStage!.fuelAmountTons)) tons"])
            data.append(["Burning time":"\(unwrapProperty(item: rocket.secondStage!.burnTimeSec)) seconds"])
            data.append(["Thrust":"\(unwrapProperty(item: rocket.secondStage?.thrust?.kN)) kN"])
                        
            splitObjects.append(Section(title: "Second stage", data: data.removeEmptyProperties(), kind: .regularSection))
        }
        
        if rocket.isLandingLegs() {
            var data: [[String:String]] = []
            data.append(["Amount":unwrapProperty(item: rocket.landingLegs!.number)])
            data.append(["Material":unwrapProperty(item: rocket.landingLegs!.material)])
            
            splitObjects.append(Section(title: "Landing Legs", data: data.removeEmptyProperties(), kind: .regularSection))
        }
        
        return splitObjects
        
    }
    
    private func unwrapProperty<T>(item: Optional<T>) -> String {
        if let value = item {
            return "\(value)"
        }
        return ""
    }
}

extension Array where Element == [String: String] {
    func removeEmptyProperties() -> Array {
        self.filter{$0.first!.value != ""}
    }
}

extension Dictionary where Value: StringProtocol {
    func removeEmptyProperty() -> Dictionary {
        return self.compactMapValues{$0 == "" ? nil : $0}
    }
}
