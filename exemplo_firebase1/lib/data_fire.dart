import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DataFire extends StatefulWidget {
  const DataFire({super.key});
  @override
  State<DataFire> createState() => _DataFire();
}

class _DataFire extends State<DataFire> {
  int _likes = 0;

  //variável que é a referência do contador de likes no firebase
  late final DatabaseReference _likesRef;
  //para receber os eventos do database em real time, sempre que um update acontecer
  late StreamSubscription<DatabaseEvent> _likesSubscription;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //linka _likesRef com o objeto do firebase que armazenará os valores de _likes
    //esse objeto se chamará likes no Firebase

    _likesRef = FirebaseDatabase.instance.ref('/likes');

    try {
      //armazena o valor atual de likes que está no Firebase
      final likeSnapshot = await _likesRef.get();
      //atribui o valor de likeSnapshot para o contador de likes
      _likes = likeSnapshot.value as int;
    } catch (err) {
      debugPrint(err.toString());
    }

    //verifica as alterações que ocorreram no banco de dados
    _likesSubscription = _likesRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        //assim que houver atualização no banco de dados, traz o valor atualizado
        //para o contador de likes
        _likes = (event.snapshot.value ?? 0) as int;
        print(event.snapshot.value.toString());
      });
    });
  }

  //método contador de likes
  like() async {
    //faz o incremento de 1 no banco de dados
    await _likesRef.set(ServerValue.increment(1));
  }

  @override
  void dispose() {
    //cancela a subscription
    _likesSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: const Text("Acessando Firebase"),
      ),
      body: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
              onPressed: like,
              icon: const Icon(Icons.thumb_up),
            ),
            Text(_likes.toString(), style: const TextStyle(fontSize: 20))
          ])),
    ));
  }
}
