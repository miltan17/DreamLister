
import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var controller: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        generateTestData()
        attemptfetch()
    }
    
    // MARK: - TableView Contents
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections{
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections{
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexpath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func configureCell(cell: ItemCell, indexpath: NSIndexPath){
        let item = controller.object(at: indexpath as IndexPath)
        cell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objects = controller.fetchedObjects, objects.count > 0 {
            
            let item: Item = objects[indexPath.row]
            performSegue(withIdentifier: "itemDetailsVC", sender: item)
        }
    }
    
    // MARK: - Perform Segue Action
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemDetailsVC"{
            if let destination = segue.destination as? ItemDetailsVC {
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
    }
    
    
    // MARK: - Attempt Fetch
    func attemptfetch() {
        let fetchReqest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        fetchReqest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchReqest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.controller = controller
        do{
            try controller.performFetch()
            print("Data fetched")
        }catch{
            let error = error as NSError
            print(error)
        }
    }
    
    
    // MARK: - FetchRequestController contents
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = indexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
             }
            break
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath{
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell: cell, indexpath: indexPath as NSIndexPath)
            }
            break
        case .move:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    func generateTestData(){
        let item = Item(context: context)
        item.title = "MacBook Pro"
        item.price = 2000
        item.details = "Ohhh, I cannot wait for the next release ... just love it."
        
        let item2 = Item(context: context)
        item2.title = "Canon Camera"
        item2.price = 1200
        item2.details = "Why not click the beautiful nature. Wanna bye this really soon"
        
        let item3 = Item(context: context)
        item3.title = "Tesla Series S"
        item3.price = 12200
        item3.details = "Need a ride in my own car. One day this will be my car."
        
        appDelegate.saveContext()
    }
}






































