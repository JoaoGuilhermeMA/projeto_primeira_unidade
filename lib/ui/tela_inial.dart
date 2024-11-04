import 'package:flutter/material.dart';
import './widget/button_widget.dart'; // Importe o arquivo onde está o widget CustomButton

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tela_fundo_pokedex.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButton(
                text: 'Pokedex',
                onPressed: () {
                  Navigator.pushNamed(context, '/telaPokedex');
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Encontro Diário',
                onPressed: () {
                  Navigator.pushNamed(context, '/telaEncontroDiario');
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Meus Pokemons',
                onPressed: () {
                  Navigator.pushNamed(context, '/telaMeusPokemons');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
