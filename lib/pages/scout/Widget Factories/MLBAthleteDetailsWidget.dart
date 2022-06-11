import 'package:ax_dapp/pages/scout/Widget%20Factories/AthleteDetailsWidget.dart';
import 'package:ax_dapp/pages/scout/models/SportsModel/MLBAthleteScoutModel.dart';
import 'package:ax_dapp/util/AbbreviationMappingsHelper.dart';
import 'package:ax_dapp/util/AthletePageFormatHelper.dart';
import 'package:ax_dapp/util/Colors.dart';
import 'package:flutter/material.dart';

class MLBAthleteDetailsWidget implements AthleteDetailsWidget {
  final MLBAthleteScoutModel _athlete;
  MLBAthleteDetailsWidget(this._athlete);
  @override
  Widget athleteDetails() {
    return Container(
        height: 250,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Details",
                      style: textStyle(Colors.white, 24, false, false))),
              Divider(thickness: 1, color: greyTextColor),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Sport / League",
                        style: textStyle(greyTextColor, 20, false, false)),
                    Text("${_athlete.sport.name}",
                        //toDo add map for the different league
                        style: textStyle(greyTextColor, 20, false, false))
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Team",
                        style: textStyle(greyTextColor, 20, false, false)),
                    Text(
                        "${retrieveTeamCityName(_athlete.team)} ${retrieveTeamNickname(_athlete.team)}",
                        style: textStyle(greyTextColor, 20, false, false))
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Position",
                        style: textStyle(greyTextColor, 20, false, false)),
                    Text(retrieveFullMLBAthletePosition(_athlete.position),
                        style: textStyle(greyTextColor, 20, false, false))
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Season Start",
                        style: textStyle(greyTextColor, 20, false, false)),
                    Text("Mar 31, 2022",
                        style: textStyle(greyTextColor, 20, false, false))
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Season End",
                        style: textStyle(greyTextColor, 20, false, false)),
                    Text("Nov 2, 2022",
                        style: textStyle(greyTextColor, 20, false, false))
                  ]),
            ]));
  }

  @override
  Widget keyStatistics() {
    // TODO: implement keyStatistics
    return Container(
        height: 150,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
          Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                Container(
                  child: Text("Key Statistics",
                      style: textStyle(Colors.white, 24, false, false)),
                ),
                Container(
                    width: 260,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text("AtBat",
                                style:
                                    textStyle(greyTextColor, 10, false, false)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text("HR",
                                style:
                                    textStyle(greyTextColor, 10, false, false)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text("wOBA",
                                style:
                                    textStyle(greyTextColor, 10, false, false)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text("SB",
                                style:
                                    textStyle(greyTextColor, 10, false, false)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text("Err",
                                style:
                                    textStyle(greyTextColor, 10, false, false)),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text("InPl",
                                style:
                                    textStyle(greyTextColor, 10, false, false)),
                          ),
                        ])),
              ])),
          Divider(thickness: 1, color: greyTextColor),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
              Widget>[
            Container(
              child: Text("Current season Stats",
                  style: textStyle(greyTextColor, 16, false, false)),
            ),
            Container(
                width: 260,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(_athlete.atBats.toString(),
                            style: textStyle(greyTextColor, 10, false, false)),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(_athlete.homeRuns.toString(),
                            style: textStyle(greyTextColor, 10, false, false)),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                            _athlete.weightedOnBasePercentage
                                .toStringAsFixed(3),
                            style: textStyle(greyTextColor, 10, false, false)),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(_athlete.stolenBases.toString(),
                            style: textStyle(greyTextColor, 10, false, false)),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(_athlete.errors.toString(),
                            style: textStyle(greyTextColor, 10, false, false)),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(_athlete.inningsPlayed.toString(),
                            style: textStyle(greyTextColor, 10, false, false)),
                      ),
                    ]))
          ]),
        ]));
  }

  @override
  Widget createListCardsForWeb(team, _width, athNameBx){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Icon
          Container(
              width: 50,
              child: Icon(Icons.sports_baseball,
              color: Colors.grey[700])),
          Container(
          width: athNameBx,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_athlete.name,
                    style: textStyle(
                        Colors.white, 18, false, false)),
                Text(
                    retrieveFullMLBAthletePosition(_athlete.position),
                    style: textStyle(
                        Colors.grey[700]!, 10, false, false))
              ])),
          Container(
            width: _width * 0.12,
            child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text((retrieveTeamCityName(_athlete.team)),
                      style: textStyle(
                          Colors.white, 18, false, false)),
                  Text(retrieveTeamNickname(_athlete.team),
                      style: textStyle(
                          Colors.grey[700]!, 10, false, false))
                ])),
        ],
      ),
    );
  }

  @override
  Widget createListCardsForMobile(team, _width, athNameBx){
    return Container(
      child: Row(
        children: <Widget>[
          // Icon
          Container(
              width: 50,
              child: Icon(Icons.sports_baseball,
                  color: Colors.grey[700])),
          // Athlete Name
          Container(
              width: athNameBx,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_athlete.name,
                        style: textStyle(
                            Colors.white, 18, false, false)),
                    Text(
                        retrieveFullMLBAthletePosition(
                            _athlete.position),
                        style: textStyle(
                            Colors.grey[700]!, 10, false, false))
                  ])),
          // Team
          if (team)
            Container(
                width: _width * 0.15,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(retrieveTeamCityName(_athlete.team),
                          style: textStyle(
                              Colors.white, 18, false, false)),
                      Text(retrieveTeamNickname(_athlete.team),
                          style: textStyle(
                              Colors.grey[700]!, 10, false, false))
                    ])),
        ],
      ),
    );
  }
}