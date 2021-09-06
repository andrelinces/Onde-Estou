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
    //criando referência do mapa.
    @IBOutlet weak var mapa: MKMapView!
    //Instanciando o Objeto
    var gerenciadorLocalizacao = CLLocationManager()
    
    //criando referências das labels
    @IBOutlet weak var velocidadeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var enderecoLabel: UILabel!
    
    
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let localizacaoUsuario: CLLocation = locations.last!
        
        //monta a localização do mapa.
        let latitude: CLLocationDegrees = localizacaoUsuario.coordinate.latitude
        let longitude: CLLocationDegrees = localizacaoUsuario.coordinate.longitude
        
        //Atualizando as informações na tela do usuário
        latitudeLabel.text = String( latitude )
        longitudeLabel.text = String( longitude )
        //Condição para não exibir velocidade quando o usuário estiver parado.
        if localizacaoUsuario.speed > 0 {
            velocidadeLabel.text = String( localizacaoUsuario.speed )
        }
        let deltaLatitude: CLLocationDegrees = 0.01
        let deltaLongitude: CLLocationDegrees = 0.01
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: deltaLatitude, longitudeDelta: deltaLongitude)
        
        let regiao: MKCoordinateRegion = MKCoordinateRegion(center: localizacao, span: areaVisualizacao)

        mapa.setRegion(regiao, animated: true)
        
        //chamando classe CLGeocoder com método Reverse, para recuperar o endereço do usuário
        CLGeocoder().reverseGeocodeLocation(localizacaoUsuario) { detalheLocal, erro in
            //teste if, se for diferente de vazio possui o endereço recuperado.
            if erro == nil {
                
                //Precisa testar a constante, pois os dadosLocal pode nem sempre existir, ou seja, uma localização que não possui a informação do endereço
                if let dadosLocal = detalheLocal?.first {
                //print(dadosLocal)
                //Utilizando a constante criada para recuperar vários dados como, contry, locality...
                    var thoroughfare = ""
                    if dadosLocal.thoroughfare != nil{
                        thoroughfare = dadosLocal.thoroughfare!
                    }
                    
                    var subThoroughfare = ""
                    if dadosLocal.subThoroughfare != nil{
                        subThoroughfare = dadosLocal.subThoroughfare!
                    }
                    
                    var locality = ""
                    if dadosLocal.locality != nil {
                        locality = dadosLocal.locality!
                }
                    var subLocality = ""
                    if dadosLocal.subLocality != nil {
                        subLocality = dadosLocal.subLocality!
                }
                    var postalCode = ""
                    if dadosLocal.postalCode != nil {
                        postalCode = dadosLocal.postalCode!
                }
                    var country = ""
                    if dadosLocal.country != nil {
                        country = dadosLocal.country!
                }
                    var administrativeArea = ""
                    if dadosLocal.administrativeArea != nil {
                        administrativeArea = dadosLocal.administrativeArea!
                }
                    var subAdministrativeArea = ""
                    if dadosLocal.subAdministrativeArea != nil {
                        subAdministrativeArea = dadosLocal.subAdministrativeArea!
                }
                    
                    self.enderecoLabel.text = thoroughfare + " n ̊"
                                                + subThoroughfare + " / "
                                                + locality + " / "
                                                + country + " / "
                    print(
                    
                           "\n / thoroughfare: " + thoroughfare +
                            "\n / subthoroughfare: " + subThoroughfare +
                            "\n / locality: " + locality +
                            "\n / subLocality: " + subLocality +
                            "\n / postalCode: " + postalCode +
                            "\n / country: " + country +
                            "\n / administrativeArea: " + administrativeArea +
                            "\n / subAdministrativeArea: " + subAdministrativeArea
                          )
                }
            }else{
                //Caso não seja possível recuperar o endereço, pode usar um alerta, para melhor entendimento do usuário
                print(erro)
                        
            }
        
            
        }
        
    }
    
    
    /*
    //Atualizando a localização do usuário em tempo real
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //criando variavel, localizacaoUsuario é um array com várias informações do usuário
        let localizacaoUsuario: CLLocation = locations.last!
        
        //Criando constantes, pois latitude e longitude serão utilizados em outro momento.
        let latitude: CLLocationDegrees = localizacaoUsuario.coordinate.latitude
        let longitude: CLLocationDegrees  = localizacaoUsuario.coordinate.latitude
        
        //Atualizando as informações na tela do usuário
        latitudeLabel.text = String( latitude )
        longitudeLabel.text = String( longitude )
        velocidadeLabel.text = String( localizacaoUsuario.speed )
        
        //Exibindo a atualização real do mapa de acordo com a localização do usuário.
        
        
        let deltaLatitude: CLLocationDegrees = 0.01
        let deltaLongitude: CLLocationDegrees = 0.01
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let areaVisualizacao: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: deltaLatitude, longitudeDelta: deltaLongitude)
        
        let regiao: MKCoordinateRegion = MKCoordinateRegion(center: localizacao, span: areaVisualizacao)
        
        mapa.setRegion(regiao, animated: true)
        
        
        }
        */
        
        //Método para exibir o endereço atualizado do usuário
    
        
    
    
    
    
    
        /*
        CLGeocoder().reverseGeocodeLocation(localizacaoUsuario) { ( detalhesLocal, erro ) in
            if erro == nil {
                
                if let dadosLocal = detalhesLocal?.first {
                //print(dadosLocal)
                var thoroughfare = ""
                if dadosLocal.thoroughfare != nil {
                    thoroughfare = dadosLocal.thoroughfare!
                
                }
                    
                    var subThoroughfare = ""
                    if dadosLocal.subThoroughfare != nil {
                        subThoroughfare = dadosLocal.subThoroughfare!
                }
                    
                    var locality = ""
                    if dadosLocal.locality != nil {
                        locality = dadosLocal.locality!
                }
                    var subLocality = ""
                    if dadosLocal.subLocality != nil {
                        subLocality = dadosLocal.subLocality!
                }
                    var postalCode = ""
                    if dadosLocal.postalCode != nil {
                        postalCode = dadosLocal.postalCode!
                }
                    var country = ""
                    if dadosLocal.country != nil {
                        country = dadosLocal.country!
                }
                    var administrativeArea = ""
                    if dadosLocal.administrativeArea != nil {
                        administrativeArea = dadosLocal.administrativeArea!
                }
                    var subAdministrativeArea = ""
                    if dadosLocal.subAdministrativeArea != nil {
                        subAdministrativeArea = dadosLocal.subAdministrativeArea!
                }
                    
                
            }else{
                
                print(
                
                    "\n / thoroughfare "
                
                )
            }
        }
        
    }
    
    }
    */
    //Verificando se o usuário mudou de ideia e permitiu o acesso a sua localização
    /*
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //testando com print se está autorizado, pois no IOS, se for negado não exibe a mensagem novamente.
        /*if status == .authorizedWhenInUse{
            print(" Autorizado ")
        }else{
            print(" Não Autorizado ")}
         */
        //Teste quando o usuário não permitiu o acesso, para exibir um alerta, com as informações de como liberar o acesso
        if status != .authorizedWhenInUse {
            
            let alertaController = UIAlertController(title: "Permissão de Localização!",
                                                     message: "Necessário permissão de acesso a sua localizacao para o funcionamento do APP! ", preferredStyle: .alert)
            
            //Criando os botões para o usuário cancelar ou liberar o acesso
            let acaoConfiguracoes = UIAlertAction(title: "Abrir Configurações", style: .default, handler: { ( alertaConfiguracoes ) in
            
            //Será criada uma Cloure (tipo uma função) pois será utilizada uma vez quando o usuário decidir liberar o acesso.
                if let configuracoes = NSURL(string: UIApplication.openSettingsURLString){
                //antes shared era um método, precisava utilizar os parênteses, vamos utilizar com o método open, vamos utitizar apenas o parametro URL
                UIApplication.shared.open( configuracoes as URL )
                        }
            })
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            //Ação dos botões.
            
            alertaController.addAction(acaoConfiguracoes)
            
            alertaController.addAction(acaoCancelar)
            //Para exibir
            present(alertaController, animated: true, completion: nil)
            
            
            }
        
    }
    

    
}
 */
}
