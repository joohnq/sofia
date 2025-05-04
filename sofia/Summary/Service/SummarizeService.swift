import Foundation
import GoogleGenerativeAI
import Observation
import OpenGraphReader
import os

@Observable
public class SummarizeService {
    private let logger = Logger(
        subsystem: "com.joohnq.sofia", category: "summarizer")

    private let model: GenerativeModel

    public init(model: GenerativeModel) {
        self.model = model
    }

    func summarize(_ input: String) async throws -> String {
        let prompt = "Please summarize the following text:" + input
        do {
            let res = try await model.generateContent(prompt)
            guard let text = res.text else {
                throw SummaryError.ResponseEmpty
            }
            logger.debug("Summarizing \(text)")
            return text
        } catch {
            print(error)
            throw SummaryError.ResponseError(error)
        }
    }
}
