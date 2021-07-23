//
//  CFDataModel.swift
//  CarFax
//
//  Created by Alex Paul on 7/22/21.
//

import Foundation

// MARK: - CarsData
struct CFDataModel:Codable {
    let backfillCount: Int
    let dealerNewCount, dealerUsedCount, enhancedCount: Int
    let listings: [Listing]
    let page, pageSize: Int
    let searchRequest: SearchRequest
}

// MARK: - Listing
struct Listing: Codable {
    let advantage: Bool
    let atomOtherOptions, atomTopOptions: [String]
    let backfill: Bool
    let certified: Bool
    let currentPrice: Int
    let dealer: Dealer
    let dealerType: DealerType
    let distanceToDealer: Double
    let firstSeen: String
    let followCount: Int
    let followedAt: Int?
    let following: Bool
    let hasViewed: Bool
    let id: String
    let imageCount: Int
    let images: Images
    let isEnriched, isOEMPromoted, isOEMRefundFlag: Bool
    let listPrice: Int
    let make: Make
    let mileage: Int
    let mpgCity, mpgHighway: Int
    let noAccidents, oneOwner: Bool
    let onePrice: Int?
    let onlineOnly: Bool
    let personalUse, placed: Bool
    let sentLead: Bool
    let serviceRecords: Bool
    let sortScore: Double
    let stockNumber: String
    let topOptions: [String]
    let tpCostPerVdp: Double
    let tpEligible: Bool
    let vdpURL: String
    let vin: String
    let windowSticker: String
    let year: Int
}

// MARK: - Dealer
struct Dealer:Codable {
    let address: String
    let backfill: Bool
    let carfaxID: String
    let cfxMicrositeURL: String
    let city: String
    let dealerAverageRating: Double
    let dealerInventoryURL: String
    let dealerReviewComments: String
    let dealerReviewCount: Int
    let dealerReviewDate: String
    let dealerReviewRating: Int
    let dealerReviewReviewer, dealerReviewTitle, latitude, longitude: String
    let name: String
    let onlineOnly: Bool
    let phone: String
    let zip: String
}

enum DealerType {
    case new
    case used
}

struct Images {
    let baseURL: String
    let large, medium, small: [String]
}

enum Make:CodingKey {
    case fiat
}

// MARK: - Fiat124_SpiderTrimLevel
struct Fiat124_SpiderTrimLevel:Codable  {
    let count: Int
    let text: String
    let url: String
}

// MARK: - SimilarCar
struct SimilarCar:Codable  {
    let text: String
    let url: String
}


// MARK: - SearchRequest
struct SearchRequest:Codable {
    let make: Make
    let mileageRange: Range
    let priceRange: PriceRange
    let radius: Int
    let srpURL, webHost: String
    let yearRange: Range
    let zip: String
}

// MARK: - Range
struct Range:Codable {
    let max, min: Int
}

// MARK: - PriceRange
struct PriceRange:Codable {
    let min: Int
}
