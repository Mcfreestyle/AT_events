
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView ({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 206, 196, 196),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Perfil',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              letterSpacing: 2,
            ),
          ),
        ),        
      ), 
      body: Column(
        children: [
          SizedBox(height: 15,),
          SizedBox(
            height: 150,
            width: 800,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2018/01/16/05/13/nice-3085333_960_720.jpg'),
                ),
                Positioned(
                  bottom: -8,
                  right: 100,
                  child: RawMaterialButton(
                    onPressed: (){},
                    elevation: 2.0,
                    fillColor: Color(0xFFF5F6F9),
                    child: Icon(Icons.camera_alt,
                    color: Colors.blue,
                    ),
                    padding: EdgeInsets.all(1.0),
                    shape: CircleBorder(), 
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
            
          Container(
            height: 254,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 94, 94, 94),
              borderRadius: BorderRadius.circular(20)
            ),
            padding: EdgeInsets.all(8.0),
            child: Column(
            children: [
            Column(
              children: [
                Container(
                  height: 40.0,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,    
                    borderRadius: BorderRadius.circular(20),  
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.person),
                      Text(
                        ' Name: ',
                        style: TextStyle(fontSize: 17, color: Color.fromARGB(115, 0, 0, 0) ) ),           
                      Text(
                        'Alonso',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ),
                      ),
                    ],
                  ),        
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40.0,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.person),
                      Text(
                        ' Apellido: ',
                        style: TextStyle(fontSize: 17, color: Colors.black45 ) ),           
                      Text(
                        'Arrieta Solis',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40.0,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                    
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.phone_android),
                      Text(
                        ' Numero: ',
                        style: TextStyle(fontSize: 17, color: Colors.black45 ) ),           
                      Text(
                        '985425412',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40.0,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.location_on),
                      Text(
                        ' Ubicación: ',
                        style: TextStyle(fontSize: 17, color: Colors.black45 ) ),           
                      Text(
                        'Surco',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ),
                      ),
                    ],
                  ),
                ),      
              ],     
            ),
            SizedBox(
              height: 10,
            ),                 
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                  
                  child: Container(
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15)),
                        width: 100,
                        height: 30,
                        
                        child: TextButton(
                          
                          style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          textStyle: TextStyle(fontSize: 15),
                          ),
                          
                          child: Text('Editar'),
                          onPressed: () {},
                        ),
                  ),
                ),
              ],
            ),
          ],  
        ),      
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 94, 94, 94),
          borderRadius: BorderRadius.circular(15)
        ),
        height: 160,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 40.0,
                  width: 400,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),      
                    borderRadius: BorderRadius.circular(20),  
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.shield_moon),
                      Text(
                        'Modo Oscuro',
                        style: TextStyle(fontSize: 17, color: Colors.black ) ),
                       
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40.0,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255), 
                    borderRadius: BorderRadius.circular(20),  
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.question_mark),
                      Text(
                        'Ayuda',
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                    ],
                  ),      
                ),    
              ],
            ),
            SizedBox(
              height: 10,
            ),                 
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)),
                    width: 100,
                    height: 30,
                    child: TextButton(
                      style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      textStyle: TextStyle(fontSize: 15),
                      ),
                      child: Text('Cerrar Sesion'),
                      onPressed: () {},
                    ),
                   ),
                  ),
              ],
            ),
            ],
          )
        )
      ]
    )
  );
}
}