//
//  DummyService.swift
//  mono
//

import Foundation
import Moya

enum DummyService {
    case hello
}

extension DummyService : TargetType {
    var baseURL: URL { URL(string: "https://fjarm.xyz")! }

    var path: String {
        switch self {
        case .hello:
            return "/hello"
        }
    }

    var method: Moya.Method {
        switch self {
        case .hello:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .hello:
            return .requestPlain // Send no request parameters
        }
    }

    var headers: [String : String]? {
        return nil
    }
}
