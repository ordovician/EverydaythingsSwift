//
//  market.swift
//  InvisibleHandSwift
//
//  Created by Erik Engheim on 7/9/14.
//  Copyright (c) 2014 Erik Engheim. All rights reserved.
//

import Foundation

class Market  {
    var producers: [Producer]
    var counsumers: [Consumer]
    
    init(producers: [Producer], consumers: [Consumer]) {
        self.producers = producers
        self.counsumers = consumers
    }
    
    var averagePrice: Float64 {
        return producers.map({p in p.price}).reduce(0.0, +) / Float64(producers.count)
    }
    
    var supply: Float64 {
        return producers.map({p in p.supply}).reduce(0.0, +)
    }
    
    var demand: Float64 {
        return counsumers.map({c in c.demands}).reduce(0.0, +)
    }
    
    var cheapestProducer: Producer {
        let producers = self.producers.filter {f in f.supply > 0 }
        return producers.reduce(Producer()) {memo, supplier in
                if memo.supply == 0 || supplier.price < memo.price {
                    return supplier
                }
                else {
                    return memo
                }
            }
    }
}