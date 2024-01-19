//
//  ViewModel.swift
//  BitenTechincalTask
//
//  Created by Александр Кузьминов on 13.01.24.
//

import Foundation


final class NatureViewModel {
    
    private let networkService = NetworkService()
    var isLoading = false
    var hasMoreData = true
    var id = 1
    var dataModel: [CustomModel] = []
    let numberOfIterations = 10
    var data: [CustomModel] = []
    
    
    func loadMultipleData(completion: @escaping (Result<[CustomModel], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var resultData: [CustomModel] = []
        for i in 0..<10 {
            let currentId = id + i
            dispatchGroup.enter()
            loadData(idReq: currentId) { result in
                defer {
                    dispatchGroup.leave()
                }
                switch result {
                case .success(let dataModel):
                    resultData.append(contentsOf: dataModel)
                case .failure(let error):
                    completion(.failure(error))
                    
                    return
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.id += 10
            completion(.success(resultData))
        }
    }
//
    func loadData(idReq: Int, completion: @escaping (Result<[CustomModel], Error>) -> Void) {
        networkService.fetchNature(id: idReq) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let welcome):
                guard !(welcome.isEmpty) else {
                    completion(.failure(URLError(.dataNotAllowed)))
                    print("array is empty")
                    return
                }
                let newModels = welcome.map { CustomModel(
                    image: "http://shans.d2.i-partner.ru\($0.image)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                    description: $0.description,
                    name: $0.name,
                    type: "http://shans.d2.i-partner.ru\($0.categories.icon)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                    
                }
                self.dataModel.append(contentsOf: (newModels))
                completion(.success(self.dataModel))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func countOFitems() -> Int {
        return numberOfIterations
    }
    func numberOfRows() -> Int {
        return dataModel.count
    }
    
    func getCats(index: Int) -> CustomModel {
        return dataModel[index]
    }
    func resetID() {
        id = 1
        dataModel = []
    }
}
