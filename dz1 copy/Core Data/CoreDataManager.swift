//
//  CoreDataManager.swift
//  dz1
//
//  Created by five on 6/13/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import CoreData
final class CoreDataManager {
    
    //init je bespotreban, neka se naznaci to
    private init() {}
    
    //instanca klase
    static let shared=CoreDataManager()
    
    //u persistentContainer cemo spremat stvari
    lazy var persistentContainer: NSPersistentContainer = {
        let container=NSPersistentContainer(name: "Database")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error=error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //context se koristi u sklopu sa persistentContainerom
    lazy var context=persistentContainer.viewContext
    
    //necemo direktno zvat context(=persistentContainer.viewContext) save, da se uvjerimo da se nesto promijenilo od zadnjeg puta kad smo spremali podatke => ako 2 puta zovemo func persistentContainer.save(), spremiti će se jednom
    func save(){
        let context=persistentContainer.viewContext
        if context.hasChanges{
            do {
                try context.save()
                print("Saved")
            } catch {
                let nserror=error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //da imamo sta manje koda kad radimo fetch iz CoreData
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        //ako saljemo klasu Users, vratit ce "Users", a ako saljemo klasu npr. Pets, ovo ce vratit "Pets"
        let entityName=String(describing: objectType)
        
        //ovo je metoda zahtjeva
        let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do{
            //neka vrati objekte i ako je prazan, pomocu ?? pod naredbe, vratiti ce nil
            let fetchedObjects=try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        }catch{
            print(error)
            //ako se dogodila greska vrati nill
            return [T]()
        }
        
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        save()
    }
}

