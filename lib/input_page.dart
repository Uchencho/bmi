import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reusable_card.dart';
import 'constants.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 100;
  int weight = 50;
  int age = 18;

  void increaseHeight() {
    setState(() {
      height++;
    });
  }

  void reduceHeight() {
    setState(() {
      height--;
    });
  }

  void increaseWeight() {
    setState(() {
      weight++;
    });
  }

  void reduceWeight() {
    setState(() {
      weight--;
    });
  }

  void increaseAge() {
    setState(() {
      age++;
    });
  }

  void reduceAge() {
    setState(() {
      age--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text('BMI CALCULATOR'))),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                        cardChild: ReuseableIcon(
                          genderText: 'MALE',
                          genderIcon: FontAwesomeIcons.mars,
                        ),
                        colour: selectedGender == Gender.male
                            ? kActiveCardColor
                            : kInactiveCardColor),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.female;
                        });
                      },
                      colour: selectedGender == Gender.female
                          ? kActiveCardColor
                          : kInactiveCardColor,
                      cardChild: ReuseableIcon(
                        genderIcon: FontAwesomeIcons.venus,
                        genderText: 'FEMALE',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCard(
                colour: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('HEIGHT', style: kLabelTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(height.toString(), style: kHeightTextStyle),
                        Text('cm', style: kLabelTextStyle)
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Color(0xFF8BD8E98),
                          activeTrackColor: Colors.white,
                          thumbColor: kBottomContainerColor,
                          overlayColor: Color(0x29EB1555),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0)),
                      child: Slider(
                          value: height.toDouble(),
                          onChanged: (double d) {
                            setState(() {
                              height = d.toInt();
                            });
                          },
                          inactiveColor: kInactiveCardColor,
                          min: kMinHeight,
                          max: kMaxHeight),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCard(
                        colour: kActiveCardColor,
                        cardChild: bottomCard('WEIGHT', this.weight,
                            reduceWeight, increaseWeight)),
                  ),
                  Expanded(
                    child: ReusableCard(
                        colour: kActiveCardColor,
                        cardChild: bottomCard(
                            'AGE', this.age, reduceAge, increaseAge)),
                  ),
                ],
              ),
            ),
            Container(
              height: kBottomContainerHeight,
              color: kBottomContainerColor,
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.0),
            )
          ],
        ));
  }

  Column bottomCard(
      String textName, int property, Function reduce, Function increase) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textName, style: kLabelTextStyle),
        Text(property.toString(), style: kHeightTextStyle),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundIconButton(icon: FontAwesomeIcons.minus, onPressed: reduce),
            SizedBox(width: 10.0),
            RoundIconButton(icon: FontAwesomeIcons.plus, onPressed: increase)
          ],
        ),
      ],
    );
  }
}

class BottomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        onPressed();
      },
      elevation: 0.0,
      child: Icon(icon),
      constraints: BoxConstraints.tightFor(
        width: 40.0,
        height: 40.0,
      ),
      fillColor: Color(0xFF4C4F5E),
      shape: CircleBorder(),
    );
  }
}
