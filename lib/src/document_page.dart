import 'package:flutter/material.dart';
import 'package:rapido/documents.dart';

/// Experimental support for auto-generated view of the contents of 
/// a Document. This is meant to be a read only view, and returns a 
/// Scaffold, so is mostly meant to be used in page nagivation.
class DocumentPage extends StatelessWidget {
  /// Map the UI labels to include in the DocumentPage to fields
  /// in the document.
  final Map<String, String> labels;

  /// The Document object to display
  final Document document;

  DocumentPage({@required this.labels, @required this.document});

  List<Widget> _buildFormFields(BuildContext context) {
    List<Widget> fields = [];
    
    // creat a form field for each support label
    if (document["subtitle"] != null) {
      fields.add(Text(
        document["subtitle"].toString(),
        softWrap: true,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline,
      ));
    }
    labels.keys.forEach((String label) {
      String fieldName = labels[label];
      if (fieldName != "title" && fieldName != "subtitle") {
        // add to the array of input fields
        fields.add(
          ListTile(
            subtitle: Text(label),
              title: Text(document[fieldName].toString()),
           
          ),
        );
      }
    });

    return fields;
  }

  @override
  Widget build(BuildContext context) {
    Widget titleWidget;
    document["title"] != null
        ? titleWidget = Text(document["title"])
        : titleWidget = Icon(Icons.book);
    return Scaffold(
      appBar: AppBar(title: titleWidget),
      body: ListView(
        children: _buildFormFields(context),
      ),
    );
  }
}