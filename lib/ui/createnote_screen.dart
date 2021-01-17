import 'package:cript_app/const/constants.dart';
import 'package:cript_app/main.dart';
import 'package:cript_app/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class CreateNote extends StatefulWidget {
  final String nameTitle;
  final String keyy;
  final String textt;
  CreateNote({Key key, this.nameTitle, this.keyy, this.textt})
      : super(key: key);

  @override
  _CreateNote createState() => _CreateNote();
}

class Mode {
  int id;
  String name;

  Mode(this.id, this.name);

  static List<Mode> getMode() {
    return <Mode>[
      Mode(0, "Encrypt"),
      Mode(1, "Decrypt"),
    ];
  }
}

class _CreateNote extends State<CreateNote> {
  final _note = TextEditingController();
  final _console = TextEditingController();
  bool _validate1 = false;

  @override
  void dispose() {
    _note.dispose();
    _console.dispose();
    super.dispose();
  }

  List<Mode> _mode = Mode.getMode();
  List<DropdownMenuItem<Mode>> _dropdownMenuItems;
  Mode _selectedMode;

  @override
  void initState() {
    _dropdownMenuItems = buildDropDownMenuItems(_mode);
    _selectedMode = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Mode>> buildDropDownMenuItems(List mode) {
    List<DropdownMenuItem<Mode>> items = List();
    for (Mode mode in mode) {
      items.add(DropdownMenuItem(
        value: mode,
        child: Text(mode.name),
      ));
    }
    return items;
  }

  onChageDropdownItem(Mode selectedMode) {
    setState(() {
      _selectedMode = selectedMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    int nodeMode = (widget.keyy == "0") ? 1 : 2;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(widget.nameTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton(
                      value: _selectedMode,
                      items: _dropdownMenuItems,
                      onChanged: onChageDropdownItem,
                      isExpanded: true,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: (debug[0].switchdebug)
                          ? (_height / 4)
                          : (_height / 2),
                      child: Scrollbar(
                        child: TextField(
                          controller: _note,
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          style: Theme.of(context).textTheme.headline6,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: widget.textt,
                            errorText:
                                _validate1 ? 'Input can\'t be empty' : null,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: debug[0].switchdebug,
                      child: Container(
                        height: _height / 3,
                        child: Scrollbar(
                          child: TextField(
                            controller: _console,
                            //enabled: false,
                            keyboardType: TextInputType.multiline,
                            maxLines: 100,
                            enableInteractiveSelection: false,
                            readOnly: true,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Console",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
          
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _note.text.isEmpty ? _validate1 = true : _validate1 = false;

            prepare_sentence(sentence) {
              // Preparar a texto para ser encriptado

              sentence = sentence.toLowerCase(); // LowerCase

              const List<String> accent = [
                "âàáã",
                "éèêë",
                "îïíì",
                "ô",
                "ûü",
                "ç"
              ];
              const List<String> ascii = ["a", "e", "i", "o", "u", "c"];
              var i = 0;

              for (int k = 0; k < accent.length; k++) {
                for (int y = 0; y < accent[k].length; y++) {
                  sentence = sentence.replaceAll(accent[k][y], ascii[i]);
                }
                i += 1;
              }
              var pont = "',-;:!?.";

              for (int w = 0; w < pont.length; w++) {
                // Remover pontuação
                sentence = sentence.replaceAll(pont[w], "");
              }
              sentence = sentence.toUpperCase(); // UpperCase
              sentence =
                  sentence.replaceAll(RegExp(r" "), ""); // Remover Espaços
              print("Text: " + sentence);
              _console.text = _console.text + "Text: " + sentence + "\n";
              sentence =
                  (nodeMode == 1) ? sentence.replaceAll("J", "I") : sentence;
              return sentence;
            }

            encipher(to_encrypt) {
              // Encriptar texto
              String alphabet = (nodeMode == 1)
                  ? 'abcdefghiklmnopqrstuvwxyz'
                  : 'abcdefghijklmnopqrstuvwxyz0123456789';
              alphabet = alphabet.toUpperCase();
              var count = 0;
              int linhas = (nodeMode == 1) ? 5 : 6;

              List<String> List_H = [];
              List<List<String>> List_V = [];

              for (var j = 0; j < linhas; j++) {
                for (var i = 0; i < linhas; i++) {
                  List_H.add(alphabet[count]);
                  count = count + 1;
                }
                print(List_H);
                _console.text = _console.text + List_H.toString() + "\n";
                List_V.add(List_H);
                List_H = [];
              }

              to_encrypt = prepare_sentence(to_encrypt).toString();

              var code = "";

              for (int x = 0; x < to_encrypt.length; x++) {
                for (var l = 0; l < linhas; l++) {
                  if (List_V[l].indexOf(to_encrypt[x]) != -1) {
                    var pos = (l + 1).toString(); // posição da linha
                    var pos2 = (List_V[l].indexOf(to_encrypt[x]) + 1)
                        .toString(); // posição da coluna
                    code += pos + pos2 + " ";
                    break;
                  }
                }
              }
              print("Code: " + code);
              _console.text = _console.text + "Code: " + code + "\n";
              to_encrypt = code;
              _note.text = to_encrypt;
              return to_encrypt;
            }

            decipher(to_decrypt) {
              // Desencriptar codigo
              String alphabet = (nodeMode == 1)
                  ? 'abcdefghiklmnopqrstuvwxyz'
                  : 'abcdefghijklmnopqrstuvwxyz0123456789';
              alphabet = alphabet.toUpperCase();
              var count = 0;
              int linhas = (nodeMode == 1) ? 5 : 6;

              List<String> List_H = [];
              List<List<String>> List_V = [];

              for (var j = 0; j < linhas; j++) {
                for (var i = 0; i < linhas; i++) {
                  List_H.add(alphabet[count]);
                  count = count + 1;
                }
                //print(List_H);
                List_V.add(List_H);
                List_H = [];
              }
              to_decrypt =
                  to_decrypt.replaceAll(RegExp(r" "), ""); // Remover Espaços
              int length = to_decrypt.length;
              var decode = "";
              var h;
              for (h = 0; h < length; h = h + 2) {
                var pos = int.parse(to_decrypt[h]); // posição da linha
                var pos2 = int.parse(to_decrypt[h + 1]); // posição da coluna

                decode += List_V[pos - 1][pos2 - 1];
              }

              print("Decode: " + decode);
              _console.text = _console.text + "Decode: " + decode + "\n";
              to_decrypt = decode;
              _note.text = to_decrypt;
              return to_decrypt;
            }

            // Texto para encriptar
            if (_validate1 == false && _selectedMode.id == 0) {
              encipher(_note.text);
            }

            /// Code para desencriptar
            if (_validate1 == false && _selectedMode.id == 1) {
              var decode = decipher(_note.text);
            }
          });
        },
        tooltip: 'Convert',
        child: Icon(Icons.autorenew),
      ),
    );
  }
}
