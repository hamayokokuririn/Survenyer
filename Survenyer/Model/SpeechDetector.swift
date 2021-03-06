//
//  SpeechController.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/13.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation
import Speech

protocol SpeechControllerDelegate: class {
    func update(_ controller: SpeechDetector, didUpdate text: String)
    
    func update(_ controller: SpeechDetector, availabilityDidChange available: Bool)
}

final class SpeechDetector: NSObject {
    static let shared = SpeechDetector()
    
    weak var delegate: SpeechControllerDelegate?
    
    // "ja-JP"を指定すると日本語になります。
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    override init() {
        super.init()
        requestRecognizerAuthorization()
    }
    
    func chnageRecognition() {
        if audioEngine.isRunning {
            stopRecognition()
            return
        }
        startRecognition()
    }
    
    func startRecognition() {
        if !audioEngine.isRunning {
            try! startRecording()
            delegate?.update(self, availabilityDidChange: true)
        }
    }
    
    func stopRecognition() {
        guard audioEngine.isRunning else {
            return
        }
        DispatchQueue.main.async {
            self.audioEngine.stop()
            self.audioEngine.inputNode.removeTap(onBus: 0)
            self.recognitionRequest?.endAudio()
            self.delegate?.update(self, availabilityDidChange: false)
        }
    }
    
    
    private func requestRecognizerAuthorization() {
        // 認証処理
        SFSpeechRecognizer.requestAuthorization { authStatus in
            // メインスレッドで処理したい内容のため、OperationQueue.main.addOperationを使う
            OperationQueue.main.addOperation { [weak self] in
                guard self != nil else { return }
                
                switch authStatus {
                case .authorized:
                    break
                case .denied:
                    print("音声認識へのアクセスが拒否されています。")
                    break
                case .restricted:
                    print("この端末で音声認識はできません。")
                    break
                case .notDetermined:
                    print("音声認識はまだ許可されていません。")
                    break
                @unknown default:
                    fatalError()
                }
            }
        }
    }
    
    private func startRecording() throws {
        refreshTask()
        
        let audioSession = AVAudioSession.sharedInstance()
        // 録音用のカテゴリをセット
        try audioSession.setCategory(.record)
        try audioSession.setMode(.measurement)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        // 録音が完了する前のリクエストを作るかどうかのフラグ。
        // trueだと現在-1回目のリクエスト結果が返ってくる模様。falseだとボタンをオフにしたときに音声認識の結果が返ってくる設定。
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let self = self else { return }
            
            var isFinal = false
            
            if let result = result {
                self.delegate?.update(self, didUpdate: result.bestTranscription.formattedString)
                isFinal = result.isFinal
                print(result.bestTranscription.formattedString)
            }
            
            // エラーがある、もしくは最後の認識結果だった場合の処理
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.delegate?.update(self, availabilityDidChange: false)
            }
        }
        
        // マイクから取得した音声バッファをリクエストに渡す
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        try startAudioEngine()
    }
    
    func refreshTask() {
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
    }
    
    private func startAudioEngine() throws {
        // startの前にリソースを確保しておく。
        audioEngine.prepare()
        try audioEngine.start()
        delegate?.update(self, availabilityDidChange: true)
    }
    
}
