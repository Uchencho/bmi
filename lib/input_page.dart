import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reusable_card.dart';

const bottomContainerHeight = 50.0;
const bottomContainerColor = Color(0xFFEB1555);
const reusableCardColor = Color(0xFF1D1E33);

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text('BMI CALCULATOR'))),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCard(
                        cardChild: ReuseableIcon(
                          genderText: 'MALE',
                          genderIcon: FontAwesomeIcons.mars,
                        ),
                        colour: reusableCardColor),
                  ),
                  Expanded(
                      child: ReusableCard(
                    colour: reusableCardColor,
                    cardChild: ReuseableIcon(
                      genderIcon: FontAwesomeIcons.venus,
                      genderText: 'FEMALE',
                    ),
                  )),
                ],
              ),
            ),
            Expanded(child: ReusableCard(colour: reusableCardColor)),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: ReusableCard(colour: reusableCardColor)),
                  Expanded(child: ReusableCard(colour: reusableCardColor)),
                ],
              ),
            ),
            Container(
              height: bottomContainerHeight,
              color: bottomContainerColor,
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.0),
            )
          ],
        ));
  }
}
