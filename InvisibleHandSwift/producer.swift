//
//  producer.swift
//  InvisibleHandSwift
//
//  Created by Erik Engheim on 7/9/14.
//  Copyright (c) 2014 Erik Engheim. All rights reserved.
//

import Foundation

class Producer {
    var price: Float64
    var supply: Float64
    
    init(price: Float64, supply: Float64) {
        self.price = price
        self.supply = supply
    }
    
    convenience init() {
        self.init(price: 0, supply: 0)
    }
    
    func generateGoods(market: Market) {
        if price > COST {
            supply += SUPPLY_INCREMENT
        }
    }
    
    func produce(market: Market) {
        if supply > 0 {
            if price > COST {
                price = max(price * PRICE_DECREMENT, COST)
            }
        }
        else {
            price *= PRICE_INCREMENT
            generateGoods(market)
        }
    }
}