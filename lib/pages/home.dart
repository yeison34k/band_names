import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:band_names/services/socket_service.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [];

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    
    socketService.socket.on("active-bands", (payload) {  
      this.bands = (payload as List)
        .map( (x) => Band.fromMap(x))
        .toList();

        setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off("active-bands");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("BandNames", style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.serverStatus != ServerStatus.Online
                ? Icon(
                    Icons.offline_bolt,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.check_circle,
                    color: Colors.blue[700],
                  )),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (BuildContext context, int index) {
            return bandTile(bands[index]);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: () {
          addNewBand();
        },
      ),
    );
  }

  ListTile bandTile(Band band) {
    final socketService = Provider.of<SocketService>(context, listen: false);
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.name.substring(0, 2)),
      ),
      title: Text(band.name),
      trailing: Text('${band.votes}', style: TextStyle(fontSize: 20)),
      onTap: () {

        socketService.emit("vote-band", band.id);


        print(band.name);
      },
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("New band name:"),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text("Add"),
                elevation: 5,
                color: Colors.blue,
                onPressed: () => addBandToList(textController.text),
              )
            ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      this.bands.add(
          new Band(id: new DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
