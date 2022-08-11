import 'package:ax_dapp/pages/scout/dialogs/redeem/bloc/redeem_dialog_bloc.dart';
import 'package:ax_dapp/pages/scout/dialogs/redeem/bloc/redeem_dialog_event.dart';
import 'package:ax_dapp/pages/scout/dialogs/redeem/bloc/redeem_dialog_state.dart';
import 'package:ax_dapp/pages/scout/models/athlete_scout_model.dart';
import 'package:ax_dapp/service/controller/scout/lsp_controller.dart';
import 'package:ax_dapp/service/controller/wallet_controller.dart';
import 'package:ax_dapp/service/dialog.dart';
import 'package:ax_dapp/service/failed_dialog.dart';
import 'package:ax_dapp/service/tracking/tracking_cubit.dart';
import 'package:ax_dapp/util/format_wallet_address.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RedeemDialog extends StatefulWidget {
  const RedeemDialog(
    this.athlete,
    this.aptName,
    this.inputLongApt,
    this.inputShortApt,
    this.valueInAX, {
    super.key,
  });

  final AthleteScoutModel athlete;
  final String aptName;
  final String inputLongApt;
  final String inputShortApt;
  final String valueInAX;

  @override
  State<RedeemDialog> createState() => _RedeemDialogState();
}

class _RedeemDialogState extends State<RedeemDialog> {
  double paddingHorizontal = 40;
  double hgt = 450;
  final TextEditingController _longInputController = TextEditingController();
  final TextEditingController _shortInputController = TextEditingController();

  final WalletController walletController = Get.find();
  LSPController lspController = Get.find();

