//
//  CoreDataManager.swift
//  FocusStartTestApplication
//
//  Created by KONSTANTIN TISHCHENKO on 11.10.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "FocusStartTestApplication")
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("An error while saving: \(error.localizedDescription)")
            }
        }
    }
}
//MARK: -Helper functions
extension CoreDataManager {
    
    func createNote() -> Note {
        let note = Note(context: viewContext)
        note.text = ""
        note.id = UUID()
        note.lastUpdated = Date()
        save()
        return note
    }
    
    func createNoteTest() {
        let note = Note(context: viewContext)
        note.text = ""
        note.id = UUID()
        note.lastUpdated = Date()
        save()
    }
    
    func fetchNotes() -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.lastUpdated, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        return (try? viewContext.fetch(request)) ?? []
    }
    
    func delete(_ note: Note) {
        viewContext.delete(note)
        save()
    }
}
