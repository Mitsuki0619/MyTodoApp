import 'package:flutter/material.dart';



class AddList extends StatefulWidget {
  @override
  AddListState createState() => AddListState();
}
class AddListState extends State<AddList> {
  String newTodoText = '';



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo追加画面'),
      ),
      body: Form(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //入力フォーム
              Container(
                width: 350,
                child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: '追加するTodo',
                    hintText: '掃除をする。',
                  ),

                  onChanged: (String value) {
                    setState(() {
                      newTodoText = value.trim();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),

              //追加ボタン
              Container(
                width: 300,
                height: 60,
                child: RaisedButton (
                  color: newTodoText.isEmpty ? Colors.grey : Colors.green,
                  onPressed: () {
                    //値が空だった場合のバリデーション
                    if(newTodoText.isEmpty) {
                      return;
                    }
                    //値をリスト一覧画面に渡す
                    Navigator.pop(context, newTodoText);
                  },
                  child: Text('Todoリストに追加', style: TextStyle(color: Colors.white)),
                ),
              ),

              //戻るボタン
              Container(
                width: 300,
                child: FlatButton (
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Todoリストに戻る'),
                ),
              ),
            ],
          ),
        )
        ),
      );
  }
}