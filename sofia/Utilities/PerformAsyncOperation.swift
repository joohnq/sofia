func performAsyncOperation<T, U>(
    asyncTask: @escaping () async -> Result<T, U>,
    success: @escaping (T) -> Void,
    failure: @escaping (U) -> Void
) {
    Task {
        let res = await asyncTask()
        switch res {
        case .success(let message):
            success(message)
        case .failure(let error):
            failure(error)
        }
    }
}

func performOperation<T, U>(
    task: @escaping () -> Result<T, U>,
    success: @escaping (T) -> Void,
    failure: @escaping (U) -> Void
) {
    Task {
        let res = task()
        switch res {
        case .success(let message):
            success(message)
        case .failure(let error):
            failure(error)
        }
    }
}
