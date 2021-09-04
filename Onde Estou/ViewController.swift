//
//  ViewController.swift
//  Onde Estou
//
//  Created by Andre Linces on 03/09/21.
//

import UIKit
import MapKit
//Adicionando classes necessárias para Mapa e localização.
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var Mapa: MKMapView!
    //Instanciando o Objeto
    var gerenciadorLocalizacao = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Quem vai gerenciar o objeto é a própria classe CLLocationManagerDelegate
        gerenciadorLocalizacao.delegate = self
        
    }


}

