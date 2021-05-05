//
//  TemperNetworking.swift
//  Temper
//
//  Created by Abbas on 5/5/21.
//

import Foundation
import Moya
import RxSwift
import Alamofire

struct TemperNetworking: NetworkingType {
    typealias T = TemperAPI
    let provider: OnlineProvider<TemperAPI>
}

private func newProvider<T>(_ plugins: [PluginType], xAccessToken: String? = nil) -> OnlineProvider<T> where T: TemperAPIType {
    return OnlineProvider(endpointClosure: TemperNetworking.endpointsClosure(xAccessToken),
                          requestClosure: TemperNetworking.endpointResolver(),
                          stubClosure: TemperNetworking.APIKeysBasedStubBehaviour,
                          plugins: plugins)
}

// MARK: - "Public" interfaces
extension TemperNetworking {
    func request(_ token: TemperAPI) -> Observable<Moya.Response> {
        let actualRequest = self.provider.request(token)
        return actualRequest
    }
    
    func upload(_ token: TemperAPI) -> Observable<Moya.ProgressResponse> {
        let actualRequest = self.provider.upload(token)
        return actualRequest
    }
}

// Static methods
extension TemperNetworking {
    static func temperNetworking() -> TemperNetworking {
        return TemperNetworking(provider: newProvider(plugins))
    }

    static func stubbingTemperNetworking() -> TemperNetworking {
        return TemperNetworking(provider: OnlineProvider(endpointClosure: endpointsClosure(), requestClosure: TemperNetworking.endpointResolver(), stubClosure: MoyaProvider.immediatelyStub, online: .just(true)))
    }
}
