import 'package:bmi/core/calculator_brain.dart';
import 'package:bmi/result_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'buttons.dart';

enum Gender { male, female }

enum ProperType { WEIGHT, AGE }
enum ActionType { ADD, SUBTRACT }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 100;
  int weight = 50;
  int age = 18;

  void reRenderViews(){
    //Use Bloc architecture to update view
    setState(() {});
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                              height = d.toInt();
                              reRenderViews();
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
                        cardChild: bottomCard('WEIGHT', this.weight, (){
                              this.weight = weight.updateAction(ActionType.SUBTRACT);
                                reRenderViews();
                          }, (){
                                this.weight = weight.updateAction(ActionType.ADD);
                                reRenderViews();
                            })
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: kActiveCardColor,
                      cardChild:
                          bottomCard('AGE', this.age, (){
                            this.age = age.updateAction(ActionType.ADD);
                            reRenderViews();
                          }, (){
                            this.age = age.updateAction(ActionType.ADD);
                            reRenderViews();
                          }),
                    ),
                  ),
                ],
              ),
            ),
            BottomButton(
              bottonTitle: 'CALCULATE',
              onTap: () {
                CalculatorBrain calc =
                    CalculatorBrain(height: height, weight: weight);

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ResultsPage(
                    bmiResult: calc.calculateBMI(),
                    resultText: calc.getResult(),
                    interpretation: calc.getInterpretation(),
                  );
                }));
              },
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
            RoundIconButton(icon: FontAwesomeIcons.minus, onPressed: (){
              print("weight reduce called");
              reduce();
            }),
            SizedBox(width: 10.0),
            RoundIconButton(icon: FontAwesomeIcons.plus, onPressed: increase)
          ],
        ),
      ],
    );
  }
}

extension NumberActions on int {

    int updateAction(ActionType actionType, {int value = 1}) {
      int currentValue  = this;
      switch (actionType) {
        case ActionType.ADD:
          return currentValue += value;
          break;
        case ActionType.SUBTRACT:
          return currentValue -= value;
          break;
        default: return currentValue;
      }
    }
}
