//
//  MangaReader.swift
//  riidaa
//
//  Created by Pierre on 2025/02/17.
//

import SwiftUI
import LazyPager

public struct MangaReader: View {
    
    @Binding var volume: MangaVolumeModel
    @State var currentPage: Int
    
    @State private var pages: [MangaPageModel] = []
    @State private var currentLine: String? = nil
    
    @State private var pageZoom: CGFloat = 1.0
    @State private var pageLastZoom: CGFloat = 1.0
    @State private var pageZoomAnchor: UnitPoint = .center
    @State private var pageOffset: CGSize = .zero
    @State private var pageInitialOffset: CGSize = .zero
    
    @State private var parserOffset: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var pageHeight = 0.0
    
    private var zoomGesture: some Gesture {
        if #available(iOS 17.0, *) {
            return MagnifyGesture()
                .onChanged { state in
                    pageZoomAnchor = state.startAnchor
                    pageZoom = max(0.5, pageLastZoom * state.magnification)
                }
                .onEnded { _ in
                    if pageZoom <= 1.0 {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            pageInitialOffset = .zero
                            pageOffset = .zero
                            pageZoomAnchor = .center
                        }
                    }
                    pageZoom = max(1.0, pageZoom)
                    pageLastZoom = pageZoom
                }
        } else {
            return MagnificationGesture()
                .onChanged { value in
                    pageZoom = max(0.5, pageLastZoom * value)
                }
                .onEnded { _ in
                    if pageZoom <= 1.0 {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            pageInitialOffset = .zero
                            pageOffset = .zero
                        }
                    }
                    pageZoom = max(1.0, pageZoom)
                    pageLastZoom = pageZoom
                }
        }
    }
    
    public init(volume: Binding<MangaVolumeModel>, currentPage: Int) {
        self._volume = volume
        self._currentPage = State(initialValue: currentPage)
        self._pages = State(initialValue: volume.wrappedValue.pages.array as? [MangaPageModel] ?? [])
    }
    
    public var body: some View {
        GeometryReader { mainGeom in
            let minHeight = min(mainGeom.size.height * 0.2, mainGeom.size.height - pageHeight)
            let maxHeight = mainGeom.size.height * 0.8
            let tHeight1 = (maxHeight + minHeight)/3
            let tHeight2 = 2 * tHeight1
            
            ZStack(alignment: .bottom) {
                TabView(selection: $currentPage) {
                    ForEach(pages.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            let scale = min(geometry.size.width / Double(pages[index].width),
                                            geometry.size.height / Double(pages[index].height))
                            let offsetY = Double(pages[index].height) * scale / 2
                            let offsetX = Double(pages[index].width) * scale / 2
                            ZStack {
                                if abs(index - self.currentPage) <= 2 {
                                    if let imageData = pages[index].getImage() {
                                        Image(uiImage: imageData)
                                            .resizable()
                                            .scaledToFit()
                                    } else {
                                        Text("Page \(index + 1) failed to load")
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(Color(.systemBackground))
                                            .foregroundColor(.primary)
                                    }
                                } else {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .scaledToFit()
                                }
                                MangaReaderBoxes(boxes: pages[index].getBoxes(), scale: scale, offsetX: offsetX, offsetY: offsetY, currentLine: $currentLine)
                            }
                            .frame(maxWidth: .infinity, alignment: .top)
                            .scaleEffect(pageZoom, anchor: pageZoomAnchor)
                            .offset(pageOffset)
                            .onAppear {
                                pageHeight = Double(pages[index].height) * scale
                            }
                            .gesture(
                                zoomGesture
                            ).simultaneousGesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        pageOffset = CGSize(
                                            width: pageInitialOffset.width + gesture.translation.width,
                                            height: pageInitialOffset.height + gesture.translation.height
                                        )
                                    }
                                    .onEnded { _ in
                                        pageInitialOffset = pageOffset
                                    }, isEnabled: pageZoom > 1)
                            .onTapGesture(count: 2) {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    if pageZoom > 1 {
                                        pageZoom = 1.0
                                        pageLastZoom = 1.0
                                        pageOffset = .zero
                                        pageInitialOffset = .zero
                                        pageZoomAnchor = .center
                                    } else {
                                        pageZoom = 2.0
                                        pageLastZoom = 2.0
                                        pageZoomAnchor = .center
                                    }
                                }
                            }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onChange(of: currentPage) { newPage in
                    pageZoom = 1.0
                    pageLastZoom = 1.0
                    pageOffset = .zero
                    pageInitialOffset = .zero
                    pageZoomAnchor = .center
                    self.currentLine = nil
                    volume.lastReadPage = Int64(newPage)
                    DispatchQueue.main.async {
                        CoreDataManager.shared.saveContext()
                    }
                }
                
                VStack(alignment: .center, spacing: 0) {
                    Capsule()
                        .frame(width: 50, height: 6)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    
                    // Text("\(minHeight + offset-dragOffset) \(tHeight1) \(tHeight2) \(dragOffset)")
                    MangaReaderParserView(line: currentLine ?? "")
                        .frame(maxWidth: .infinity)
                }
                .frame(height: max(min(minHeight + parserOffset-dragOffset, maxHeight), minHeight), alignment: .top)
                .background(Color(.systemGray6))
                .roundedCorners(20, corners: [.topLeft, .topRight])
                .gesture(
                    DragGesture(coordinateSpace: .global)
                        .updating($dragOffset) { value, state, tr in
                            state = value.translation.height
                        }
                        .onEnded { value in
                            if minHeight + parserOffset-value.translation.height > tHeight2 {
                                parserOffset = maxHeight - minHeight
                            } else if minHeight + parserOffset-value.translation.height < tHeight1 || value.translation.height > 0 {
                                parserOffset = 0
                            } else {
                                parserOffset = maxHeight - minHeight
                            }
                        }
                )
                .animation(.easeIn(duration: 0.15), value: parserOffset)
            }
        }
        .navigationTitle("\(currentPage + 1)/\(volume.pages.count)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}


#Preview {
    MangaReader(volume: .init(get: {
        CoreDataManager.sampleVolume
    }, set: { _ in }), currentPage: 0)
    .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
}
