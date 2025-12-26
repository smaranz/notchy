import SwiftUI
import AVFoundation

struct CameraMirrorView: View {
    @StateObject private var cameraModel = CameraMirrorModel()
    
    var body: some View {
        ZStack {
            if cameraModel.isAuthorized {
                CameraPreview(session: cameraModel.session)
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.black)
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "video.slash")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(.secondary)
                    Text("Enable camera access to use Mirror")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.9))
            }
        }
        .frame(minWidth: 360, minHeight: 280)
        .background(Color.black)
        .onAppear {
            cameraModel.start()
        }
        .onDisappear {
            cameraModel.stop()
        }
    }
}

final class CameraMirrorModel: ObservableObject {
    @Published var isAuthorized: Bool = false
    let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "CameraMirrorSessionQueue")
    private var videoDeviceInput: AVCaptureDeviceInput?
    
    func start() {
        sessionQueue.async { [weak self] in
            self?.configureSessionIfNeeded()
            self?.session.startRunning()
        }
    }
    
    func stop() {
        sessionQueue.async { [weak self] in
            self?.session.stopRunning()
        }
    }
    
    private func configureSessionIfNeeded() {
        guard session.inputs.isEmpty else { return }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            DispatchQueue.main.async { [weak self] in
                self?.isAuthorized = true
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    self?.isAuthorized = granted
                }
                if granted {
                    self?.configureSessionIfNeeded()
                }
            }
            return
        default:
            DispatchQueue.main.async { [weak self] in
                self?.isAuthorized = false
            }
            return
        }
        
        session.beginConfiguration()
        session.sessionPreset = .high
        
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) ??
                AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified),
              let cameraInput = try? AVCaptureDeviceInput(device: camera),
              session.canAddInput(cameraInput) else {
            DispatchQueue.main.async { [weak self] in
                self?.isAuthorized = false
            }
            session.commitConfiguration()
            return
        }
        
        session.addInput(cameraInput)
        videoDeviceInput = cameraInput
        
        let videoOutput = AVCaptureVideoDataOutput()
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
        
        session.commitConfiguration()
    }
}

struct CameraPreview: NSViewRepresentable {
    let session: AVCaptureSession
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.automaticallyAdjustsVideoMirroring = false
        previewLayer.connection?.isVideoMirrored = true
        previewLayer.frame = view.bounds
        previewLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        view.wantsLayer = true
        view.layer = previewLayer
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        (nsView.layer as? AVCaptureVideoPreviewLayer)?.session = session
    }
}
