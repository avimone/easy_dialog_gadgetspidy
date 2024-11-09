library easy_dialog;

import 'package:flutter/material.dart';

class EasyDialog {
  final ImageProvider? topImage;
  final Text? title;
  final Text? description;
  final bool closeButton;
  final double height;
  final double width;
  final double fogOpacity;
  final double cornerRadius;
  final Color cardColor;
  final Color color;
  final bool isMainButton;
  var onTap = () {};
  List<Widget> _contentList = [];
  List<Widget>? contentList;
  EdgeInsets? contentPadding;
  EdgeInsets? titlePadding;
  EdgeInsets descriptionPadding;
  CrossAxisAlignment contentListAlignment;

  EasyDialog(
      {Key? key,
      this.topImage,
      this.title,
      this.description,
      this.closeButton = true,
      this.isMainButton = false,
      required this.onTap,
      this.height = 140,
      this.width = 300,
      this.cornerRadius = 8.0,
      this.fogOpacity = 0.37,
      this.cardColor = const Color.fromRGBO(240, 240, 240, 1.0),
      this.color = const Color.fromRGBO(240, 240, 240, 1.0),
      this.contentList,
      this.contentPadding = const EdgeInsets.fromLTRB(17.5, 12.0, 17.5, 13.0),
      this.descriptionPadding = const EdgeInsets.all(0.0),
      this.titlePadding = const EdgeInsets.only(bottom: 12.0),
      this.contentListAlignment = CrossAxisAlignment.center})
      : assert(fogOpacity >= 0 && fogOpacity <= 1.0);

  insertByIndex(EdgeInsets? padding, Widget? child, int index) {
    _contentList.insert(
        index,
        Container(
          padding: padding,
          child: child,
          alignment: Alignment.center,
        ));
  }

  insertAtEnd(EdgeInsets? padding, Widget? child) {
    _contentList.add(Container(
      padding: padding,
      child: child,
      alignment: Alignment.center,
    ));
  }

  show(BuildContext context) {
    ClipRRect? image;
    if (topImage != null) {
      image = ClipRRect(
        child: new Image(image: topImage!),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(cornerRadius),
            topRight: Radius.circular(cornerRadius)),
      );
    }
    Widget button = GestureDetector(
      onTap: () {
        Navigator.pop(context);

        // onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .37,
        height: 40,
        margin: EdgeInsets.only(left: 15, right: 15),
        /*            padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12), */
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.99, 0.16),
            end: Alignment(0.99, -0.16),
            colors: [color, color],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*   Container(
                          width: 14,
                          height: 14,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/play-6.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8), */
              Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFFF9F9FA),
                  fontSize: 13,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (title != null && description != null) {
      insertByIndex(titlePadding, title, 0);
      insertByIndex(descriptionPadding, description, 1);
    }
    if (title != null && description == null) {
      insertByIndex(titlePadding, title, 0);
    }
    if (description != null && title == null) {
      insertByIndex(descriptionPadding, description, 0);
    }

    contentList?.forEach((element) {
      insertByIndex(EdgeInsets.zero, element, _contentList.length);
    });
    /* if (isMainButton) {
      insertAtEnd(EdgeInsets.zero, button);
    } */
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Container(
            color: Color.fromRGBO(0, 0, 0, fogOpacity),
            child: new Center(
              child: new Container(
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        spreadRadius: 1.0,
                        color: Colors.black54,
                        offset: new Offset(5.0, 5.0),
                        blurRadius: 30.0,
                      )
                    ],
                    borderRadius:
                        BorderRadius.all(Radius.circular(cornerRadius)),
                    color: cardColor,
                  ),
                  height: height,
                  width: width,
                  child: new Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          image == null
                              ? Container(
                                  alignment: Alignment.center,
                                  height: height,
                                  padding: contentPadding,
                                  child: Column(
                                    crossAxisAlignment: contentListAlignment,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: _contentList,
                                  ),
                                )
                              : image,
                          closeButton == true
                              ? Container(
                                  margin: EdgeInsets.only(top: 8),
                                  height: 26,
                                  alignment: Alignment.topRight,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black87,
                                      size: 19,
                                    ),
                                    backgroundColor:
                                        Color.fromRGBO(240, 240, 240, 0.8),
                                    elevation: 2,
                                  ),
                                )
                              : Container(),
                          isMainButton == true
                              ? Positioned(
                                  bottom: 20,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .37,
                                    height: 40,
                                    margin:
                                        EdgeInsets.only(left: 25, right: 25),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        onTap();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: color,
                                      ),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ))
                              : Container(),
                        ],
                      ),
                      image == null
                          ? Container()
                          : Expanded(
                              child: Container(
                                padding: contentPadding,
                                child: Column(
                                  crossAxisAlignment: contentListAlignment,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: _contentList,
                                ),
                              ),
                            ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
