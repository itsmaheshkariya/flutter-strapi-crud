import 'package:flutter/material.dart';
import 'package:frontend/form.dart';
import 'package:frontend/list.dart';
void main(){
  runApp(Home(0,0));
}
class Home extends StatefulWidget {
  int state;
  int id;
  Home(this.state,this.id);
  @override
  _HomeState createState() => _HomeState(this.state,this.id);
}

class _HomeState extends State<Home> {
  int state;
  int id;
  int _currentIndex = 0;
  Widget _body;
  String _title;
  _HomeState(this.state,this.id);
  @override
  void initState() {
    super.initState();
    changeView(state);
  }
  void _onTap(index){
    changeView(index);
  }
  void changeView(index){
    _currentIndex = index;
    setState(() {
      switch (index) {
        case 0:{
          _title="Form";
          _body=MyForm(this.id);
          break;
        }
        case 1:{
          _title="List";
          _body=MyList();
          break;
        }
      }       
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      Scaffold(
        appBar: AppBar(title:Text(_title)),
        body:_body,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.add),title:Text("Add")),
            BottomNavigationBarItem(icon: Icon(Icons.table_chart),title:Text("View")),
          ],
          currentIndex: _currentIndex,
          onTap: _onTap,
          ),
      )
    );
  }
}
