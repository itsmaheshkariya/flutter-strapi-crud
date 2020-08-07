import 'package:flutter/material.dart';
import './user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import './main.dart';
import 'dart:convert';
class MyForm extends StatefulWidget {
  int id;
  MyForm(this.id);
  @override
  _MyFormState createState() => _MyFormState(this.id);
}

class _MyFormState extends State<MyForm> {
  int id;
  _MyFormState(this.id);
  User user = User(0,'','','');
  Future save() async{
    if(user.id == 0){
      await http.post("http://localhost:1337/apis/",
      headers:<String,String>{'Context-Type':'application/json;charset=UTF-8'},body:<String,String>
      {'name':user.name,'email':user.email,'password':user.password});
    }else{
      await http.put("http://localhost:1337/apis/${user.id.toString()}",
      headers:<String,String>{'Context-Type':'application/json;charset=UTF-8'},body:<String,String>
      {'name':user.name,'email':user.email,'password':user.password});
    }
      Navigator.push(context, new MaterialPageRoute(builder: (context)=>Home(1,0)));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(this.id != 0){
      getOne();
    }
  }
  void getOne() async{
    var data = await http.get("http://localhost:1337/apis/${this.id}");
    var u = json.decode(data.body);
    setState(() {
          user = User(u['id'], u['name'], u['email'], u['password']);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Form(child: 
          Padding(padding: EdgeInsets.all(19.0),
            child:Column(
                children: [
                  Visibility(
                    visible: false,
                    child: TextField(controller: TextEditingController(text:user.id.toString())
                    ),),
                  TextField(
                    controller: TextEditingController(text:user.name),
                    onChanged: (val){
                      user.name = val;
                    },
                    decoration: InputDecoration(
                      labelText: "Name",
                      icon: Icon(Icons.person)
                    ),
                  ),
                  TextField(
                    controller: TextEditingController(text:user.email),
                    onChanged: (val){
                      user.email = val;
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
                      icon: Icon(Icons.person)
                    ),
                  ),
                  TextField(
                    controller: TextEditingController(text:user.password),
                    onChanged: (val){
                      user.password = val;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      icon: Icon(Icons.vpn_key)
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(35, 20, 0, 0),
                      child:MaterialButton(
                        onPressed: save,
                        minWidth: double.infinity,
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text("Save"),
                      ),
                  )
                ],
            ),
          )
       ),
    );
  }
}