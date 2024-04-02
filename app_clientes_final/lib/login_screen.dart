import 'package:flutter/material.dart';
import 'package:';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formLogin = GlobalKey<FormState>();
  String nombreUsuario = '';
  String password = '';
  String mostrarMensaje = '';
  void acceder(String nombreUsuario, String password){
    
    print(nombreUsuario);
    print(password);

    if(nombreUsuario == "bjem" && password == "12345678"){
      final route = MaterialPageRoute(
      builder: (context) => const MenuUsuariosScreen() );
      Navigator.push(context, route);
      
    }else{
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("login",style: TextStyle(color: Colors.black, fontSize: 30),),
        backgroundColor: Colors.tealAccent,
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          key: _formLogin,
          child: Column(
            children: [
              TextFormField(
                
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person, color:  Color.fromARGB(255, 100, 231, 104),),
                  hintText: "Nombre de usuario",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Digitar Usuario',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 15,fontFamily: AutofillHints.username),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Porfavor ingrese su usuario";
                  }
                  return null;
                },
                 onSaved: (value){
                  nombreUsuario = value!;
                },
              ),
              const SizedBox(height: 30,),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password_outlined, color:  Color.fromARGB(255, 100, 231, 104),),
                  suffixIcon: Icon(Icons.password_rounded, color:  Color.fromARGB(255, 100, 231, 104),),
                  hintText: "Contraseña",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Digitar contraseña',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 15,fontFamily: AutofillHints.password)
                ),
                validator: (value){
                  if(value == null || value.length < 8){
                    return "Porfavor ingrese una contraseña de al menos 8 dígitos";
                  }
                  return null;
                },
                onSaved: (value){
                  password = value!;
                },
              ),
              const SizedBox(height: 30,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green,),
                onPressed: (){
                  if(_formLogin.currentState!.validate()){
                    _formLogin.currentState!.save();
                    acceder(nombreUsuario, password);
                  }
                },
                 icon: const Icon(Icons.login_rounded), label: const Text('Acceder', selectionColor: Colors.white,),
                 )
            ],
          ),
        ),
        ),
    );
  }
}