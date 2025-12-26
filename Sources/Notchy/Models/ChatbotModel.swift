import Foundation

enum ChatRole: String, Codable {
    case user
    case assistant
}

struct ChatMessage: Identifiable, Codable {
    let id: UUID
    let role: ChatRole
    let content: String
    
    init(id: UUID = UUID(), role: ChatRole, content: String) {
        self.id = id
        self.role = role
        self.content = content
    }
}

@MainActor
final class ChatbotModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var input: String = ""
    @Published var isSending: Bool = false
    @Published var errorMessage: String?
    
    func send(apiKey: String) {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Add your API key in Settings to chat."
            return
        }
        
        let userMessage = ChatMessage(role: .user, content: trimmed)
        messages.append(userMessage)
        input = ""
        errorMessage = nil
        isSending = true
        
        Task {
            do {
                let reply = try await requestCompletion(apiKey: apiKey, messages: messages)
                messages.append(ChatMessage(role: .assistant, content: reply))
            } catch {
                errorMessage = "Chat error: \(error.localizedDescription)"
            }
            isSending = false
        }
    }
    
    private func requestCompletion(apiKey: String, messages: [ChatMessage]) async throws -> String {
        struct RequestMessage: Codable {
            let role: String
            let content: String
        }
        
        struct Payload: Codable {
            let model: String
            let messages: [RequestMessage]
            let max_tokens: Int
        }
        
        struct Choice: Codable {
            let message: RequestMessage
        }
        
        struct ResponseBody: Codable {
            let choices: [Choice]
        }
        
        let requestMessages = messages.map { RequestMessage(role: $0.role.rawValue, content: $0.content) }
        let payload = Payload(model: "gpt-5-nano", messages: requestMessages, max_tokens: 256)
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONEncoder().encode(payload)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 {
            let body = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(domain: "Chatbot", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: body])
        }
        
        let decoded = try JSONDecoder().decode(ResponseBody.self, from: data)
        if let first = decoded.choices.first {
            return first.message.content
        } else {
            throw NSError(domain: "Chatbot", code: -1, userInfo: [NSLocalizedDescriptionKey: "No response"])
        }
    }
}
