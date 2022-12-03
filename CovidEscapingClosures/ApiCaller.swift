//
//  ApiCaller.swift
//  CovidEscapingClosures
//
//  Created by Marco Alonso Rodriguez on 02/12/22.
//

import Foundation



struct ApiCaller {
    func obtenerListadoPaises(completionHandler: @escaping(_ paises: [Pais]?, _ error: Error?) -> ()) {
        var paises: [Pais] = []
        guard let url = URL(string: "https://api.covid19api.com/summary") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { datos, respuesta, error in
            guard let datos = datos else { return }
            
            do {
                let datosDecodificados = try JSONDecoder().decode(Covid.self, from: datos)
                paises = datosDecodificados.Countries
            } catch {
             print("Error al decodificar")
            }
            completionHandler(paises, nil)
        }
        .resume()
    }
}

