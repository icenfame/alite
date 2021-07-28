import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/MyAppBar.dart';

class Pay extends StatefulWidget {
  @override
  createState() => _Pay();
}

class _Pay extends State<Pay> {
  var _amount = "${(290 - 123.50).toStringAsFixed(2)}";
  var _loading = true;

  var _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2000), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Поповнити"),
      body: Container(
        child: ListView(
          children: [
            if (_loading) LinearProgressIndicator(),
            Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Мій баланс", style: TextStyle(fontSize: 18)),
                      leading: Icon(Icons.account_balance_wallet, color: Colors.red),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("123.50", style: TextStyle(fontSize: 20, color: Colors.green)),
                          Text(" грн", style: TextStyle(fontSize: 14, color: Colors.green)),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      title: Text("Вартість послуг", style: TextStyle(fontSize: 18)),
                      leading: Icon(Icons.assessment),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("290", style: TextStyle(fontSize: 20)),
                          Text(" грн", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 16),
            Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Введіть суму поповнення:", style: TextStyle(fontSize: 22)),
                    SizedBox(height: 8),
                    TextFormField(
                      cursorHeight: 22,
                      focusNode: _focusNode,
                      onChanged: (value) {
                        setState(() {
                          _amount = value.isNotEmpty ? value : "0";
                        });
                      },

                      initialValue: "${(290 - 123.50).toStringAsFixed(2)}",

                      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[+-]?([0-9]+\.?[0-9]*|\.[0-9]+)$'))],
                      // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^([0-9]+)$'))],
                      maxLength: 6,

                      decoration: InputDecoration(
                        labelText: "Сума",
                        border: OutlineInputBorder(),
                        counterText: "",
                        // helperText: "Рекомендована сума поповнення: ${(290 - 123.50).toStringAsFixed(2)} грн"
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Введіть суму поповнення";
                        }
                      },
                      // onSaved: (value) => _password = value,
                    ),
                    Divider(height: 32),

                    Text("Оплатити за допомогою:", style: TextStyle(fontSize: 22)),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: null,
                      child: ListTile(
                        title: Text("Privat24"),
                        subtitle: Text("Сума до сплати"),
                        leading: Center(
                          widthFactor: 1,
                          child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Privat24_Logo.png/150px-Privat24_Logo.png.png", width: 50),
                        ),
                        trailing: Text("$_amount грн", style: TextStyle(fontSize: 20)),
                        isThreeLine: true,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.red[200],
                        padding: EdgeInsets.zero
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () async {
                        if (_amount != "0") {
                          var url = "https://www.liqpay.ua/uk/checkout/card/380660068608";
                          await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
                        } else {
                          // _focusNode.unfocus();
                          _focusNode.requestFocus();
                        }
                      },
                      child: ListTile(
                        title: Text("LiqPay"),
                        subtitle: Text("Сума до сплати"),
                        leading: Center(
                          widthFactor: 1,
                          child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/LIQPAY.svg/150px-LIQPAY.svg.png", width: 50),
                        ),
                        trailing: Text("$_amount грн", style: TextStyle(fontSize: 20)),
                        isThreeLine: true,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.red[200],
                        padding: EdgeInsets.zero
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: null,
                      child: ListTile(
                        title: Text("EasyPay"),
                        subtitle: Text("Сума до сплати"),
                        leading: Center(
                          widthFactor: 1,
                          child: Image.network("https://static.openfintech.io/payment_methods/easypay/icon.png?w=278&c=v0.59.26", width: 50),
                        ),
                        trailing: Text("$_amount грн", style: TextStyle(fontSize: 20)),
                        isThreeLine: true,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.red[200],
                        padding: EdgeInsets.zero
                      ),
                    ),
                    SizedBox(height: 8),

                    ElevatedButton(
                      onPressed: null,
                      child: ListTile(
                        title: Text("Кредит"),
                        subtitle: Text("Оформлення кредиту"),
                        leading: Center(
                          widthFactor: 1,
                          child: Image.network("https://cdn.iconscout.com/icon/free/png-256/credit-card-1454538-1228446.png", width: 50),
                        ),
                        trailing: Text("$_amount грн", style: TextStyle(fontSize: 20)),
                        isThreeLine: true,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.red[200],
                        padding: EdgeInsets.zero
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Card(
            //   margin: EdgeInsets.all(8),
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            //     child: Column(
            //       children: [
            //         ListTile(
            //           title: Text("Оформити кредит", style: TextStyle(fontSize: 18)),
            //           leading: Icon(Icons.account_balance),
            //           trailing: OutlinedButton(
            //             onPressed: () {},
            //             child: Text("КРЕДИТ"),
            //           ),
            //         ),
            //         // ListTile(
            //         //   title: ElevatedButton(
            //         //     onPressed: () {},
            //         //     child: Text("КРЕДИТ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 1.5)),
            //         //     style: ElevatedButton.styleFrom(
            //         //       fixedSize: Size(MediaQuery.of(context).size.width - 16 * 3, 55),
            //         //     ),
            //         //   ),
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}