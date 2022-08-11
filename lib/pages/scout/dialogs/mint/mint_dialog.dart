import 'package:ax_dapp/pages/athlete/components/athlete_mint_approve_button.dart';
import 'package:ax_dapp/pages/scout/dialogs/mint/bloc/mint_dialog_bloc.dart';
import 'package:ax_dapp/pages/scout/dialogs/mint/bloc/mint_dialog_event.dart';
import 'package:ax_dapp/pages/scout/dialogs/mint/bloc/mint_dialog_state.dart';
import 'package:ax_dapp/pages/scout/models/athlete_scout_model.dart';
import 'package:ax_dapp/service/Dialog.dart';
import 'package:ax_dapp/service/controller/scout/lsp_controller.dart';
import 'package:ax_dapp/service/controller/wallet_controller.dart';
import 'package:ax_dapp/util/format_wallet_address.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MintDialog extends StatefulWidget {
  const MintDialog(this.athlete, {super.key});
  final AthleteScoutModel athlete;

  @override
  State<MintDialog> createState() => _MintDialogState();
}

class _MintDialogState extends State<MintDialog> {
  double paddingHorizontal = 20;
  double hgt = 450;
  final TextEditingController _aptAmountController = TextEditingController();
  final WalletController walletController = Get.find();
  LSPController lspController = Get.find();

  @override
  void dispose() {
    _aptAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWeb =
        kIsWeb && (MediaQuery.of(context).orientation == Orientation.landscape);
    final _height = MediaQuery.of(context).size.height;
    final wid = isWeb ? 400.0 : 355.0;
    if (_height < 505) hgt = _height;
    final userWalletAddress = FormatWalletAddress.getWalletAddress(
      walletController.controller.publicAddress.toString(),
    );

    return BlocBuilder<MintDialogBloc, MintDialogState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final bloc = context.read<MintDialogBloc>();
        final balance = state.balance;
        final youSpent = state.mintInput;
        final receiveAmount = state.receiveAmount;
        final receiveAmountFormatted = receiveAmount.toStringAsFixed(6);
        if (state.tokenAddress.isEmpty) {
          bloc.add(OnLoadDialog(athleteId: widget.athlete.id));
        }
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            height: hgt,
            width: wid,
            decoration: boxDecoration(Colors.grey[900]!, 30, 0, Colors.black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: wid,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Mint ${widget.athlete.name} APT Pair',
                        style: textStyle(Colors.white, 20, false),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: wid,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'You can mint APTs at their Book Value with AX.',
                          style: textStyle(
                            Colors.grey[600]!,
                            isWeb ? 14 : 12,
                            false,
                          ),
                        ),
                        TextSpan(
                          text: ' You can buy AX on the Matic network through',
                          style: textStyle(
                            Colors.grey[600]!,
                            isWeb ? 14 : 12,
                            false,
                          ),
                        ),
                        TextSpan(
                          text: ' SushiSwap',
                          style: textStyle(
                            Colors.amber[400]!,
                            isWeb ? 14 : 12,
                            false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: wid,
                      child: Text(
                        'Input APT:',
                        style: textStyle(Colors.grey[600]!, 14, false),
                      ),
                    ),
                    //Input box
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      width: wid,
                      height: 70,
                      decoration: boxDecoration(
                        Colors.transparent,
                        14,
                        0.5,
                        Colors.grey[400]!,
                      ),
                      child: Column(
                        children: [
                          //APT icon - athlete name - max button - input field
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 35,
                                height: 35,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    scale: 0.5,
                                    image: AssetImage(
                                      'assets/images/apt_inverted.png',
                                    ),
                                  ),
                                ),
                              ),
                              Container(width: 5),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    scale: 0.5,
                                    image: AssetImage(
                                      'assets/images/apt_noninverted.png',
                                    ),
                                  ),
                                ),
                              ),
                              Container(width: 15),
                              Expanded(
                                child: Text(
                                  '${widget.athlete.name} APT',
                                  style: textStyle(Colors.white, 15, false),
                                ),
                              ),
                              Container(
                                height: 28,
                                width: 48,
                                decoration: boxDecoration(
                                  Colors.transparent,
                                  100,
                                  0.5,
                                  Colors.grey[400]!,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    bloc.add(OnMaxBuyTap());
                                    _aptAmountController.text =
                                        (state.balance / 15000)
                                            .toStringAsFixed(6);
                                  },
                                  child: Text(
                                    'Max',
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
                                        Colors.grey[400]!,
                                        22,
                                        false,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.only(left: 3),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        value = '0';
                                      }
                                      bloc.add(
                                        OnNewMintInput(
                                          mintInput: double.parse(value),
                                        ),
                                      );
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^(\d+)?\.?\d{0,6}'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ShowBalance(axBalance: balance),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 0.35,
                  color: Colors.grey[400],
                ),
                //You spend, you receive widgets
                SizedBox(
                  height: 100,
                  width: wid,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ShowYouSpend(youSpent: youSpent),
                      Container(height: 10),
                      ShowYouReceive(
                        receiveAmountFormatted: receiveAmountFormatted,
                      ),
                    ],
                  ),
                ),
                //Approve/Confirm
                SizedBox(
                  width: wid,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AthleteMintApproveButton(
                        width: 175,
                        height: 40,
                        text: 'Approve',
                        athlete: widget.athlete,
                        aptName: widget.athlete.name,
                        inputApt: _aptAmountController.text,
                        valueInAX: '${youSpent * 15000} AX',
                        approveCallback: bloc.lspController.approve,
                        confirmCallback: bloc.lspController.mint,
                        confirmDialog: transactionConfirmed,
                        walletAddress: userWalletAddress.walletAddress,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ShowYouSpend extends StatelessWidget {
  const ShowYouSpend({
    super.key,
    required this.youSpent,
  });

  final double youSpent;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'You Spend:',
            style: textStyle(Colors.white, 15, false),
          ),
          Text(
            '${youSpent * 15000} AX',
            style: textStyle(Colors.white, 15, false),
          ),
        ],
      ),
    );
  }
}

class ShowYouReceive extends StatelessWidget {
  const ShowYouReceive({
    super.key,
    required this.receiveAmountFormatted,
  });

  final String receiveAmountFormatted;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'You Receive: ',
                style: textStyle(Colors.white, 15, false),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: <Widget>[
                  Text(
                    '$receiveAmountFormatted Long APTs',
                    style: textStyle(Colors.white, 15, false),
                  ),
                  Text(
                    ' + ',
                    style: textStyle(Colors.white, 15, false),
                  ),
                  Text(
                    '$receiveAmountFormatted Short APTs',
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
}

class ShowBalance extends StatelessWidget {
  const ShowBalance({
    super.key,
    required this.axBalance,
  });

  final double axBalance;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'AX Balance: $axBalance',
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }
}
