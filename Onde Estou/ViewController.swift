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
        //Definindo a precição da localização
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        //Solicitando permissão para o usuário
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        //Monitorando a localização do usuário
        gerenciadorLocalizacao.startUpdatingLocation()
        
        
    }

    //Verificando se o usuário mudou de ideia e permitiu o acesso a sua localização
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //testando com print se está autorizado, pois no IOS, se for negado não exibe a mensagem novamente.
        /*if status == .authorizedWhenInUse{
            print(" Autorizado ")
        }else{
            print(" Não Autorizado ")}
         */
        //Teste quando o usuário não permitiu o acesso, para exibir um alerta, com as informações de como liberar o acesso
        if status != .authorizedWhenInUse {
            
            var alertaController = UIAlertController(title: "Permissão de Localização!",
                                                     message: "Necessário permissão de acesso a sua localizacao para o funcionamento do APP! ", preferredStyle: .alert)
            
            //Criando os botões para o usuário cancelar ou liberar o acesso
            var acaoConfiguracoes = UIAlertAction(title: "Abrir Configurações", style: .default, handler: { ( alertaConfiguracoes ) in
            
            //Será criada uma Cloure (tipo uma função) pois será utilizada uma vez quando o usuário decidir liberar o acesso.
            if let configuracoes = NSURL(string: UIApplication.openSettingsURLString){
                //antes shared era um método, precisava utilizar os parênteses, vamos utilizar com o método open, vamos utitizar apenas o parametro URL
                UIApplication.shared.open( configuracoes as URL )
                        }
            })
            var acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            //Ação dos botões.
            
            alertaController.addAction(acaoConfiguracoes)
            
            alertaController.addAction(acaoCancelar)
            //Para exibir
            present(alertaController, animated: true, completion: nil)
            
            
            }
        
    }
    


}
