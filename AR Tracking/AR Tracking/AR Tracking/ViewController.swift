//
//  ViewController.swift
//  AR Tracking
//
//  Created by Eric Martinez on 8/7/18.
//  Copyright © 2018 Eric Martinez. All rights reserved.
//

import UIKit
import AudioToolbox
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    //AR WORLD TRACKING CONFIGURATION: Uses the back-facing camera, tracks a device's orientation and position, and detects real-world surfaces, and known images or objects.
    
    let configuration = ARWorldTrackingConfiguration()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Indicates if the world origan was detected and if feature points are constantly being discovered. 
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        
        //Code is needed to recognize ARWorldTrackingConfiguration.
        self.sceneView.session.run(configuration)
        
        // Turns the lights on for the Specular Shading
        
        self.sceneView.autoenablesDefaultLighting = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    @IBAction func add(_ sender: Any) {
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        let node = SCNNode()
        // node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
        //        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        //        let path = UIBezierPath()
        //        path.move(to: CGPoint(x: 0, y: 0))
        //        path.addLine(to: CGPoint(x:0, y: 0.2))
        //        path.addLine(to: CGPoint(x: 0.2, y:0.3))
        //        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        //        path.addLine(to: CGPoint(x: 0.4, y: 0))
        //        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        //        node.geometry = shape
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.position = SCNVector3(0.2,0.3,-0.2)
        boxNode.position = SCNVector3(0, -0.05, 0)
        doorNode.position = SCNVector3(0,-0.02,0.053)
        self.sceneView.scene.rootNode.addChildNode(node)
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
   

        
//        //NODE: Position in Space. No shape,size,color.
//        let node = SCNNode()
//
//        //NODE ATTRIBUTES:
//        node.geometry = SCNPyramid(width: 0.2, height: 0.3, length: 0.2)
//
//        // NODE LIGHT
//        // SPECULAR SHADING: Describes the amount and color of light reflected by the material directly toward the viewer
//
//        node.geometry?.firstMaterial?.specular.contents = UIColor.white
//
//        // NODE COLOR:
//
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//
//        // RANDOM NODE PLACEMENT
//        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let z = randomNumbers(firstNum: -0.6, secondNum: -0.4)
//
//        // NODE POSITION in the real world:
//
//            node.position = SCNVector3(x,y,z)
//
//        self.sceneView.scene.rootNode.addChildNode(node)
    }
    @IBAction func resetButton(_ sender: Any) {
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

        self.restartSession()
    }
    //Function Resets
    func restartSession() {
        
        //STOPS DECETION from your position/orientation
        self.sceneView.session.pause()
        
        // REMOVES NODE FROM SCENE
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
            
        }
        
        // RERUN SESSION.
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
        //ANCHORS: Information of the position and orientation of an object in the scene view.
        
    
    }
    
    // Places Nodes in random directions instead of just one.
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}

