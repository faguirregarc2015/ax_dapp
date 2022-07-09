import 'package:ax_dapp/dialogs/mint/bloc/MintDialogBloc.dart';
import 'package:ax_dapp/dialogs/mint/models/MintDialogEvent.dart';
import 'package:ax_dapp/dialogs/mint/models/MintDialogState.dart';
import 'package:ax_dapp/pages/scout/models/AthleteScoutModel.dart';
import 'package:ax_dapp/service/ApproveButton.dart';
import 'package:ax_dapp/service/Controller/Scout/LSPController.dart';
import 'package:ax_dapp/service/Controller/WalletController.dart';
import 'package:ax_dapp/service/Dialog.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MintDialog extends StatefulWidget {
  final AthleteScoutModel athlete;
  MintDialog(this.athlete, {Key? key}) : super(key: key);

  @override
  State<MintDialog> createState() => _MintDialogState();
}

class _MintDialogState extends State<MintDialog> {
  double paddingHorizontal = 20;
  double hgt = 450;
  TextEditingController _aptAmountController = TextEditingController();

  final WalletController walletController = Get.find();
  LSPController lspController = Get.find();

  @override
  void dispose() {
    _aptAmountController.dispose();
    super.dispose();
  }

  Widget showBalance(axBalance) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "AX Balance: $axBalance",
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }

  Widget showYouReceive(receiveAmountFormatted) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "You Receive: ",
                style: textStyle(Colors.white, 15, false),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$receiveAmountFormatted Long APTs",
                    style: textStyle(Colors.white, 15, false),
                  ),
                  Text(
                    " + ",
                    style: textStyle(Colors.white, 15, false),
                  ),
                  Text(
                    "$receiveAmountFormatted Short APTs",
                    style: textStyle(Colors.white, 15, false),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showYouSpend(spent) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "You Spend:",
            style: textStyle(Colors.white, 15, false),
          ), 
          Text(
            "${spent * 15000} AX",
            style: textStyle(Colors.white, 15, false),
          ),  
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isWeb =
        kIsWeb && (MediaQuery.of(context).orientation == Orientation.landscape);
    double _height = MediaQuery.of(context).size.height;
    double wid = isWeb ? 400 : 355;
    if (_height < 505) hgt = _height;

    return BlocBuilder<MintDialogBloc, MintDialogState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final bloc = context.read<MintDialogBloc>();
        final balance = state.balance;
        final spent = state.mintInput;
        final receiveAmount = state.receiveAmount;
        final receiveAmountFormatted = receiveAmount.toStringAsFixed(6);
        if (state.tokenAddress.isEmpty) {
          bloc.add(OnLoadDialog(athleteId: widget.athlete.id));
        }
        return Dialog(        
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            height: hgt,
            width: wid,
            decoration: boxDecoration(Colors.grey[900]!, 30, 0, Colors.black),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      width: wid,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Mint " + widget.athlete.name + " APT Pair",
                              style: textStyle(Colors.white, 20, false)),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      )),
                  Container(
                    width: wid,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "You can mint APTs at their Book Value with AX.",
                            style: textStyle(
                                Colors.grey[600]!, isWeb ? 14 : 12, false),
                          ),
                          TextSpan(
                            text: " You can buy AX on the Matic network through",
                            style: textStyle(
                                Colors.grey[600]!, isWeb ? 14 : 12, false),
                          ),
                          TextSpan(
                            text: " SushiSwap",
                            style: textStyle(
                                Colors.amber[400]!, isWeb ? 14 : 12, false),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: wid,
                          child: Text(
                            "Input APT:",
                            style: textStyle(Colors.grey[600]!, 14, false),
                          ),
                        ),
                        //Input box
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          width: wid,
                          height: 70,
                          decoration: boxDecoration(
                              Colors.transparent, 14, 0.5, Colors.grey[400]!),
                          child: Column(
                            children: [
                              //APT icon - athlete name - max button - input field
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        scale: 0.5,
                                        image: AssetImage(
                                            "assets/images/apt_inverted.png"),
                                      ),
                                    ),
                                  ),
                                  Container(width: 5),
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        scale: 0.5,
                                        image: AssetImage(
                                            "assets/images/apt_noninverted.png"),
                                      ),
                                    ),
                                  ),
                                  Container(width: 15),
                                  Expanded(
                                    child: Text(
                                      widget.athlete.name + " APT",
                                      style: textStyle(Colors.white, 15, false),
                                    ),
                                  ),
                                  Container(
                                    height: 28,
                                    width: 48,
                                    decoration: boxDecoration(Colors.transparent,
                                        100, 0.5, Colors.grey[400]!),
                                    child: TextButton(
                                      onPressed: () {
                                        bloc.add(OnMaxBuyTap());
                                        _aptAmountController.text =
                                            (state.balance/15000).toStringAsFixed(6);
                                      },
                                      child: Text(
                                        "MAX",
                                        style:
                                            textStyle(Colors.grey[400]!, 9, false),
                                      ),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints:
                                        BoxConstraints(maxWidth: wid * 0.4),
                                    child: IntrinsicWidth(
                                      child: TextField(
                                        controller: _aptAmountController,
                                        style:
                                            textStyle(Colors.grey[400]!, 22, false),
                                        decoration: InputDecoration(
                                          hintText: '0.00',
                                          hintStyle: textStyle(
                                              Colors.grey[400]!, 22, false),
                                          contentPadding: EdgeInsets.only(left: 3),
                                          border: InputBorder.none,
                                        ),
                                        onChanged: (value) {
                                          if (value == "") {
                                            value = "0";
                                          }
                                          bloc.add(OnNewMintInput(mintInput: double.parse(value)));
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              (RegExp(r'^(\d+)?\.?\d{0,6}'))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  showBalance(balance),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.35,
                    color: Colors.grey[400],
                  ),
                  //You spend, you receive widgets
                  Container(
                    //margin: EdgeInsets.only(top: 15.0),
                    height: 100,
                    width: wid,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        showYouSpend(spent),
                        Container(height: 10),
                        showYouReceive(receiveAmountFormatted),
                      ],
                    ),
                  ),
                  //Approve/Confirm
                  Container(
                    width: wid,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ApproveButton(175, 40, "Approve", bloc.lspController.approve,
                            bloc.lspController.mint, transactionConfirmed),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
