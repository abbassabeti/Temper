//
//  TemperAPI.swift
//  PokemonSDK
//
//  Created by Abbas on 1/6/21.
//


import Foundation
import RxSwift
import Moya
import Alamofire

protocol TemperAPIType {
    var addXAuth: Bool { get }
}

private let assetDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

protocol TemperAPIProtocol {
    
}

enum TemperAPI {
    case findShifts(date:String)
    case findMultipleDayShifts(dates:[String])
    case other
}

extension TemperAPI: TargetType, TemperAPIType {

    var baseURL: URL {
        switch self {
            case .findShifts:
                return Configs.Network.temperBaseUrl.url!
            case .findMultipleDayShifts:
                return Configs.Network.temperBaseUrl.url!
            default:
                return Configs.Network.temperBaseUrl.url!
        }
    }

    var path: String {
        switch self {
            case .findShifts(_):
                return "/api/v3/shifts"
            case .findMultipleDayShifts(_):
                return "/api/v3/shifts"
            default:
                return ""
        }
    }

    var method: Moya.Method {
        switch self {
            case .findShifts: return .get
            case .findMultipleDayShifts: return .get
            default:
                return .get
        }
    }

    var headers: [String: String]? {
        //TODO: add headers for API if needed
        return nil
    }

    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self{
            case .findShifts(let date):
                params["filter[date]"] = date
            case .findMultipleDayShifts(let dates):
                let dateStr : String = dates.joined(separator: ",")
                params["filter[dates]"] = dateStr
            default:
                break;
        }
        //TODO: customize parameters in the future if needed
        return params
    }

    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var localLocation: URL {
        switch self {
            default: break
        }
        return assetDir
    }

    var downloadDestination: DownloadDestination {
        return { _, _ in return (self.localLocation, .removePreviousFile) }
    }

    public var task: Task {
        switch self {
            default:
                if let parameters = parameters {
                    return .requestParameters(parameters: parameters, encoding: parameterEncoding)
                }
                return .requestPlain
        }
    }

    var sampleData: Data {
        switch self {
        case .findShifts: return getJSONFileData(name:"Masterdata")
        case .findMultipleDayShifts: return getJSONFileData(name:"Masterdata")
            default:
                return Data("".utf8)
        }
    }

    var addXAuth: Bool {
        switch self {
        default: return true
        }
    }
    
    func getJSONFileData(name: String) -> Data {
        var data: Data? = nil
        Bundle.allBundles.forEach { (bundle) in
         if let path = bundle.url(forResource: name, withExtension: "json"){
                do {
                      let _data = try Data(contentsOf: path, options: .mappedIfSafe)
                      data = _data
                  } catch {
                  }
            }
        }
        return data ?? Data()
    }
}
