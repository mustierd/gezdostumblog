import 'package:flutter/material.dart';
import 'package:gezdostumblog/funcitons/getEquipment.dart';
import 'package:gezdostumblog/models/equipment_json_model.dart';
import 'package:gezdostumblog/screens/home_page.dart';

class EquipmentAdvicePage extends StatefulWidget {
  @override
  _CampEquipmentState createState() => _CampEquipmentState();
}

class _CampEquipmentState extends State<EquipmentAdvicePage> {
  Future<List<EquipmentJson>> getEkipman;

  void initState() {
    super.initState();
    getEkipman = getEquipment();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                  (Route<dynamic> route) => false);
            },
          ),
          title: Text('Nelere dikkat Edilmeli ?'),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<List<EquipmentJson>>(
            future: getEkipman,
            builder: (context, veri) {
              if (veri.hasData) {
                return ListView.builder(
                    itemCount: veri.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white,
                              child: Text(
                                veri.data[index].id.toString() +
                                    ")" +
                                    veri.data[index].title,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Image.network(
                                veri.data[index].url,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.white,
                              child: Text(
                                veri.data[index].body,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    });
              } else if (veri.hasError) {
                return Text(veri.error);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
