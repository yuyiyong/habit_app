/*
 * @LastEditors:  
 * @LastEditTime: 2021-07-09 12:10:14
 * @FilePath: /habit_app/lib/views/work_screen.dart
 */
import 'package:flutter/material.dart';

class WorkScreen extends StatefulWidget {
  WorkScreen({Key? key}) : super(key: key);
  static const String _title = 'Flutter Code Sample';

  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),
        ),
        TextField(
          //最大字数
          maxLength: 300,
          //显示行数
          maxLines: 2,
          //对齐方式
          textAlign: TextAlign.center,
          controller: _controller,
          onSubmitted: (String value) async {
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Thanks"),
                    content: Text(
                        'You typed "$value", which has length ${value.characters.length}.'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ok')
                      ),
                    ],
                  );
                });
          },
        ),
      ],
    );
  }
}
