//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Miltan on 12/19/17.
//  Copyright © 2017 Milton. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    @IBOutlet weak var storePicker: UIPickerView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        self.storePicker.dataSource = self
        self.storePicker.delegate = self
        
        fetchStores()
        
        if itemToEdit != nil{
            loadExistingItemToEdit(item: itemToEdit!)
        }
        
//        generateStores()
    }
    
    
    
    // MARK: - UIPickerView Components
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //update when store picker is selected
    }
    
    
    
    
    // MARK: - CoreData Task
    func generateStores(){
        let store = Store(context: context)
        store.name = "Best Buy"
        let store1 = Store(context: context)
        store1.name = "Tesla Dealershi"
        let store2 = Store(context: context)
        store2.name = "Frys Electronics"
        let store3 = Store(context: context)
        store3.name = "Cascade"
        let store4 = Store(context: context)
        store4.name = "Amazon"
        let store5 = Store(context: context)
        store5.name = "Wall Mart"
        let store6 = Store(context: context)
        store6.name = "Target Tech"
        appDelegate.saveContext()
    }
    
    
    func fetchStores(){
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do{
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }catch{
            print(error)
        }
    }

    
    @IBAction func saveItem(_ sender: Any) {
        
        var item: Item!
        
        if itemToEdit != nil {
            item = itemToEdit
        }else{
            item = Item(context: context)
        }
        if let title = titleField.text{
            item.title = title
        }
        if let price = priceField.text{
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text{
            item.details = details
        }
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        appDelegate.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    func loadExistingItemToEdit(item: Item) {
        
        if let title = item.title{
            titleField.text = title
        }
        if let price: Double = item.price {
            priceField.text = "\(price)"
        }
        if let details = item.details {
            detailsField.text = details
        }
        if let store = item.toStore?.name {
            
            var index = 0
            repeat{
            
                let s = stores[index]
                if s.name == store {
                    storePicker.selectRow(index, inComponent: 0, animated: true)
                    break
                }
                
                index += 1
            }while index < stores.count
        }
    }
}


























