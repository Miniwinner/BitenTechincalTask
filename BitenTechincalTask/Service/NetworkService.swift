//
//  NetworkService.swift
//  BitenTechincalTask
//
//  Created by Александр Кузьминов on 13.01.24.
//http://shans.d2.i-partner.ru/upload/drugs/categories//protraviteli_08fd860e.png

import Foundation
class NetworkService {
    func fetchNature(id:Int, completion: @escaping (Result<[NatureElement], Error>) -> Void) {
        guard let urlNature = URL(string: "http://shans.d2.i-partner.ru/api/ppp/index/?id=\(id)&limit=1") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let requestNature = URLRequest(url: urlNature)
        URLSession.shared.dataTask(with: requestNature) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let natureData = try self.parseJson(type: [NatureElement].self, data: data)
                completion(.success(natureData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func parseJson<T: Codable>(type: T.Type, data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
enum NetworkError: Error {
    case invalidURL
    case noData
}
