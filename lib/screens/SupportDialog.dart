import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../global.dart';

import '../widgets/MyAppBar.dart';

class SupportDialog extends StatefulWidget {
  @override
  _SupportDialog createState() => _SupportDialog();
}

class _SupportDialog extends State<SupportDialog> {
  var futureData;

  Future getData() async {
    try {
      await getGlobals();
      await checkSession();

      var messages = await http.get(Uri.parse('$apiUrl/msgs/186255'), headers: {'KEY': 'testAPI_KEY12'});
      print(utf8.decode(messages.bodyBytes));

      return jsonDecode(utf8.decode(messages.bodyBytes));
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Помилка'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ОК'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    futureData = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> titles = ['Не працює інтернет', 'Нестабільний інтернет', 'Невідповідність заявленої в тарифі швидкості', 'Тупить роутер'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(titles[ModalRoute.of(context)?.settings.arguments as int]),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Chip(label: Text('12.07.2021')),
                  FutureBuilder(
                    future: futureData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text('TODO messages');
                      } else {
                        return LinearProgressIndicator();
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Card(
                      color: Colors.red,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Привіт', style: TextStyle(color: Colors.white, fontSize: 16)),
                            SizedBox(width: 8),
                            Text('13:28', style: TextStyle(color: Colors.white70, fontSize: 12))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Card(
                      color: Colors.grey[200],
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Що робиш?', style: TextStyle(color: Colors.black, fontSize: 16)),
                            SizedBox(width: 8),
                            Text('13:28', style: TextStyle(color: Colors.black54, fontSize: 12))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Card(
                      color: Colors.red,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Ремонтую інтернет після вітру', style: TextStyle(color: Colors.white, fontSize: 16)),
                            SizedBox(width: 8),
                            Text('13:28', style: TextStyle(color: Colors.white70, fontSize: 12))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Card(
                      color: Colors.grey[200],
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Зараз приїде наша бригада', style: TextStyle(color: Colors.black, fontSize: 16)),
                            SizedBox(width: 8),
                            Text('13:28', style: TextStyle(color: Colors.black54, fontSize: 12))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Card(
                      color: Colors.grey[200],
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Просто чекайте нас!', style: TextStyle(color: Colors.black, fontSize: 16)),
                            SizedBox(width: 8),
                            Text('13:28', style: TextStyle(color: Colors.black54, fontSize: 12))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ModalRoute.of(context)?.settings.arguments as int != 3 ? Expanded(
                  child: TextFormField(
                    cursorHeight: 22,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 5,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Повідомлення',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.send, color: Colors.red),
                        tooltip: 'Відправити',
                      ),
                    ),
                  )
                ) : Text('Тема закрита', style: TextStyle(color: Colors.red, fontSize: 18)),
              ],
            ),
          ],
        )
      ),
    );
  }
}