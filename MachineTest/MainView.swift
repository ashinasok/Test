//
//  MainView.swift
//  MachineTest
//
//  Created by Ashin Asok on 29/11/17.
//  Copyright © 2017 Ashin Asok. All rights reserved.
//

import UIKit

class MainView: UITableViewController {
    
    var list = [jsonBasedModel]()
    var elements: [String] = []
    var imageURLs : [String] = []
    var element = ""
    var count = 0
    var items = 0
    var i = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainViewCell
        cell.header?.text = list[indexPath.row].header
        self.count = list[indexPath.row].element.count
        self.items = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? MainViewCell else{
            return
        }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }

}

//MARK: - Json Data Parse

extension MainView{
    
    func loadData(){
        let filepath = Bundle.main.path(forResource: "data", ofType: "json")
        if let filepath = filepath{
            do{
                let fileURL = URL(fileURLWithPath: filepath)
                let jsonData = try Data(contentsOf: fileURL , options: .mappedIfSafe )
                let jsonEntry = JSON(jsonData)
                let sections = jsonEntry["sections"].array!
                for section in sections{
                    let heading = section["title"].string!
                    //print("\n \(heading)\n")
                    let items = section["items"].array!
                    for item in items{
                        let image = item["parameter"]["image_url"].string!
                        imageURLs.append(image)
                        if let name = item["parameter"]["name"].string{
                            //print("\(name)! : \(image)")
                            elements.append(name)
                        }else{
                            let title = item["parameter"]["title"].string!
                            //print("\(title) : \(image)")
                            elements.append(title)
                        }
                    }
                    let jsonElement = jsonBasedModel(header: heading, element: elements, imageUrl: imageURLs)
                    list.append(jsonElement)
                    elements = []
                    imageURLs = []
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }catch{
                print("ERROR")
            }
        }
    }
}

extension MainView: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[collectionView.tag].element.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! ElementsCell
        cell.titleName.text = list[collectionView.tag].element[indexPath.item]
        let url = URL(string: list[collectionView.tag].imageUrl[indexPath.item])
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
        if data != nil{
                let image = UIImage(data: data!)
                if image != nil{
                        DispatchQueue.main.async(execute: {
                            cell.imageViewElement.image = image
                        })
                    }
                }
            }
        task.resume()
        return cell
    }
}
