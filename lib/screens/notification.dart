import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scratcher/scratcher.dart';

class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  ConfettiController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ConfettiController(
      duration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Congratulation"),
      ),
      body: Center(
        child: Scratcher(
          brushSize: 50,
          threshold: 75,
          color: Colors.deepOrange,
          image: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/et.jpeg?alt=media&token=50d68cfd-661c-4a0a-8da8-8f7848112ad4",
            fit: BoxFit.fill,
          ),
          onChange: (value){
            print("Scratch progress : $value");
          },
          onThreshold: (){
            _controller.play();
          },
          child: Container(
            height: 300,width: 300,
            color: Colors.greenAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.network("https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/9651-winner.json?alt=media&token=55cfa35a-7f89-4031-baf0-e4ab3c1068e1",fit: BoxFit.contain,height: 230,width: 230),
                Column(
                  children: [
                    ConfettiWidget(confettiController: _controller,
                    blastDirectionality: BlastDirectionality.explosive,
                    particleDrag: 0.05,
                      emissionFrequency: 0.05,
                      numberOfParticles: 50,
                      gravity: 0.05,
                      shouldLoop: false,
                      colors: [
                        Colors.deepOrange,
                        Colors.yellow,
                        Colors.red,
                        Colors.green,
                        Colors.blue,
                        Colors.white,
                      ],
                    ),
                    Text("You Won",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Text("500\$",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
