//
//  UIState.swift
//  sofia
//
//  Created by Henrique on 11/03/25.
//
import SwiftUI

enum UIState<T: Equatable>: Equatable {
    case none
    case loading
    case success(value: T)
    case error(error: String)
}

extension UIState {
    static func == (lhs: UIState<T>, rhs: UIState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none), (.loading, .loading):
            return true
        case let (.success(value1), .success(value2)):
            return value1 == value2
        case let (.error(error1), .error(error2)):
            return error1 == error2
        default:
            return false
        }
    }

    var isError: Bool {
        if case .error = self {
            return true
        }
        return false
    }

    func handle(
        onNone: (() -> Void)? = nil,
        onLoading: (() -> Void)? = nil,
        onSuccess: ((T) -> Void)? = nil,
        onError: ((String) -> Void)? = nil
    ) {
        switch self {
        case .none:
            onNone?()
        case .loading:
            onLoading?()
        case .success(let value):
            onSuccess?(value)
        case .error(let error):
            onError?(error)
        }
    }

    @ViewBuilder
    func handle(
        onLoading: @escaping () -> some View,
        onSuccess: @escaping (T) -> some View,
        onError: @escaping (String) -> some View
    ) -> some View {
        switch self {
        case .none:
            EmptyView()
        case .loading:
            onLoading()
        case .success(let value):
            onSuccess(value)
        case .error(let error):
            onError(error)
        }
    }
}