  @override
  void initState() {
    super.initState();
    lspController.updateAptAddress(widget.athlete.id);
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

    return BlocBuilder<RedeemDialogBloc, RedeemDialogState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final bloc = context.read<RedeemDialogBloc>();
        final longBalance = state.longBalance;
        final shortBalance = state.shortBalance;
        final receiveAmount = state.receiveAmount.toStringAsFixed(6);
        final smallestBalance = state.smallestBalance.toStringAsFixed(6);
        if (state.tokenAddress.isEmpty) {
          bloc.add(OnRedeemLoad(athleteId: widget.athlete.id));
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
              children: [
                RedeemTitle(wid: wid, widget: widget),
                RedeemInformation(wid: wid, isWeb: isWeb),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Input APT pair - Max Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isWeb
                              ? 'Input APT pair:'
                              : 'Input APT pair and amount:',
                          style: textStyle(Colors.grey[600]!, 14, false),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
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
                              bloc.add(OnMaxRedeemTap(widget.athlete.id));
                              _longInputController.text = smallestBalance;
                              _shortInputController.text = smallestBalance;
                            },
                            child: Text(
                              'MAX',
                              style: textStyle(Colors.grey[400]!, 9, false),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Long APT input box
                    Container(
                      width: wid,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.grey[400]!,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
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
                              Expanded(
                                child: Text(
                                  'Long APTs',
                                  style: textStyle(Colors.white, 15, false),
                                ),
                              ),
                              ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxWidth: wid * 0.4),
                                child: IntrinsicWidth(
                                  child: TextField(
                                    controller: _longInputController,
                                    style:
                                        textStyle(Colors.grey[400]!, 22, false),
                                    decoration: InputDecoration(
                                      hintText: '0.00',
                                      hintStyle: textStyle(
                                        Colors.grey[400]!,
                                        22,
                                        false,
                                      ),
                                      contentPadding: isWeb
                                          ? const EdgeInsets.all(9)
                                          : const EdgeInsets.all(6),
                                      border: InputBorder.none,
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^(\d+)?\.?\d{0,6}'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      if (value == '') {
                                        value = '0.00';
                                      }
                                      bloc.add(
                                        OnLongInput(
                                          double.parse(value),
                                        ),
                                      );
                                      _shortInputController.text = value;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ShowLongBalance(longBalance: longBalance)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: wid,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.grey[400]!,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
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
                              Expanded(
                                child: Text(
                                  'Short APTs',
                                  style: textStyle(Colors.white, 15, false),
                                ),
                              ),
                              ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxWidth: wid * 0.4),
                                child: IntrinsicWidth(
                                  child: TextField(
                                    controller: _shortInputController,
                                    style:
                                        textStyle(Colors.grey[400]!, 22, false),
                                    decoration: InputDecoration(
                                      hintText: '0.00',
                                      hintStyle: textStyle(
                                        Colors.grey[400]!,
                                        22,
                                        false,
                                      ),
                                      contentPadding: isWeb
                                          ? const EdgeInsets.all(9)
                                          : const EdgeInsets.all(6),
                                      border: InputBorder.none,
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^(\d+)?\.?\d{0,6}'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      if (value == '') {
                                        value = '0.00';
                                      }
                                      bloc.add(
                                        OnShortInput(
                                          double.parse(value),
                                        ),
                                      );
                                      _longInputController.text = value;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ShowShortBalance(shortBalance: shortBalance)
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 0.35,
                  color: Colors.grey[400],
                ),
                ShowYouReceive(receiveAmount: receiveAmount),
                SizedBox(
                  width: wid,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: 175,
                        height: 45,
                        decoration: boxDecoration(
                          Colors.amber[500]!.withOpacity(0.20),
                          500,
                          1,
                          Colors.transparent,
                        ),
                        child: TextButton(
                          onPressed: () async {
                            final result = await lspController.redeem();
                            if (result) {
                              await showDialog<void>(
                                context: context,
                                builder: (BuildContext context) =>
                                    confirmTransaction(context, true, ''),
                              ).then((value) {
                                context
                                    .read<TrackingCubit>()
                                    .trackAthleteRedeemSuccess(
                                      name: '${widget.athlete.name} pair',
                                      sport: widget.athlete.sport.toString(),
                                      inputLongApt: _longInputController.text,
                                      inputShortApt: _shortInputController.text,
                                      valueInAx:
                                          (lspController.redeemAmt * 15000)
                                              .toStringAsFixed(6),
                                      walletId: userWalletAddress.walletAddress,
                                    );
                              });
                            } else {
                              await showDialog<void>(
                                context: context,
                                builder: (context) => const FailedDialog(),
                              );
                            }
                            if (mounted) {
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'Confirm',
                            style: textStyle(Colors.amber[500]!, 16, false),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _longInputController.dispose();
    _shortInputController.dispose();
    super.dispose();
  }
}

class RedeemInformation extends StatelessWidget {
  const RedeemInformation({
    super.key,
    required this.wid,
    required this.isWeb,
  });

  final double wid;
  final bool isWeb;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: wid,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text:
                  "You can redeem APT's at their Book Value for AX.",
              style: textStyle(
                Colors.grey[600]!,
                isWeb ? 14 : 12,
                false,
              ),
            ),
            TextSpan(
              text:
                  ''' You can access other funds with AX on the Matic network through''',
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
    );
  }
}

class RedeemTitle extends StatelessWidget {
  const RedeemTitle({
    super.key,
    required this.wid,
    required this.widget,
  });

  final double wid;
  final RedeemDialog widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: wid,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Redeem ${widget.athlete.name} APT Pair',
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
    );
  }
}

class ShowYouReceive extends StatelessWidget {
  const ShowYouReceive({
    super.key,
    required this.receiveAmount,
  });

  final String receiveAmount;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'You Receive: ',
            style: textStyle(Colors.white, 15, false),
          ),
          Row(
            children: [
              Text(
                '''$receiveAmount AX''', // 15000 is the collateral per pair
                style: textStyle(Colors.white, 15, false),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShowShortBalance extends StatelessWidget {
  const ShowShortBalance({
    super.key,
    required this.shortBalance,
  });

  final String shortBalance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Balance: $shortBalance',
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }
}

class ShowLongBalance extends StatelessWidget {
  const ShowLongBalance({
    super.key,
    required this.longBalance,
  });

  final String longBalance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Balance: $longBalance',
            style: textStyle(Colors.grey[600]!, 15, false),
          ),
        ],
      ),
    );
  }
}
