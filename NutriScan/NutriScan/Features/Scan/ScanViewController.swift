//
//  ScanViewController.swift
//  NutriScan
//
//  Created by Eder Junior Alves Silva on 22/10/25.
//

import UIKit
import SwiftUI
import AVFoundation

class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
        var onCodeDetected: ((String) -> Void)?
    
    // AVFoundation para a Câmera
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var metadataOutput: AVCaptureMetadataOutput!
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Aponte para o código de barras do produto"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let scannerBoxView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scanLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        view.layer.shadowColor = UIColor.red.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = .zero
        
        return view
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        checkCameraPermissions()
        
        setupOverlayLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let session = captureSession, !session.isRunning {
             startCameraSession()
        }
        
        animateScanLine()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession?.isRunning == true {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.stopRunning()
            }
        }
    }
    
    // MARK: - Setup
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            DispatchQueue.main.async {
                self.setupCamera()
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        self?.setupCamera()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.showCameraPermissionError()
                    }
                }
            }
        case .denied, .restricted:
            print("Acesso à câmera negado ou restrito.")
            showCameraPermissionError()
        @unknown default:
            fatalError("Status de permissão da câmera desconhecido.")
        }
    }
    
    private func showCameraPermissionError() {
        instructionLabel.text = "Ative o acesso à câmera nas configurações para escanear."
    }
    
    private func setupCamera() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("Falha ao obter o dispositivo de captura de vídeo.")
            // Se estiver no simulador, a câmera não existe.
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("Falha ao criar a entrada de vídeo: \(error)")
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            print("Não foi possível adicionar a entrada de vídeo à sessão.")
            captureSession = nil
            return
        }
        
        metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean13, .ean8, .qr, .code128, .upce]
            
        } else {
            print("Não foi possível adicionar a saída de metadados à sessão.")
            captureSession = nil
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        
        view.layer.insertSublayer(previewLayer, at: 0)
        
        startCameraSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        previewLayer?.frame = view.layer.bounds
        
        guard let previewLayer = previewLayer, let metadataOutput = metadataOutput else { return }
        
        // Converte as coordenadas da 'scannerBoxView' (UIKit) para coordenadas da câmera (visuais)
        // O metadataOutputRectConverted espera coordenadas da layer
        let visualRect = scannerBoxView.frame
        
        // Converte as coordenadas da 'scannerBoxView' (UIKit) para coordenadas da câmera
        let rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: visualRect)
        
        // Define a área de scan
        metadataOutput.rectOfInterest = rectOfInterest
    }
    
    private func startCameraSession() {
        if let session = captureSession, !session.isRunning {
            DispatchQueue.global(qos: .userInitiated).async {
                session.startRunning()
            }
        }
    }
    
    private func setupOverlayLayout() {
        view.addSubview(scannerBoxView)
        
        view.addSubview(instructionLabel)
        
        let topLeft = CornerView(roundedCorners: [.layerMinXMinYCorner])
        let topRight = CornerView(roundedCorners: [.layerMaxXMinYCorner])
        let bottomLeft = CornerView(roundedCorners: [.layerMinXMaxYCorner])
        let bottomRight = CornerView(roundedCorners: [.layerMaxXMaxYCorner])
        
        [topLeft, topRight, bottomLeft, bottomRight].forEach {
            view.addSubview($0)
        }
        
        scannerBoxView.addSubview(scanLineView)
        scannerBoxView.clipsToBounds = true
        
        
        // Caixa de Scan
        NSLayoutConstraint.activate([
            scannerBoxView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scannerBoxView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scannerBoxView.widthAnchor.constraint(equalToConstant: 280),
            scannerBoxView.heightAnchor.constraint(equalToConstant: 200),
            
            // Rótulo
            instructionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            instructionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            instructionLabel.topAnchor.constraint(equalTo: scannerBoxView.bottomAnchor, constant: 24),
            
            // Linha de Scan
            scanLineView.leadingAnchor.constraint(equalTo: scannerBoxView.leadingAnchor),
            scanLineView.trailingAnchor.constraint(equalTo: scannerBoxView.trailingAnchor),
            scanLineView.topAnchor.constraint(equalTo: scannerBoxView.topAnchor), // Posição inicial para animação
            scanLineView.heightAnchor.constraint(equalToConstant: 3), // Um pouco mais espessa
            
            // Cantos fixados na caixa
            topLeft.leadingAnchor.constraint(equalTo: scannerBoxView.leadingAnchor),
            topLeft.topAnchor.constraint(equalTo: scannerBoxView.topAnchor),
            topLeft.widthAnchor.constraint(equalToConstant: 30),
            topLeft.heightAnchor.constraint(equalToConstant: 30),
            
            // Canto Superior Direito
            topRight.trailingAnchor.constraint(equalTo: scannerBoxView.trailingAnchor),
            topRight.topAnchor.constraint(equalTo: scannerBoxView.topAnchor),
            topRight.widthAnchor.constraint(equalToConstant: 30),
            topRight.heightAnchor.constraint(equalToConstant: 30),
            
            // Canto Inferior Esquerdo
            bottomLeft.leadingAnchor.constraint(equalTo: scannerBoxView.leadingAnchor),
            bottomLeft.bottomAnchor.constraint(equalTo: scannerBoxView.bottomAnchor),
            bottomLeft.widthAnchor.constraint(equalToConstant: 30),
            bottomLeft.heightAnchor.constraint(equalToConstant: 30),
            
            // Canto Inferior Direito
            bottomRight.trailingAnchor.constraint(equalTo: scannerBoxView.trailingAnchor),
            bottomRight.bottomAnchor.constraint(equalTo: scannerBoxView.bottomAnchor),
            bottomRight.widthAnchor.constraint(equalToConstant: 30),
            bottomRight.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    // MARK: - Animação
    
    private func animateScanLine() {
        if scannerBoxView.bounds.height == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.animateScanLine()
            }
            return
        }
                let finalY = scannerBoxView.bounds.height - scanLineView.bounds.height
        
        self.scanLineView.transform = .identity
        
        UIView.animate(withDuration: 2.0, delay: 0, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
            self.scanLineView.transform = CGAffineTransform(translationX: 0, y: finalY)
        }, completion: nil)
    }
    
    func pauseScanAnimation() {
        scanLineView.layer.removeAllAnimations()
    }
    
    func restartScanning() {
        DispatchQueue.main.async {
            self.instructionLabel.text = "Aponte para o código de barras do produto"
        }

        startCameraSession()
        
        animateScanLine()
    }
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard captureSession.isRunning else { return }
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            
            guard let stringValue = readableObject.stringValue else { return }
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            
            captureSession.stopRunning()
            pauseScanAnimation()
            
            DispatchQueue.main.async {
                self.instructionLabel.text = "Código: \(stringValue)"
            }
            
            self.onCodeDetected?(stringValue)
        } else {
             if !captureSession.isRunning {
                 startCameraSession()
             }
         }
    }
}


