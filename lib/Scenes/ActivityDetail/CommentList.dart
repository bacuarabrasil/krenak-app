import 'package:flutter/material.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';

class CommentListWidget extends StatefulWidget {
  final List<Comment> comments;

  const CommentListWidget({this.comments});

  @override
  _CommentListWidgetState createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  @override
  Widget build(BuildContext context) {
    var comments = widget.comments;
    return Wrap(
        spacing: 20,
        runSpacing: 20,
        children: comments
            .map((comment) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      comment.name,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      comment.text,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey
                      ),
                    ),
                  ],
                ))
            .toList()
    );
  }
}
