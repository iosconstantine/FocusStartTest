//
//  Note.swift
//  FocusStartTestApplication
//
//  Created by KONSTANTIN TISHCHENKO on 11.10.2021.
//
import Foundation

class Note {
    let id = UUID()
    var text: String = ""
    var lastUpdated: Date = Date()
    
    var title: String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? "" // Возвращает первую строку
    }
    
    var description: String {
        var lines = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        lines.removeFirst()
        return "\(lastUpdated.format()) \(lines.first ?? "")" // Возвращает вторую строку
    }
}
