//
//  PlaceSearchNetworkWorker.swift
//  CleanWeather
//
//  Created by 18592232 on 13.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

protocol PlaceSearchNetworkWorkerProtocol {
    func getTownPrediction(prediction: String, comletion: @escaping ([String]) -> ())
}

class PlaceSearchNetworkWorker: PlaceSearchNetworkWorkerProtocol {
    
    weak var networkManager = (UIApplication.shared.delegate as! AppDelegate).networkManager

    
    func getTownPrediction(prediction: String, comletion: @escaping ([String]) -> ()) {
        guard let predictionURL = URL(string: prediction),
                let networkManager = networkManager
        else { return }
        
        networkManager.fetchResult(url: predictionURL, parser: JSONPredictionParser()) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    comletion(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

class PlaceSearchNetworkOperation: Operation {
    
    weak var networkManager = (UIApplication.shared.delegate as! AppDelegate).networkManager
    var prediction: String
    var result: [String]?
    
    init(prediction: String) {
        self.prediction = prediction
        super.init()
    }
    
    enum State: String {
    case ready
    case executing
    case finished
        
        var keyPass: String {
            return "is" + rawValue.capitalized
        }
    }
    var state: State = .ready {
        willSet {
            willChangeValue(forKey: newValue.keyPass)
            willChangeValue(forKey: state.keyPass)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPass)
            didChangeValue(forKey: state.keyPass)
        }
    }
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    override var isExecuting: Bool {
        return state == .executing
        
    }
    override var isFinished: Bool {
        return state == .finished
    }
    
    override func start() {
        if self.isCancelled {
            state = .finished
            return
        }
        main()
        state = .executing
    }
    
    override func cancel() {
        super.cancel()
        state = .finished
    }
    
    override func main() {
        getTownPrediction(prediction: prediction) { (data) in
            self.result = data
            self.state = .finished
        }
    }
    
    func getTownPrediction(prediction: String, comletion: @escaping ([String]) -> ()) {
        guard let predictionURL = URL(string: prediction),
                let networkManager = networkManager
        else { return }
        sleep(1)
        if self.isCancelled {
            return
        }
        networkManager.fetchResult(url: predictionURL, parser: JSONPredictionParser()) { result in
            switch result {
            case .success(let data):
                comletion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
