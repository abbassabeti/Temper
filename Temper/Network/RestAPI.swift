//
//  RestAPI.swift
//  PokemonSDK
//
//  Created by Abbas on 1/6/21.
//


import Foundation
import RxSwift
import Moya
import Alamofire

typealias MoyaError = Moya.MoyaError

enum ApiError: Error {
    case serverError(response: TemperError)
    case connectionError
}

class RestApi: TemperAPIProtocol {
    let temperProvider: TemperNetworking
    let decoder : JSONDecoder = JSONDecoder()

    init(provider: TemperNetworking) {
        self.temperProvider = provider
    }
}

extension RestApi {

    func downloadString(url: URL) -> Single<String> {
        return Single.create { single in
            DispatchQueue.global().async {
                do {
                    single(.success(try String.init(contentsOf: url)))
                } catch {
                    single(.error(error))
                }
            }
            return Disposables.create { }
            }
            .observeOn(MainScheduler.instance)
    }
    func fetchShifts(date: Date) -> Single<Result<ShiftsModel,TemperError>> {
        let dateStr = date.dateString(format: "yyyy-MM-dd")
        return requestObject(.findShifts(date: dateStr), type: ShiftsModel.self)
    }
    func fetchMultiDayShifts(dates: [Date]) -> Single<Result<ShiftsModel,TemperError>> {
        let dateStrs = dates.map({$0.dateString(format: "yyyy-MM-dd")})
        return requestObject(.findMultipleDayShifts(dates: dateStrs), type: ShiftsModel.self)
    }
}
extension RestApi {
    private func request(_ target: TemperAPI) -> Single<Any> {
        return temperProvider.request(target)
            .mapJSON()
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
    private func requestWithoutMapping(_ target: TemperAPI) -> Single<Moya.Response> {
        return temperProvider.request(target)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
    private func requestObject<T: Codable>(_ target: TemperAPI,type: T.Type) -> Single<Result<T, TemperError>> {
        return temperProvider.request(target)
            .debug("log", trimOutput: false).map({ (response) -> Result<T, TemperError> in
                do {
                    switch response.statusCode {
                        case 200...204:
                            let data = String(decoding: response.data, as: UTF8.self)
                            //print("data \(data)")
                            return try .success(self.decoder.decode(T.self,from:response.data))
                        case 429:
                            return .failure(TemperError(code: 429, message: "Shakespeare Ratelimit reached!"))
                        case 500...:
                            return .failure(TemperError(code: 400, message: "Internal Server Error"))
                        default:
                            guard let temperError = try? self.decoder.decode(TemperError.self,from:response.data) else {
                                return .failure(TemperError(unexpected: true))
                            }
                            var error = temperError
                            error.code = response.statusCode
                            return .failure(error)
                            
                    }
                }catch let error{
                    print("error \(error)")
                        return .failure(TemperError(code: response.statusCode, message: error.localizedDescription))
                }

            })
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
    private func requestArray<T:Codable>(_ target: TemperAPI, type: T.Type) -> Single<Result<[T], TemperError>> {
        
        return temperProvider.request(target)
            .debug("log:", trimOutput: false).map({ (response) -> Result<[T], TemperError> in
                do {
                    switch response.statusCode {
                    case 200...204:
                        return try .success(self.decoder.decode([T].self,from:response.data))
                    case 500...:
                        return .failure(TemperError(code: 400, message: "Internal Server Error"))
                    default:
                        guard let temperError = try? self.decoder.decode(TemperError.self,from:response.data) else {
                            return .failure(TemperError(unexpected: true))
                        }
                        var error = temperError
                        error.code = response.statusCode
                        return .failure(error)
                    }
                }catch let error{
                    return .failure(TemperError(code: response.statusCode, message: error.localizedDescription))
                }
                
            })
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
}
