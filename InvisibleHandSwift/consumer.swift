//
//  consumer.swift
//  InvisibleHandSwift
//
//  Created by Erik Engheim on 7/9/14.
//  Copyright (c) 2014 Erik Engheim. All rights reserved.
//

import Foundation

class Consumer {
    var demands: Float64 = 0
    
    func buy(market: Market) {
        if demands > 0 && market.supply > 0 {
            let cheapest = market.cheapestProducer
            if cheapest.price > MAX_ACCEPTABLE_PRICE {
                demands *= 0.5
            }
            if demands > cheapest.supply {
                demands - cheapest.supply
                cheapest.supply = 0.0
            }
            else {
                cheapest.supply -= demands
                demands = 0.0
            }
        }
    }
}