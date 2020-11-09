import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class ShowPic extends StatefulWidget {
  @override
  _ShowPicState createState() => _ShowPicState();
}

class _ShowPicState extends State<ShowPic> {
  String imgUrl;
  String imgInfo = "Image Information";
  String imgTitle = 'Image Title';
  String fileType = "fileType";

  String year;
  String month;
  String day;
  DateTime dateTime;

  Future<void> datePickerDialog(BuildContext context) async {
    DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2016, 1, 15, 0, 0),
        lastDate: DateTime.now(),
        cancelText: "CANCEL",
        confirmText: "SELECT");
    if (dateTime != null) {
      setState(() {
        year = dateTime.year.toString();
        month = dateTime.month.toString();
        day = dateTime.day.toString();
      });
      getApodRes(year: year, month: month, day: day)
          .then(showApod)
          .catchError((error) => print(error));
    }
  }

  Future<Response> getApodRes({String year, String month, String day}) {
    String date = year + "-" + month + "-" + day;
    String url = Uri.encodeFull(
        "https://api.nasa.gov/planetary/apod?date=$date&hd=true&api_key=DEMO_KEY");

    Future<Response> response = get(url);

    return response;
  }

  showApod(Response response) {
    Map<String, dynamic> apoddetails = json.decode(response.body);

    setState(() {
      imgInfo = apoddetails['explanation'] == null
          ? "data is not available"
          : apoddetails["explanation"];
      imgTitle = apoddetails['title'] == null
          ? "data is not available"
          : apoddetails['title'];
    });
    fileType = apoddetails['media_type'];
    if (fileType == "image") {
      imgUrl = apoddetails['hdurl'];
    } else {
      imgUrl = null;
    }
  }

  @override
  initState() {
    super.initState();
    dateTime = DateTime.now();
    year = dateTime.year.toString();
    month = dateTime.month.toString();
    day = dateTime.day.toString();
    getApodRes(year: year, month: month, day: day)
        .then((response) => showApod(response))
        .catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff1A1935),
          body: Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "NASA",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w100,
                        color: Color(0xffF8F8F8),
                        fontFamily: 'Kiona',
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    //gradient: UniversalVariables.fabGradient,

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                    ),
                    //color: UniversalVariables.white2
                    color: Colors.white.withOpacity(0.1),
                  ),
                  margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    child: GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "Pick Date: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffFD423C),
                                    fontFamily: 'Kiona',
                                  ),
                                ),
                                Text(
                                  day + "-" + month + "-" + year,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: 'Kiona',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              //gradient: UniversalVariables.fabGradient,

                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              ),
                              //color: UniversalVariables.white2
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(
                                Icons.calendar_today,
                                color: Color(0xffFD423C),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                        ],
                      ),
                      onTap: () async => await datePickerDialog(context),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  imgTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Color(0xffFD423C),
                    fontFamily: 'Kiona',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Container(
                  child: imgUrl != null
                      ? Image.network(imgUrl)
                      : fileType == "video"
                          ? Text(
                              "Image not available",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                fontFamily: 'Kiona',
                              ),
                            )
                          : Center(
                              child: Text(
                                "LOADING",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  fontFamily: 'Kiona',
                                ),
                              ),
                            ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    imgInfo,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontFamily: 'Kiona',
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
