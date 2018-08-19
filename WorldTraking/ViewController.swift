//
//  ViewController.swift
//  WorldTraking
//
//  Created by Macbook Pro on 17/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [
            ARSCNDebugOptions.showFeaturePoints,
            ARSCNDebugOptions.showWorldOrigin
        ]
        self.sceneView.session.run(config)
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    func addNode(_ geometry : SCNGeometry)  {
        let node = SCNNode()
        //All values are in meters
        node.geometry = geometry
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        let x : Float = random(minimum: -0.3, max: 0.3)
        let y : Float = random(minimum: -0.3, max: 0.3)
        let z : Float = random(minimum: -0.3, max: 0.3)
        node.position = SCNVector3Make(x,y,z) //X,Y,Z
        sceneView.scene.rootNode.addChildNode(node)
    }

    @IBAction func add() {
        addBox()
        addCapsule()
        addCone()
        addCylinder()
        addPiramid()
        addTourus()
        addSfere()
        addTube()
        addPlane()
        addBezierPath()
    }
    
    func addBezierPath() {
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: 0, y: 0))
        path.addLine(to: CGPoint.init(x: 0, y: 0.2))
        path.addLine(to: CGPoint.init(x: 0.2, y: 0.3))
        path.addLine(to: CGPoint.init(x: 0.4, y: 0.2))
        path.addLine(to: CGPoint.init(x: 0.4, y: 0))
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        addNode(shape)
    }
    
    func addPlane()  {
        let plane = SCNPlane(width: 0.2, height: 0.2)
        addNode(plane)
    }
    
    func addSfere() {
        let sfere = SCNSphere(radius: 0.1)
        addNode(sfere)
    }
    
    func addTube() {
        let tube = SCNTube(innerRadius: 0.05, outerRadius: 0.1, height: 0.2)
        addNode(tube)
    }
    
    func addPiramid() {
        let piramid = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        addNode(piramid)
    }
    
    func addCylinder() {
        let cylinder = SCNCylinder(radius: 0.1, height: 0.2)
        addNode(cylinder)
    }
    
    func addTourus() {
        let object = SCNTorus(ringRadius: 0.2, pipeRadius: 0.05)
        addNode(object)
    }
    
    func addCone() {
        let cone = SCNCone(topRadius:0, bottomRadius: 0.1, height: 0.2)
        addNode(cone)
    }
    
    func addBox() {
        let boxSize : CGFloat = 0.1
        let box = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: boxSize / 4)
        addNode(box)
    }
    
    func addCapsule() {
        let capsule = SCNCapsule(capRadius: 0.1, height: 0.3)
        addNode(capsule)
    }
    
    func random(minimum : Float, max : Float) -> Float {
        return Float(arc4random()) / Float(UINT32_MAX) * abs(max - minimum) + min(max, minimum)
    }
    
    @IBAction func reset() {
        resetSesion()
    }
    
    func resetSesion() {
        sceneView.session.pause()
        sceneView.scene.rootNode.enumerateChildNodes { (node, _) in node.removeFromParentNode()}
        sceneView.session.run(config,options: [.resetTracking,.removeExistingAnchors])
    }
}

