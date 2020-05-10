import 'package:carros/pages/carro/loripsomApi.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class CarroPage extends StatelessWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem(value: "Editar", child: Text("Editar")),
                PopupMenuItem(value: "Deletar", child: Text("Deletar")),
                PopupMenuItem(value: "Share", child: Text("Share")),
              ];
            },
            onSelected: (String value) => _onClickPopupMenu(value),
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(carro.urlFoto),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
      ),
    );
  }

  _bloco2(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(carro.descricao, fontSize: 16, bold: true),
        SizedBox(height: 20,),
        FutureBuilder<String>(
          future: LoripsonApi.getLoripson(), 
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {  
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.red,),);
            }
            return text(snapshot.data);
          },

          ),
      ],
    );
  }

  Row _bloco1() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                text(carro.nome, fontSize: 20, bold: true),
                text(carro.tipo),
              ],
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 40,
                  ),
                  onPressed: _onClickFavorito,
                ),
                IconButton(
                  icon: Icon(
                    Icons.share,
                    size: 40,
                  ),
                  onPressed: _onClickShare,
                )
              ],
            ),
          ],
        );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar");
        break;
      case "Deletar":
        print("Deletar");
        break;
      case "Share":
        print("Share");
        break;
    }
  }

  _onClickFavorito() {}

  _onClickShare() {}
}
