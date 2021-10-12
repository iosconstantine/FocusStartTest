//
//  NotesViewController.swift
//  FocusStartTestApplication
//
//  Created by KONSTANTIN TISHCHENKO on 11.10.2021.
//

import UIKit

protocol NotesDelegate: AnyObject {
    func refreshNotes()
    func deleteNote(with id: UUID)
}

class NotesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notesCountLabel: UILabel!
    private let searchController = UISearchController()
    
    private var filteredNotes: [Note] = []
    private var allNotes: [Note] = [] {
        didSet {
            var word = ""
            if allNotes.count == 1 {
                word = "\(allNotes.count) заметка"
            } else if allNotes.count > 1 {
                word = "\(allNotes.count) заметки"
            } else {
                word = "Нет заметок"
            }
            notesCountLabel.text = word
            filteredNotes = allNotes
        }
    }
    
    @IBAction func createNewNoteButton(_ sender: UIButton) {
        goToEditNote(createNote())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        tableView.contentInset = .init(top: 0, left: 0, bottom: 30, right: 0)
        setupSearchBar()
        fetchNoteFromStorage()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
    }
    
    private func indexForNote(id: UUID, in list: [Note]) -> IndexPath {
        let row = Int(list.firstIndex(where: { $0.id == id }) ?? 0)
        return IndexPath(row: row, section: 0)
    }
    
    private func goToEditNote(_ note: Note) {
        let controller = storyboard?.instantiateViewController(identifier: EditNotesViewController.identifier) as! EditNotesViewController
        controller.note = note
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
// MARK: - Implementation methods
     private func createNote() -> Note {
        let note = CoreDataManager.shared.createNote()
   
        allNotes.insert(note, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        
        return note
    }
    
    private func fetchNoteFromStorage() {
        allNotes = CoreDataManager.shared.fetchNotes()
    }
    
    private func deleteNoteFromStorage(_ note: Note) {
        deleteNote(with: note.id)
        CoreDataManager.shared.delete(note)
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifier, for: indexPath) as! NotesTableViewCell
        
            let note = filteredNotes[indexPath.row]
            cell.configure(note: note)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToEditNote(filteredNotes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteNoteFromStorage(filteredNotes[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
// MARK: - UISearchControllerDelegate, UISearchBarDelegate
extension NotesViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func search(_ text: String) {
        if text.count >= 1 {
            filteredNotes = allNotes.filter { $0.text.lowercased().contains(text.lowercased()) }
        } else{
            filteredNotes = allNotes
        }
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText)
    }
}
// MARK: - Notes Delegate
extension NotesViewController: NotesDelegate {
    func refreshNotes() {
        allNotes = allNotes.sorted { $0.lastUpdated > $1.lastUpdated }
        tableView.reloadData()
    }
    
    func deleteNote(with id: UUID) {
        let indexPath = indexForNote(id: id, in: filteredNotes)
        filteredNotes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        allNotes.remove(at: indexForNote(id: id, in: allNotes).row)
    }
}