// MARK: - SwiftUI Wrapper
struct ScanViewControllerWrapper: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ScanViewController
    
    @ObservedObject var delegate: ScanDelegate
    
    var isLinkActive: Binding<Bool>? = nil
    
    func makeUIViewController(context: Context) -> ScanViewController {
        let vc = ScanViewController()
        
        vc.onCodeDetected = { barcode in
            delegate.handleBarcode(barcode)
        }
        
        delegate.restartScanAction = {
            vc.restartScanning()
        }
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ScanViewController, context: Context) {
        
    }
    
}


// MARK: - CornerView

private class CornerView: UIView {

    let roundedCorners: CACornerMask
    let thickness: CGFloat = 4
    let cornerRadiusValue: CGFloat = 10
    
    private var borderLayers: [CALayer] = []

    init(roundedCorners: CACornerMask) {
        self.roundedCorners = roundedCorners
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        layer.cornerRadius = cornerRadiusValue
        layer.maskedCorners = roundedCorners
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        borderLayers.forEach { $0.removeFromSuperlayer() }
        borderLayers.removeAll()

        if roundedCorners == .layerMinXMinYCorner {
            addBorder(edge: .top, color: .white, thickness: thickness)
            addBorder(edge: .left, color: .white, thickness: thickness)
        } else if roundedCorners == .layerMaxXMinYCorner {
            addBorder(edge: .top, color: .white, thickness: thickness)
            addBorder(edge: .right, color: .white, thickness: thickness)
        } else if roundedCorners == .layerMinXMaxYCorner {
            addBorder(edge: .bottom, color: .white, thickness: thickness)
            addBorder(edge: .left, color: .white, thickness: thickness)
        } else if roundedCorners == .layerMaxXMaxYCorner {
            addBorder(edge: .bottom, color: .white, thickness: thickness)
            addBorder(edge: .right, color: .white, thickness: thickness)
        }
    }
    
    private func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: bounds.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: bounds.height - thickness, width: bounds.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: bounds.height)
        case .right:
            border.frame = CGRect(x: bounds.width - thickness, y: 0, width: thickness, height: bounds.height)
        default:
            break
        }
        border.backgroundColor = color.cgColor
        layer.addSublayer(border)
        borderLayers.append(border)
    }
}

