//
//  ViewController.swift
//  JaesoseolAssignment
//
//  Created by 진형진 on 08/05/2019.
//  Copyright © 2019 진형진. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var model: [Model] = []
    let cellIdentifier: String = "cell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "Data") else { return }
        do {
            self.model = try jsonDecoder.decode([Model].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for:indexPath) as? TableViewCell else {
            return TableViewCell()
        }
        
        let model: Model = self.model[indexPath.row]
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "~MM월 dd일 HH시 mm분"
        
        if let date = dateFormatterGet.date(from: model.endTime) {
            cell.date.text = dateFormatterPrint.string(from: date)
        } else {
            print("error")
        }

        
        cell.date.font = UIFont.systemFont(ofSize: 13.0)
        cell.field.text = model.fields
        cell.field.font = UIFont.systemFont(ofSize: 15.0)
        cell.title.text = model.companyName
        cell.title.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: model.image) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        
                        cell.thumb.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        return cell
    }
    
    
}
