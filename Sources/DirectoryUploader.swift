//
//  DirectoryUploader.swift
//  Automatically upload files from sourceDirectory to targetURL and then delete them.
//
//  Created by Yonat Sharon on 15.12.2016.
//  Copyright © 2016 Yonat Sharon. All rights reserved.
//

import Foundation
import iMonitorMyFiles

open class DirectoryUploader: NSObject, TABFileMonitorDelegate, URLSessionTaskDelegate
{
    public init(sourceDirectory: URL, targetURL: URL, filenameParameterName: String? = nil) {
        self.sourceDirectory = sourceDirectory
        self.targetURL = targetURL
        self.filenameParameterName = filenameParameterName
        fileMonitor = TABFileMonitor(url: sourceDirectory)
        super.init()
        fileMonitor.delegate = self
    }

    /// automatically called when a new file is added to sourceDirectory, BUT you may want to call upload() from applicationDidBecomeActive(_:)
    open func upload() { // call on app did become active, did finish launching, etc
        if let urlSession = urlSession {
            urlSession.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
                if nil == uploadTasks.first {$0.state == .running} {
                    self.uploadAllFiles()
                }
            }
        }
        else {
            uploadAllFiles()
        }
    }

    open let sourceDirectory: URL
    open let targetURL: URL
    open let filenameParameterName: String?
    public private(set) var urlSession: URLSession?
    private var fileMonitor: TABFileMonitor

    private func uploadAllFiles() {
        guard let targetFiles = try? FileManager.default.contentsOfDirectory(at: sourceDirectory, includingPropertiesForKeys: nil, options: []) else {return}
        guard targetFiles.count > 0 else {
            urlSession?.invalidateAndCancel()
            urlSession = nil
            return
        }
        if nil == urlSession {
            urlSession = URLSession(configuration: .background(withIdentifier: "DirectoryUploader"), delegate: self, delegateQueue: nil)
        }
        guard let urlSession = urlSession else {return}
        for targetFile in targetFiles {
            let filename = targetFile.lastPathComponent
            var urlRequest = URLRequest(url: targetURL.appendingQueryItem(name: filenameParameterName, value: filename))
            urlRequest.httpMethod = "PUT"
            guard FileManager.default.isReadableFile(atPath: targetFile.path) else {continue}
            let uploadTask = urlSession.uploadTask(with: urlRequest, fromFile: targetFile)
            uploadTask.taskDescription = filename
            uploadTask.resume()
        }
    }

    // MARK: - URLSessionTaskDelegate

    open func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        // upload completed - delete file
        if nil == error, let fileName = task.taskDescription {
            try? FileManager.default.removeItem(at: sourceDirectory.appendingPathComponent(fileName))
        }
    }

    // MARK: - TABFileMonitorDelegate

    open func fileMonitor(_ fileMonitor: TABFileMonitor!, didSee changeType: TABFileMonitorChangeType) {
        upload()
    }
}

extension URL {
    func appendingQueryItem(name: String?, value: String?) -> URL {
        guard let name = name else {return self}
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {return self}
        let item = URLQueryItem(name: name, value: value)
        var queryItems = components.queryItems ?? []
        queryItems.append(item)
        components.queryItems = queryItems
        return components.url ?? self
    }
}
