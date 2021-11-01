//
//  QRScannerViewController.swift
//  MyApp
//
//  Created by Xuan Trung on 30/10/2021.
//

import UIKit
import AVFoundation

final class QRScannerViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var scannerView: UIView!
    
    var presenter: QRScannerPresenter!
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    lazy var scanFrame: CGRect = {
        let width: CGFloat = 260
        let height: CGFloat = 250
        let x = scannerView.center.x - width / 2
        let y = scannerView.center.y - height / 2 - 30
        return CGRect(x: x, y: y, width: width, height: height)
    }()

    deinit {
        LogInfo("\(Swift.type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: presenter as AnyObject)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }

    override func setupUI() {
        super.setupUI()
        
        captureSession = AVCaptureSession()
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = scannerView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        scannerView.layer.addSublayer(previewLayer)
        
        let overlayView = CameraOverlayView()
        view.addSubview(overlayView)
        overlayView.edgeAnchors == scannerView.edgeAnchors

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            captureSession = nil
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: scanFrame)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            captureSession = nil
            return
        }
        
        captureSession.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            handleQR(code: stringValue)
        }
    }
    
    func handleQR(code: String) {
        guard let paymentInfo = decodeQR(code) else {
            let alert = UIAlertController(title: "This QR is invalid.", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                self?.captureSession.startRunning()
            }))
            present(alert, animated: true)
            return
        }
        
        presenter.scanQRSuccess(info: paymentInfo)
    }
    
    private func decodeQR(_ qrcode: String) -> PaymentInfo? {
        return try? JSONDecoder().decode(PaymentInfo.self, from: Data(qrcode.utf8))
    }
    
    override func bindDatas() {
        super.bindDatas()
        
        presenter.bind(isLoading: isLoading)
    }
    
}

extension QRScannerViewController: QRScannerViewInterface {}
