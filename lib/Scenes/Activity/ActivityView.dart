import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityCreate/ActivityCreateView.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';
import 'package:krenak/Scenes/ActivityDetail/ActivityDetailView.dart';
import 'package:krenak/Services/Request/ActivityRequest.dart';
import 'package:krenak/Services/Request/MeRequest.dart';

class ActivityView extends StatefulWidget {
  final String id;

  ActivityView({Key key, @required this.id}) : super(key: key);

  @override
  ActivityViewState createState() => new ActivityViewState();
}

class ActivityViewState extends State<ActivityView> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    var value = ActivityRequest().getActivities(widget.id);
    value.then(handleRequest);
  }

  handleRequest(value) {
    setState(() {
      loading = false;
      activities = value;
    });
  }

  List<Activity> activities = [];

  _showBottomSheet(String id) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: new Icon(Icons.edit),
                    title: new Text('Editar'),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text('Deletar'),
                  onTap: () async {
                    Navigator.pop(context);
                    setState(() {
                      loading = true;
                    });
                    try {
                      await ActivityRequest().deleteActivity(id);
                    } catch (e) {

                    }                    
                    var value = ActivityRequest().getActivities(widget.id);
                    value.then(handleRequest);
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.cancel),
                  title: new Text('Cancelar'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = loading
        ? new Container(
            color: Colors.grey[300],
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(child: new CircularProgressIndicator())),
          )
        : new Container();

    return Scaffold(
        appBar: AppBar(
          title: Text('Atividades'),
        ),
        body: Stack(children: <Widget>[
          ListView(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            children: activities
                .map((activity) => GestureDetector(
                  onLongPressUp: () {
                    if (MeRequest.shared.meResponse.role == 'MTR') {
                      _showBottomSheet(activity.id);
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ActivityDetail(id: activity.id),
                          ));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[400],
                          borderRadius: new BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 24.0, horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  activity.title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  activity.description,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ))))))
                .toList(),
          ),
          new Align(
            child: loadingIndicator,
            alignment: FractionalOffset.center,
          ),
        ]),
        floatingActionButton: Visibility(
            visible: MeRequest.shared.meResponse.role == 'MTR',
            child: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityCreateView(id: widget.id),
                    ));
                setState(() {
                  loading = true;
                });
                var value = ActivityRequest().getActivities(widget.id);
                value.then(handleRequest);
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.blue,
            )));
  }
}
