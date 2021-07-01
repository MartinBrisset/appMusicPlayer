import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/helpers/helpers.dart';
import 'package:flutter_application_1/src/models/audioPlayerModel.dart';

import 'package:flutter_application_1/src/widgets/appBarCustom.dart';
import 'package:provider/provider.dart';


class MusicPlayerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Fondo(),

          Column(
            children: [
              
              CustomAppBar(),

              ImagenDicoYDuracion(),

              TituloPlay(),

              Expanded(
                child: Letras(),
              )

            ],
          ),
        ],
      )
   );
  }
}

class Fondo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final pantalla = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: pantalla.height * 0.78,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [
            Color(0xff33333E),
            Color(0xff201E28)
          ]
        )
      ),
    );
  }
}

class Letras extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final letras = getLyrics();

    return Container(
      child: ListWheelScrollView(
        physics: BouncingScrollPhysics(),
        itemExtent: 50,
        diameterRatio: 1.5,
        children: letras.map(
          (verso) => Text( verso, style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.6)),)
        ).toList(),
      ),
    );
  }
}

class TituloPlay extends StatefulWidget {

  @override
  _TituloPlayState createState() => _TituloPlayState();
}

class _TituloPlayState extends State<TituloPlay> with SingleTickerProviderStateMixin {

  bool reproduciendo = false;
  AnimationController animacionPlay;

  @override
  void initState() {
    
    animacionPlay = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    super.initState();
  }

  @override
  void dispose() {
    this.animacionPlay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      margin: EdgeInsets.only(top: 40),
      child: Row(
        children: [

          Column(
            children: [

              Text('Flow Vitux', style: TextStyle( fontSize: 30, color: Colors.white.withOpacity(0.8)),),
              Text('-Dj Santiago Vitureira-', style: TextStyle( fontSize: 15, color: Colors.white.withOpacity(0.5)),),
            ],
          ),

          Spacer(),

          FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: Color(0xffF8CB51),
            child: AnimatedIcon(
              icon: AnimatedIcons.pause_play, 
              progress: animacionPlay,
            ),
            onPressed: () {
              
              if (this.reproduciendo) {
                animacionPlay.reverse();
                this.reproduciendo = false;
              } else {
                animacionPlay.forward();
                this.reproduciendo = true;
              }

            },
          )


        ],
      ),
    );
  }
}

class ImagenDicoYDuracion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 80),
      child: Row(
        children: [

          ImagenDisco(),
          SizedBox( width: 40,),

          BarraProgreso(),
          SizedBox( width: 20,),

        ],
      ),
    );
  }
  
}

class BarraProgreso extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final estilo = TextStyle( color: Colors.white.withOpacity(0.4));

    return Container(
      child: Column(
        children: [

          Text('00:00', style: estilo),
          SizedBox( height: 10,),

          Stack(
            children: [

              Container(
                width: 3,
                height: 230,
                color: Colors.white.withOpacity(0.1),
              ),

              Positioned(
                bottom: 0,
                child: Container(
                  width: 3,
                  height: 150,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),


            ],
          ),



          SizedBox( height: 10,),
          Text('00:00', style: estilo),

        ],
      ),
    );
  }
}

class ImagenDisco extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    return Container(
      padding: EdgeInsets.all(20),
      width: 250,
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [

            SpinPerfect(
              duration: Duration(seconds: 5),
              infinite: true,
              manualTrigger: true,
              controller: ( animacionController ) => audioPlayerModel.controller = animacionController,
              child: Image(image: AssetImage('assets/aurora.jpg'))
            ),

            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100)
              ),
            ),

            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Color(0xff1C1C25),
                borderRadius: BorderRadius.circular(100)
              ),
            ),

          ],
        )
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            Color(0xff484750),
            Color(0xff1E1C24)
          ]
        )
      ),
    );
  }
}


