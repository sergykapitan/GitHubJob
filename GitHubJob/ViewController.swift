//
//  ViewController.swift
//  GitHubJob
//
//  Created by Sergey Koriukin on 03.10.2018.
//  Copyright © 2018 Sergey Koriukin. All rights reserved.
//

import UIKit
import Foundation
import Alamofire






class ViewController: UIViewController {
    
    
fileprivate var items = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

   
    
    @IBOutlet weak var TableView: UITableView!
    
   
    
    @IBOutlet weak var UserText: UITextField!
    
    @IBOutlet weak var Cell: UITableViewCell!
    
   
    
    @IBAction func ButtonSearch(_ sender: Any) {
        
        
            
         
              var ip: Int = 0
            
           
                
                
                
                
                
                
               
                
                
                var myString = String(ip)     //перевод Int в String
                
                
                let userText2 = UserText.text?.lowercased()  //значение TextField
                
                
                UserText!.resignFirstResponder()   //закрытие клавиатуры
                
                
                let urlGitHub = "https://jobs.github.com/positions.json?search="
                
                guard let gitUrl = URL(string: urlGitHub + userText2! + "&amp;page=" + myString)
                    else { return }
                //--------------------------------------alamofire------------------------------------------------------------------
                Alamofire.request(gitUrl, method: .get).responseJSON { response in
                    guard response.result.isSuccess else {                  //Возвращает значение "true", если результат успешен
                        print("Ошибка при запросе данных\(String(describing: response.result.error))")
                        return
                    }
                    
                    guard let arrayOfItems = response.result.value as? [[String:AnyObject]]
                        else {
                            print("Не могу перевести в массив")
                            return
                    }
                    
                    for itm in arrayOfItems {
                        let item = Item(
                            //   albimID: itm["albumId"] as! Int,
                            //   id: itm["id"] as! Int,
                            //
                            title: itm["title"] as? String ?? "Defolt",
                            
                            location: itm["location"] as? String ?? "Defolt",
                            
                            company_logo: itm["company_logo"] as? String ?? "Defolt"
                        )
                        self.items.append(item)
                    }
                    
                }
                
                
                
           
       
            
            
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    }

    



//обработка url картинки
extension UIImageView {
    
    func downloadedFrom(link:String) {
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
            guard let data = data , error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { () -> Void in
                self.image = image
            }
        }).resume()
    }
    
}
//-----------------------------------------------------------------------------------------------------------

//заполнение таблицы

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    // метод устанавливает количество строк по поличеосту элементов в массиве с объектами.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    // метод который возвращает ячейку таблицы для нужной строки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ItemCell
        configureCell(cell: cell, for: indexPath)
        return cell
    }
    
    private func configureCell(cell: ItemCell, for indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        cell.locationLabel.text = "\(item.location)"
        cell.titleLabel.text = "\(item.title)  "
        cell.companyLogo?.downloadedFrom(link: item.company_logo)
     //   cell.indexRowLabel?.text =   "\(indexPath.row)"
    }
    
    
}
