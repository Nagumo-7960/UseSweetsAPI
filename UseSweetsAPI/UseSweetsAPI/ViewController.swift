//
//  ViewController.swift
//  UseSweetsAPI
//
//  Created by なぐも on 2022/07/27.
//

import UIKit
//var Sweets:Data = []

//Dataを構造体で受け取る
struct Sweets:Codable{
    let sweets:[Sweet]

    enum CodingKeys:String, CodingKey{
        case sweets = "sweets"
    }
}

struct Sweet:Codable{
    let name:String
    let imagePath:String
    
    enum CodingKeys:String, CodingKey{
        case name = "name"
        case imagePath = "imagePath"
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getSweetsAPI()
    }


}

private func getSweetsAPI(){
    guard let url = URL(string: "https://sweetsapi.c.fun.ac.jp/sweets")else {return}
    
    let task = URLSession.shared.dataTask(with: url){(data, response, err) in
        if let err = err{
            print("情報の取得に失敗しました。 :", err)
            return
        }
        if let data = data{
            do{
//                print("json: ",data)
                let qiita = try JSONDecoder().decode(Sweets.self, from: data)
                print("json: ", qiita)

            }catch(let err){
                print("情報の取得に失敗しました。:", err)
            }
        }
    }
    
    task.resume()
}



