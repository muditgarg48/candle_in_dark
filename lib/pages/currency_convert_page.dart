import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_picker/currency_picker.dart' as pick;
import 'package:frankfurter/frankfurter.dart' as convert;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../tools/theme.dart';

import '../widgets/button.dart';
import '../widgets/drawer.dart';
import '../widgets/warning_dialogue.dart';
import '../widgets/appBar.dart';
import '../widgets/toasts.dart';

import '../global_values.dart';

pick.Currency nullCurrency = pick.Currency(
  code: "XXX",
  name: "Select a currency",
  symbol: "¤",
  flag: null,
  decimalDigits: 2,
  number: 137,
  namePlural: "Select a currency",
  thousandsSeparator: ",",
  decimalSeparator: ".",
  spaceBetweenAmountAndSymbol: false,
  symbolOnLeft: true,
);

Widget myCard({
  Widget contents = const Text("Unable to load contents of the Card!"),
  required double deviceHeight,
  required double deviceWidth,
}) {
  return Container(
    height: deviceHeight / 3,
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.all(7),
    width: deviceWidth,
    decoration: BoxDecoration(
      color: themeCardColor(),
      boxShadow: [
        BoxShadow(
          blurRadius: 100,
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurStyle: BlurStyle.normal,
        ),
      ],
      borderRadius: BorderRadius.circular(30),
    ),
    child: contents,
  );
}

class CurrencyConvertorPage extends StatefulWidget {
  const CurrencyConvertorPage({Key? key}) : super(key: key);
  @override
  State<CurrencyConvertorPage> createState() => _CurrencyConvertorPageState();
}

class _CurrencyConvertorPageState extends State<CurrencyConvertorPage> {
  //Variables
  pick.Currency fromCurrency = nullCurrency;
  pick.Currency toCurrency = nullCurrency;
  double fromCurrencyValue = 0;
  double toCurrencyValue = 0;
  double conversionValue = 1;
  // ignore: prefer_typing_uninitialized_variables
  var latestForexRates;
  var controller = TextEditingController();

  void nullify(String choice) => setState(() {
        if (choice == "whole") {
          fromCurrency = nullCurrency;
          toCurrency = nullCurrency;
          latestForexRates = null;
          conversionValue = 1;
        }
        fromCurrencyValue = 0;
        toCurrencyValue = 0;
        controller.clear();
      });

  void genParticularForexRate() async {
    final frankfurter = convert.Frankfurter();
    final conversion = await frankfurter.getRate(
      from: convert.Currency(fromCurrency.code),
      to: convert.Currency(toCurrency.code),
    );
    setState(() => conversionValue = conversion.rate);
    // print('Single conversion: $conversion');
  }

  void genAllForexRate() async {
    final frankfurter = convert.Frankfurter();
    latestForexRates =
        await frankfurter.latest(from: convert.Currency(fromCurrency.code));
  }

  void swapCurr() {
    setState(() {
      pick.Currency temp = toCurrency;
      toCurrency = fromCurrency;
      fromCurrency = temp;
      conversionValue = 1 / conversionValue;
      double tempValue = toCurrencyValue;
      controller.text = toCurrencyValue.toString();
      toCurrencyValue = fromCurrencyValue;
      fromCurrencyValue = tempValue;
    });
    toast(
      context: context,
      msg: "Swapped",
      startI: Icons.swap_calls,
      endI: Icons.check,
    );
  }

