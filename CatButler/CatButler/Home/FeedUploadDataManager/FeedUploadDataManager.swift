import Alamofire

class FeedUploadDataManager {
    func posts(_ viewController: HomeViewController, _ parameter: FeedUploadInput) {
        AF.request("https://api.thecatapi.com/v1/images/search?", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: FeedUploadModel.self) { response in
            switch response.result {
            case .success(let result):
                if result.isSuccess {
                    print("성공")
                } else {
                    print(result.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
