import 'package:flutter/material.dart';
import 'package:gezdostumblog/database/db_helper.dart';
import 'package:gezdostumblog/models/equipment_post_model.dart';
import 'package:gezdostumblog/screens/equipment-add_page.dart';
import 'package:gezdostumblog/screens/equipment-detail.dart';
import 'package:gezdostumblog/widgets/insert_blogClips.dart';

class EquipmentList extends StatefulWidget {
  @override
  _EquipmentList createState() => _EquipmentList();
}

class _EquipmentList extends State<EquipmentList> {
  var dbHelper = DbHelper();
  List<EquipmentPostModel> ekipmanList;
  int ekipmanCount = 0;

//sayfa açıldığında databaseden otomatik verileri çeker
  void initState() {
    getEkipmanList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kamp Ekipmanları"),
        centerTitle: true,
        backgroundColor: Colors.green[900],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToEquipmentAdd();
        },
        child: Icon(Icons.add),
      ),
      body: buildProductList(),
    );
  }

  ListView buildProductList() {
    print(ekipmanList);
    return ListView.builder(
        itemCount: ekipmanCount,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              color: Colors.grey[400],
              elevation: 2.0,
              child: GestureDetector(
                child: Column(
                  children: [
                    Text(
                      this.ekipmanList[index].title,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange[900],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InsertBlogClips(imageUrl: this.ekipmanList[index].image),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Gezgin: ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          this.ekipmanList[index].userName,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.green[900],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  goToDetail(this.ekipmanList[index]);
                },
              ));
        });
  }

  void getEkipmanList() async {
    var ekipmanFuture = dbHelper.getProducts();
    ekipmanFuture.then((data) {
      setState(() {
        this.ekipmanList = data;
        ekipmanCount = data.length;
      });
    });
  }

  void goToEquipmentAdd() async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EquipmentAdd(),
      ),
    );
    if (result != null) {
      if (result) {
        getEkipmanList();
      }
    }
  }

  void goToDetail(EquipmentPostModel ekipmanList) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EquipmentDetail(ekipmanList),
      ),
    );
    if (result != null) {
      if (result) {
        getEkipmanList();
      }
    }
  }
}
