import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';
import 'package:krenak/Services/Request/MeRequest.dart';

class CommentListWidget extends StatefulWidget {
  final List<Comment> comments;
  final Function(String) callback;

  const CommentListWidget({this.comments, this.callback});

  @override
  _CommentListWidgetState createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {

  _showBottomSheet(String id) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text('Deletar'),
                  onTap: () async {
                    Navigator.pop(context);
                    widget.callback(id);
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
    var comments = widget.comments;
    return Column(
        children: comments
            .map((comment) => 
            GestureDetector(
                  onLongPressUp: (){
                    if (comment.author.id == MeRequest.shared.meResponse.id) {
                      _showBottomSheet(comment.id);
                    }
                  },
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      comment.author.firstName,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 4),
                    Text(
                      comment.text,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                  ],
                )))
            .toList());
  }
}
