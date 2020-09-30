import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: "1", name: "Let", votes: 2),
    Band(id: "2", name: "Let 2", votes: 4),
    Band(id: "2", name: "Let 2", votes: 4),
    Band(id: "2", name: "Let 2", votes: 4)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.name.substring(0, 2)),
      ),
      title: Text(band.name),
      trailing: Text('${band.votes}', style: TextStyle(fontSize: 20)),
      onTap: () {
        print(band.name);
      },
    );
  }

  addNewBand() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("New band name:"),
            content: TextField(),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {},
              )
            ],
          );
        });
  }
}
