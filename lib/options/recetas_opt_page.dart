import 'package:flutter/material.dart';
import 'package:jlprecetas04/tabs/tab_bebida.dart';
import 'package:jlprecetas04/tabs/tab_ensalada.dart';
import 'package:jlprecetas04/tabs/tab_postre.dart';
import 'package:jlprecetas04/tabs/tab_prueba.dart';
import 'package:jlprecetas04/tabs/tab_sin_filtro.dart';
import 'package:jlprecetas04/tabs/tab_sopa.dart';

class RecetasOptPage extends StatefulWidget {
  const RecetasOptPage({super.key});

  @override
  State<RecetasOptPage> createState() => _RecetasOptPageState();
}

class _RecetasOptPageState extends State<RecetasOptPage> {

  //--Variables--
  //List listaNvFiltrados = [TabSinFiltro(),];
  int filtroSeleccionada = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //--BODY
      body: Container(
        child: DefaultTabController(
          length: 5,
          child: Container(
            child: Column(
              children: [

                //eCol 1.-
                //  #####- TabBar con Filtros -
                Container(
                  child: TabBar(tabs: [
                    Tab(text: 'Todo',),
                    Tab(text: 'Ensalada',),
                    Tab(text: 'Postre',),
                    Tab(text: 'Bebida',),
                    Tab(text: 'Sopa',),
                  ]),
                ),

                //eCol 2.-
                //  ####- Contenedor de TabBarView con ListView -
                Container(
                  child: Expanded(child: TabBarView(
                    children: [
                      TabSinFiltro(),
                      TabEnsalada(),
                      TabPostre(),
                      TabBebida(),
                      TabSopa(),
                      ]
                    ),
                  ),
                ),

              ],
            ),
          ),
          ),
      ),

    );
  }



}