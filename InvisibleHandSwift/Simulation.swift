//
//  Simulation.swift
//  InvisibleHandSwift
//
//  Created by Erik Engheim on 7/9/14.
//  Copyright (c) 2014 Erik Engheim. All rights reserved.
//

import Foundation

func simulate() {
    var producers: [Producer] = []
    for _ in 0..<NUM_OF_PRODUCERS {
        producers.append(Producer(
            price: COST + Double(rand() % MAX_STARTING_PROFIT),
            supply: Double(rand() % MAX_STARTING_SUPPLY)))
    }

    var consumers: [Consumer] = Array(  count: NUM_OF_CONSUMERS,
                                repeatedValue: Consumer())

    var market = Market(producers: producers,
                        consumers: consumers)
    var generatedDemand: [Double] = []
    for n in 0..<SIMULATION_DURATION {
        generatedDemand.append(
            round((sin(Double(n))+2.0)*20.0)
        )
    }
    
    var demandSupply: [(Int, Double, Double)] = []
    var priceDemand: [(Int, Double, Double)] = []
    for t in 0..<SIMULATION_DURATION {
        for consumer in consumers {
            consumer.demands = generatedDemand[t]
        }
        
        demandSupply.append(t, market.demand, market.supply)
        
        for producer in producers {
            producer.produce(market)
        }
        
        priceDemand.append(t, market.averagePrice, market.demand)
        
        while market.demand > 0 && market.supply > 0 {
            for consumer in consumers {
                consumer.buy(market)
            }
        }
    }
    
    writeCSV("demand_supply.csv", demandSupply)
    writeCSV("price_demand.csv", priceDemand)
}

func writeCSV(filename: String, lines: [(Int, Double, Double)]) {
    print(filename)
    println(":")
    for line in lines {
        println("\(line.0), \(line.1), \(line.2)")
    }
}
