import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:http/http.dart" as api;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  String _resultado = "";
  _recuperCep() async {
    var url = Uri.https('viacep.com.br', 'ws/${_controller.text}/json/');

    api.Response response = await api.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    var complemento = retorno["complemento"];
    var bairro = retorno["bairro"];
    var localidade = retorno["localidade"];
    var uf = retorno["uf"];

    print(response.body);
    setState(() {
      _resultado =
          "${logradouro} , ${complemento} , ${bairro} , ${localidade} , ${uf}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
          child: Text("Buscador de CPE"),
        )),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(40),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Cep"),
                  controller: _controller,
                ),
              ),
              RaisedButton(
                onPressed: _recuperCep,
                child: const Text("Pesquisar"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(_resultado),
              )
            ]),
          ),
        ));
  }
}
