//
//  ViewController.swift
//  Uploader
//
//  Created by Yonat Sharon on 15.12.2016.
//  Copyright © 2016 Yonat Sharon. All rights reserved.
//

import UIKit
import DirectoryUploader

class ViewController: UIViewController {

    let subpath = "Test"
    let fileExtension = "abc"

    @IBOutlet weak var filesTextView: UITextView!

    var fileIndex = 0
    var targetDirectory: URL?
    var files: [URL] = []

    var uploader: DirectoryUploader!

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let targetDirectory = documentsDirectory.appendingPathComponent(subpath,  isDirectory: true)
            self.targetDirectory = targetDirectory
            try FileManager.default.createDirectory(at: targetDirectory, withIntermediateDirectories: true)
        }
        catch {
            print("Error creating targetDirectory at \(subpath): \(error)")
        }

        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateFiles), userInfo: nil, repeats: true).fire()

        uploader = DirectoryUploader(sourceDirectory: targetDirectory!, targetURL: URL(string: "http://www.mocky.io/v2/5185415ba171ea3a00704eed")!)
    }

    // MARK: - Actions

    @IBAction func createNewFile() {
        guard let targetDirectory = targetDirectory else {
            print("nil targetDirectory")
            return
        }
        let fileURL = targetDirectory.appendingPathComponent("file-\(fileIndex)-is-here.\(fileExtension)", isDirectory: false)
        fileIndex += 1
        do {
            try "Lorem Ipsum".write(to: fileURL, atomically: false, encoding: .unicode)
        }
        catch {
            print("Error writing to \(fileURL): \(error)")
        }
    }

    @IBAction func deleteOldFile() {
        do {
            if let firstFile = files.first {
                try FileManager.default.removeItem(at: firstFile)
                files.removeFirst()
            }
        }
        catch {
            print("Error deleting \(files.first!): \(error)")
        }
    }

    func updateFiles() {
        guard let targetDirectory = targetDirectory else {
            print("nil targetDirectory")
            return
        }
        do {
            files = try FileManager.default.contentsOfDirectory(at: targetDirectory, includingPropertiesForKeys: nil, options: [])
        }
        catch {
            print("Error getting contentsOfDirectory: \(error)")
        }
        filesTextView.text = files.map {$0.lastPathComponent} .joined(separator: "\n")

        // update fileIndex
        if let lastFileName = files.last?.lastPathComponent {
            if let numberRange = lastFileName.range(of: "\\d", options: .regularExpression), !numberRange.isEmpty {
                let numberInFileName = lastFileName.substring(with: numberRange)
                if let lastFileIndex = Int(numberInFileName), lastFileIndex >= fileIndex {
                    fileIndex = lastFileIndex + 1
                }
            }
        }
    }
}
