//
//  ContentView.swift
//  network_db
//
//  Created by Michael Edukonis on 2/17/20.
//  Copyright © 2020 Mike Edukonis. All rights reserved.
//

import SwiftUI
import Foundation


struct ContentView: View
{
    @State  var name: String = ""
    @State  var sqft: String = ""
    @State  var task_response: String = ""
    
    var body: some View
    {
        ZStack
        {
            Color.gray
        
            VStack
            {
            
                VStack(spacing: 10)
                {
                    HStack(spacing: 10)
                    {
                        Text("Name:").padding(3)
                        TextField("", text: $name).background(Color.white).frame(width: 200, height: 30)
                    }
                    
                    HStack(spacing: 10)
                    {
                        Text("Sq/Ft:").padding(5)
                        TextField("", text: $sqft).background(Color.white).frame(width: 200, height: 30)
                    }.frame(alignment: .center)
                    
                   
                    Button(action: {self.buttonFunc()})
                    {
                        Text("Post to DB - http")
                    }.padding(.leading, 1).frame(width: 200, height: 50, alignment: .center).background(Color.orange).cornerRadius(8).position(x:232, y:20)
                    
                    
                    
                    Button(action: {self.buttonFunc2()})
                    {
                        Text("Post to DB - https")
                    }.padding(.leading, 1).frame(width: 200, height: 50, alignment: .center).background(Color.green).cornerRadius(8)
                        .position(x:232, y:20)
                    
                
                }.frame(width: 400, height: 200, alignment: .center)
                
                
            }.frame(width: 600, height: 500, alignment: .top)
            
            HStack(spacing: 2
                )
            {
                Text("Response:")
                Text("\(task_response)")
            }.frame(width: 600, height: 20, alignment: .center)
            

        }
        
    }
    
    func buttonFunc()
    {
        print("\"" + self.name + "\"");
        print(self.sqft);
        if (name != "") && (sqft != "")
        {
          let aname = "\"" + self.name + "\""
          let param = NSURLQueryItem(name: "name", value: aname)
          let param2 = NSURLQueryItem(name: "sqft", value: self.sqft)

          let urlComponents = NSURLComponents()
          urlComponents.scheme = "http";
          urlComponents.host = "192.168.1.168";
          urlComponents.port = 4040;
          urlComponents.path = "/post.php";
          urlComponents.queryItems = [(param as URLQueryItem), (param2 as URLQueryItem)]
            print(urlComponents.url as Any)

          let session = URLSession.shared

          let task = session.dataTask(with: urlComponents.url!, completionHandler: {(data, response, error) in
              if error != nil
              {
                print("error=\(error ?? "Default error" as! Error)")
                  return
              }
              
              let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
              
            print("responseString = \(responseString ?? "A Default Value")")
          })

          task.resume()
                
        }
        else
        {
            print("no input provided in one of the boxes \n");
        }

        
    }
    
    
  func buttonFunc2()
    {
        if (name != "") && (sqft != "")
        {
          let aname = "\"" + self.name + "\""
          let param = NSURLQueryItem(name: "name", value: aname)
          let param2 = NSURLQueryItem(name: "sqft", value: self.sqft)

          let urlComponents = NSURLComponents()
          urlComponents.scheme = "https";
          urlComponents.host = "edukonis.com";
          urlComponents.path = "/~medukonis/post.php";
          urlComponents.queryItems = [(param as URLQueryItem), (param2 as URLQueryItem)]
            print(urlComponents.url as Any)

                     let session = URLSession.shared

                     let task = session.dataTask(with: urlComponents.url!, completionHandler: {(data, response, error) in
                         if error != nil
                         {
                            print("error=\(error ?? "A Default String" as! Error)")
                             return
                         }
                         
                         let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                         
                        print("responseString = \(responseString ?? "A Default Value")")
                        
                        self.task_response = "\(responseString ?? "Default Value")";
                     })

                     task.resume()
                           
                   }
                   else
                   {
                       print("no input provided in one of the boxes \n");
                   }
                   
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

