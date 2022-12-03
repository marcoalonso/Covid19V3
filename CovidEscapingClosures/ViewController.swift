//
//  ViewController.swift
//  CovidEscapingClosures
//
//  Created by Marco Alonso Rodriguez on 02/12/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var buscarPais: UITextField!
    @IBOutlet weak var tablaPaises: UITableView!
    
    let apicaller = ApiCaller()
    var listaPaises : [Pais] = []
    var listaPaisesFiltrados: [Pais] = []
    var activityView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buscarPais.delegate = self
        
        showActivityIndicator()
        
        tablaPaises.delegate = self
        tablaPaises.dataSource  = self
        
        obtenerLista()
        
    }
    
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
    func obtenerLista() {
        self.apicaller.obtenerListadoPaises { paises, error in
            if let paises = paises {
                self.listaPaises = paises
                DispatchQueue.main.async {
                    self.listaPaisesFiltrados = self.listaPaises
                    
                    self.tablaPaises.reloadData()
                    self.hideActivityIndicator()
                }
            }
        }
        
        
        
    }
    
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaPaisesFiltrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = listaPaisesFiltrados[indexPath.row].Country
        celda.detailTextLabel?.text = "Casos positivos : \(listaPaisesFiltrados[indexPath.row].TotalConfirmed)"
        return celda
    }
    
    
   
    
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(textField.text ?? "Ningun pais")

        listaPaisesFiltrados = []
        
        //Validar si el texto esta vacio
        if textField.text == "" {
            listaPaisesFiltrados = listaPaises
        } else {
            for pais in listaPaises {
                if pais.Country.lowercased().contains(textField.text!.lowercased()){
                    listaPaisesFiltrados.append(pais)
                }
            }
        }
        //actualizar la tabla
        self.tablaPaises.reloadData()
    }
}
