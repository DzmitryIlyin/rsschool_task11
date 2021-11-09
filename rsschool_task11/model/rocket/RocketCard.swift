////
////  RocketCard.swift
////  rsschool_task11
////
////  Created by dzmitry ilyin on 9/10/21.
////

import Foundation

struct RocketCard: Codable {

    let id: String
    let name: String?
    let type: String?
    let active: Bool?
    let stages: Float?
    let boosters: Int?
    let costPerLaunch: Int?
    let successRatePct: Int?
    let firstFlight: String?
    let country: String?
    let company: String?
    let height: Dimension?
    let diameter: Dimension?
    let mass: Mass?
    let payloadWeights: PayloadWeights?
    let firstStage: FirstStage?
    let secondStage: SecondStage?
    let engines: Engine?
    let landingLegs: LandingLegs?
    
    let flickrImages: [String]?
    let wikipedia: String?
    let description: String?
    
}

struct PayloadWeights: Codable {
}

struct Payloads: Codable {
    let option_1: String?
    let compositeFairing: Composite
}

struct Composite: Codable {
    let height: Dimension?
    let diameter: Dimension?
    
}

struct Dimension: Codable {
    let meters: Float?
    let feet: Float?
}

struct Mass: Codable {
    let kg: Float?
    let lb: Float?
}

struct FirstStage: Codable {
    let reusable: Bool?
    let engines: Int?
    let fuelAmountTons: Float?
    let burnTimeSec: Float?
    let thrustSeaLevel: ThrustLevel?
    let thrustVacuum: ThrustLevel?
}

struct SecondStage: Codable {
    let reusable: Bool?
    let engines: Int?
    let fuelAmountTons: Float?
    let burnTimeSec: Float?
    let thrust: ThrustLevel?
    let payloads: Payloads?
}

struct ThrustLevel: Codable {
    let kN: Float?
    let lbf: Float?
}

struct Engine: Codable {
    let number: Float?
    let type: String?
    let version: String?
    let layout: String?
    let isp: ISP?
    let engineLossMax: Float?
    let propellant1: String?
    let propellant2: String?
    let thrustSeaLevel: ThrustLevel?
    let thrustVacuum: ThrustLevel?
    let thrustToWeight: Float?
}

struct ISP: Codable {
    let seaLevel: Float?
    let vacuum: Float?
}

struct LandingLegs: Codable {
    let number: Int?
    let material: String?
}


extension RocketCard {
    func isDescription() -> Bool {
        return self.description != nil
    }
    
    func isOverview() -> Bool {
        return self.firstFlight != nil || self.costPerLaunch != nil || self.successRatePct != nil || self.mass != nil || self.height != nil || self.diameter != nil
    }
    
    func isImages() -> Bool {
        return self.flickrImages != nil
    }
    
    func isEngines() -> Bool {
        self.engines?.number != nil || self.engines?.type != nil || self.engines?.version != nil || self.engines?.layout != nil || self.engines?.isp != nil || self.engines?.engineLossMax != nil || self.engines?.propellant1 != nil || self.engines?.propellant2 != nil || self.engines?.thrustSeaLevel != nil || self.engines?.thrustVacuum
            != nil || self.engines?.thrustToWeight != nil
    }
    
    func isFirstStage() -> Bool {
        self.firstStage?.reusable != nil && self.firstStage?.engines != nil || self.firstStage?.fuelAmountTons != nil || self.firstStage?.burnTimeSec != nil || self.firstStage?.thrustSeaLevel != nil || self.firstStage?.thrustVacuum != nil
    }
    
    func isSecondStage() -> Bool {
        self.secondStage?.reusable != nil || self.secondStage?.engines != nil || self.secondStage?.fuelAmountTons != nil || self.secondStage?.burnTimeSec != nil || self.secondStage?.thrust != nil || self.secondStage?.payloads != nil
    }

    func isLandingLegs() -> Bool {
        self.landingLegs?.number != nil || self.landingLegs?.material != nil
    }
    
    func isMatherials() -> Bool {
        self.wikipedia != nil
    }
}
