import 'package:flutter/material.dart';
import 'package:mytodoapp/todo_add.dart';


void main() {
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  TodoListPageState createState() => TodoListPageState();
}
class TodoListPageState extends State<TodoListPage> {
  //Todoリスト配列
  final List<String> todos = [];
  //チェック済みTodoリスト配列
  final List<String>isChecked = [];

//削除機能
  void deleteTodos() {
    setState(() {
      for(int i = 0; i < isChecked.length; i++){
        todos.remove(isChecked[i]);
      }
      isChecked.removeRange(0, isChecked.length);
    });
  }

    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧  ${isChecked.length} / ${todos.length}'),
        actions: [
          FlatButton(onPressed: () {
            //チェック済みTodoリストの削除
            if(isChecked.isEmpty){
              return;
            }
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: Container(
                    height: 40,
                    child: Center(
                      child: Text("チェック済Todoを削除しますか？", style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      }
                    ),
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        deleteTodos();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
           }, child: Text('削除', style: isChecked.isEmpty ? TextStyle(color: Colors.white54) : TextStyle(color: Colors.white))
          )
        ],
      ),

      //リスト一覧表示
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
            if(todos.isEmpty){
              setState(() {
                print('hello');
              });
            }
            return Card(
              child: ListTile(
                  title: Text(todos[index]),
                  trailing: Icon(
                    //isChacked配列に入っていればcheckedアイコンに変換する。
                      isChecked.contains(todos[index]) ? Icons.check_box : Icons
                          .check_box_outline_blank
                  ),
                  onTap: () {
                    setState(() {
                      //isChacked配列に入れる || isChacked配列から消す　処理
                      if (isChecked.contains(todos[index])) {
                        isChecked.remove(todos[index]);
                      } else {
                        isChecked.add(todos[index]);
                      }
                    });
                  }
              ),
            );
          }
      ),

      //追加ボタン
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //入力された値を取得する
          final newTodoText = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddList()),
          );
          if(newTodoText == null){
            return;
          }
          setState(() {
            //同じ内容（文字列）のTodoに対するバリデーション
             if(todos.contains(newTodoText)){
               showDialog(
                 context: context,
                 builder: (_) {
                   return AlertDialog(
                     title: Text("すでに追加済みのTodoです。"),
                     actions: <Widget>[
                       FlatButton(
                         child: Text("OK"),
                         onPressed: () => Navigator.pop(context),
                       ),
                     ],
                   );
                 },
               );
               return;
             }
             //取得した値をTodoリストに追加する
              todos.add(newTodoText);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