  Widget updateCurr(String choice) {
    return myButton(
      action: () {
        pick.showCurrencyPicker(
          physics: const BouncingScrollPhysics(),
          theme: pick.CurrencyPickerThemeData(
            backgroundColor: themeBgColor(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            titleTextStyle: TextStyle(color: themeTxtColor()),
            subtitleTextStyle: TextStyle(color: themeTxtColor()),
          ),
          context: context,
          showFlag: true,
          showSearchField: true,
          showCurrencyName: true,
          showCurrencyCode: true,
          onSelect: (pick.Currency currency) {
            setState(() {
              if (choice == "source") {
                fromCurrency = currency;
                genAllForexRate();
              } else if (choice == "destination") {
                toCurrency = currency;
                genParticularForexRate();
              }
            });
          },
          favorite: ['INR', 'EUR', 'USD', 'GBP'],
        );
      },
      content: const Text("Choose"),
    );
  }

  Widget enterCurr(String choice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          choice == "source" ? fromCurrency.symbol : toCurrency.symbol,
          style: TextStyle(
            color: themeTxtColor(),
            fontSize: 30,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 50,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: choice == "source"
              ? TextField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: themeTxtColor(),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: themeTxtColor(),
                      ),
                    ),
                  ),
                  controller: controller,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (number) {
                    setState(() {
                      fromCurrencyValue = double.parse(number);
                      toCurrencyValue = fromCurrencyValue * conversionValue;
                    });
                  },
                )
              : Text(
                  "$toCurrencyValue",
                  style: TextStyle(
                    color: themeTxtColor(),
                    fontSize: 25,
                  ),
                ),
        ),
      ],
    );
  }

  Widget displayFlag(pick.Currency currentCurr) {
    return currentCurr.flag == null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              placeholder: (context, url) => LoadingAnimationWidget.inkDrop(
                color: themeTxtColor(),
                size: 30,
              ),
              imageUrl:
                  "https://media.istockphoto.com/vectors/white-flag-isolated-symbol-of-defeat-vector-illustration-vector-id854509618?k=20&m=854509618&s=612x612&w=0&h=wmdFuuQY-J48FG8m5f57t1M0HTb3HzX5qeig4DTSRTI=",
              height: 30,
              width: 30,
              fit: BoxFit.contain,
            ),
          )
        : Text(
            pick.CurrencyUtils.currencyToEmoji(currentCurr),
            style: const TextStyle(
              fontSize: 25,
            ),
          );
  }

  Widget printCurr(String choice) {
    pick.Currency currentCurr = nullCurrency;
    if (choice == "source") {
      currentCurr = fromCurrency;
    } else if (choice == "destination") {
      currentCurr = toCurrency;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        displayFlag(currentCurr),
        const SizedBox(width: 10),
        Text(
          "${currentCurr.code}: ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themeTxtColor(),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          currentCurr.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themeTxtColor(),
          ),
        ),
      ],
    );
  }

  Widget currentCurrencyRow(String choice) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            printCurr(choice),
            updateCurr(choice),
          ],
        ),
        enterCurr(choice),
      ],
    );
  }

  Future warningDialogue(String confirmationMsg, String choice) {
    var warning = WarningDialogue(
      confirmationMsg: confirmationMsg,
      choice: choice,
      jobDone: Icons.delete,
      action: nullify,
    );
    return warning.dialogueBox(context);
  }

  Widget inputCardContents() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          currentCurrencyRow("source"),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 2,
                    color: themeTxtColor(),
                  ),
                ),
                child: IconButton(
                  onPressed: () => warningDialogue(
                    "Clear values ?",
                    "values",
                  ),
                  tooltip: "Reset values",
                  icon: Icon(
                    Icons.clear_rounded,
                    size: 25,
                    color: themeTxtColor(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 2,
                    color: themeTxtColor(),
                  ),
                ),
                child: IconButton(
                  onPressed: swapCurr,
                  tooltip: "Swap Currencies",
                  icon: Icon(
                    Icons.swap_calls_outlined,
                    size: 25,
                    color: themeTxtColor(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
                child: IconButton(
                  onPressed: () => warningDialogue(
                    "Clear values and selections ?",
                    "whole",
                  ),
                  tooltip: "Reset completely",
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    size: 25,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          currentCurrencyRow("destination"),
        ],
      ),
    );
  }

  Widget moreDetailsCardContents() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            myButton(
              action: () {
                genAllForexRate();
                genParticularForexRate();
                toast(
                  context: context,
                  msg: "Refreshing data",
                  startI: Icons.refresh_outlined,
                );
              },
              content: Text(
                "LIVE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeTxtColor(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "${fromCurrency.symbol}1 = ${toCurrency.symbol}$conversionValue",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: MediaQuery.of(context).size.height / 30,
                color: themeTxtColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget forexRateSheet() {
    if (latestForexRates == null) {
      return Container(
        color: themeBgColor(),
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Text(
                  "Forex List is not ready!\nHappens for two reasons - \n1.Base Currency was not chosen.\n2.The Forex Sheet was not given time to be fetched\nTry to relaunch this section!",
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: themeTxtColor(),
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 9,
            ),
            Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: themeTxtColor(),
                size: 100,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 9,
            ),
            const Divider(
              color: Colors.black,
              height: 2,
              indent: 10,
              endIndent: 15,
            ),
            TextButton(
              child: Text(
                'Close Forex Rate Sheet',
                style: TextStyle(
                  color: themeTxtColor(),
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          color: themeBgColor(),
          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              customSliver(
                appBarTitle: "${fromCurrency.code} Forex rates",
                appBarBG:
                    "https://images.unsplash.com/photo-1580519542036-c47de6196ba5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80",
              ),
            ],
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Container(
                    width: double.infinity,
                    color: themeBgColor(),
                    child: Column(
                      children: [
                        for (convert.Rate r in latestForexRates)
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "1 ${r.from} = ${r.rate} ${r.to}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: themeTxtColor(),
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 2,
                    indent: 15,
                    endIndent: 15,
                  ),
                  TextButton(
                    child: Text(
                      'Close Forex Rate Sheet',
                      style: TextStyle(
                        color: themeTxtColor(),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MyDrawer(
        currentPage: features[1],
      ),
      body: Container(
        color: themeBgColor(),
        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            customSliver(
              appBarTitle: features[1]["appBarTitle"],
              appBarBG: features[1]["appBarBG"],
            ),
          ],
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              myCard(
                contents: inputCardContents(),
                deviceHeight: MediaQuery.of(context).size.height,
                deviceWidth: MediaQuery.of(context).size.width,
              ),
              myCard(
                contents: moreDetailsCardContents(),
                deviceHeight: MediaQuery.of(context).size.height / 2,
                deviceWidth: MediaQuery.of(context).size.width,
              ),
              myCard(
                contents: TextButton(
                  style: TextButton.styleFrom(
                    primary: themeButtonTxtColor(),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          color: Theme.of(context).backgroundColor,
                          child: forexRateSheet(),
                        );
                      },
                    );
                  },
                  child: Text(
                    "View all Forex Rates",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: themeTxtColor(),
                    ),
                  ),
                ),
                deviceHeight: MediaQuery.of(context).size.height / 4,
                deviceWidth: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
