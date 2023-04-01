import Foundation

class APIManger {
    static let shared = APIManger()
    
    public func registerRequest(user: User, completion: @escaping (Result<Token, Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.register.rawValue) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(user)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    print(response.statusCode)
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(Token.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func authenticateRequest(username: String, password: String, completion: @escaping (Result<Token, Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.login.rawValue) else {
            return
        }
        
        var request = URLRequest(url: url)
        let data = "username=\(username)&password=\(password)".data(using: .utf8)
        request.httpMethod = "POST"
        request.httpBody = data
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(Token.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func sessionHystoryRequest(completion: @escaping (Result<[Session], Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.shiftsMy.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode([Session].self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func tasksRequest(completion: @escaping (Result<[Activity], Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.tasksActive.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    print(response.statusCode)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode([Activity].self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func allTasksRequest(completion: @escaping (Result<[Activity], Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.tasksAll.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    print(response.statusCode)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode([Activity].self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func upcomingSessionsRequest(completion: @escaping (Result<[Session], Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.shiftsUpcoming.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode([Session].self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func newsAllRequest(completion: @escaping (Result<[New], Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.newsAll.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode([New].self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func usersAllRequest(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.usersAll.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    print(response.statusCode)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func addSessionRequest(session: Session, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.shiftAdd.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(session)
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    print(response.statusCode)
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(String.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func addTaskRequest(task: Activity, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.taskAdd.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(task)
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    print(response.statusCode)
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(String.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func submitTaskRequest(id: String, answer: ActivityAnswer, completion: @escaping (Result<TaskAnswer, Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.submitTask.rawValue + "/\(id)") else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.httpBody = try? JSONEncoder().encode(answer)
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    print(response.statusCode)
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(TaskAnswer.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func bookRequest(id: String, completion: @escaping (Result<TaskAnswer, Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.bookShift.rawValue + "/\(id)") else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    print(response.statusCode)
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(TaskAnswer.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func postNewRequest(new: New, completion: @escaping (Result<TaskAnswer, Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.newsAdd.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(new)
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    print(response.statusCode)
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(TaskAnswer.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func taskResponsesRequest(completion: @escaping (Result<[ActivityResponse], Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.responses.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode([ActivityResponse].self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func checkTaskRequest(id: String, completion: @escaping (Result<TaskAnswer, Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.approveTask.rawValue + "/\(id)") else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(TaskAnswer.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func approveBookingRequest(id: String, completion: @escaping (Result<TaskAnswer, Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.approveShift.rawValue + "/\(id)") else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(TaskAnswer.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func getBookingsRequest(completion: @escaping (Result<[BookingResponse], Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.bookingsAll.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    print(response.statusCode)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode([BookingResponse].self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func getAchievements(completion: @escaping (Result<[Activity], Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.achievements.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    print(response.statusCode)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode([Activity].self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func getMeRequest(completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.userMe.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    print(response.statusCode)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func updateUserRequest(user: RedactedUser, email: String, completion: @escaping (Result<TaskAnswer, Error>) -> Void) {
        let formattedEmail = email.split(separator: "@")
        let finalEmail = formattedEmail[0] + "%40" + formattedEmail[1]
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.updateUser.rawValue + "?email=\(finalEmail)") else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try? JSONEncoder().encode(user)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    print(response.statusCode)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(TaskAnswer.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    public func updateMe(user: RedactedUser, completion: @escaping (Result<TaskAnswer, Error>) -> Void) {
        guard let url = URL(string: "http://91.228.152.247:8180" + Endpoints.updateMe.rawValue) else {
            return
        }
        
        guard let token = RegisterManger.shared.token?.accessToken else {
            print("No authorization")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try? JSONEncoder().encode(user)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            DispatchQueue.main.async {
                guard response.statusCode == 200 else {
                    _ = try? JSONDecoder().decode(Answer.self, from: data)
                    print(response.statusCode)
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(TaskAnswer.self, from: data)
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()

    }
}

struct Answer: Decodable {
    var detail: String?
}

struct TaskAnswer: Decodable {
    var status: String?
    var message: String?
}

private extension APIManger {
    enum Endpoints: String {
        case register = "/auth/register"
        case login = "/auth/login"
        case userMe = "/user/me"
        case newsAll = "/news/all"
        case shiftsMy = "/shifts/my"
        case tasksAll = "/tasks/all"
        case tasksActive = "/tasks/active"
        case shiftsUpcoming = "/shifts/upcoming"
        case usersAll = "/user/all"
        case shiftAdd = "/shifts/add"
        case taskAdd = "/tasks/add"
        case submitTask = "/tasks/submit"
        case bookShift = "/shifts/reserve"
        case newsAdd = "/news/add"
        case responses = "/tasks/response/list/for_check"
        case approveTask = "/tasks/check"
        case approveShift = "/shifts/approve"
        case bookingsAll = "/shifts/reservations"
        case achievements = "/tasks/my"
        case updateUser = "/user/update"
        case updateMe = "/user/update-me"
    }
}
