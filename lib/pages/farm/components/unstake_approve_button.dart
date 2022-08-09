import 'package:ax_dapp/pages/farm/modules/axl_info.dart';
import 'package:ax_dapp/service/controller/farms/farm_controller.dart';
import 'package:ax_dapp/service/dialog.dart';
import 'package:ax_dapp/service/tracking/tracking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// This code changes the state of the button
class UnStakeApproveButton extends StatefulWidget {
  const UnStakeApproveButton({
    required this.width,
    required this.height,
    required this.text,
    required this.confirmDialog,
    required this.selectedFarm,
    super.key,
  });

  final String text;
  final double width;
  final double height;
  final FarmController selectedFarm;
  final Dialog Function(BuildContext) confirmDialog;

  @override
  State<UnStakeApproveButton> createState() => _UnStakeApproveButtonState();
}

class _UnStakeApproveButtonState extends State<UnStakeApproveButton> {
  double width = 0;
  double height = 0;
  String text = '';
  bool isApproved = false;
  Color? fillcolor;
  Color? textcolor;
  Widget? dialog;

  @override
  void initState() {
    super.initState();
    width = widget.width;
    height = widget.height;
    text = widget.text;
    fillcolor = Colors.transparent;
    textcolor = Colors.amber;
  }

  AxlInfo getUnStakeInfo() {
    final tickerPair = widget.selectedFarm.athlete == null
        ? widget.selectedFarm.strName
        : widget.selectedFarm.athlete!;
    final tickerPairName = widget.selectedFarm.strStakedAlias.value.isNotEmpty
        ? widget.selectedFarm.strStakedAlias.value
        : widget.selectedFarm.strStakedSymbol.value;
    final axlInput = widget.selectedFarm.strUnStakeInput.value;
    final axlBalance = widget.selectedFarm.stakingInfo.value.viewAmount;
    return AxlInfo(tickerPair, tickerPairName, axlBalance, axlInput);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber),
        color: fillcolor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextButton(
        onPressed: () {
          final info = getUnStakeInfo();
          context.read<TrackingCubit>().onPressedUnStakeConfirm(
                tickerPair: info.tickerPair,
                tickerPairName: info.tickerPairName,
                axlInput: info.axlInput,
                axlBalance: info.axlBalance,
              );
          //Confirm button pressed
          widget.selectedFarm.unstake().then((value) {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) => widget.confirmDialog(context),
            );

            final info = getUnStakeInfo();
            context.read<TrackingCubit>().onUnStakeSuccess(
                  tickerPair: info.tickerPair,
                  tickerPairName: info.tickerPairName,
                  axlInput: info.axlInput,
                  axlBalance: info.axlBalance,
                );
          }).catchError((error) {
            showDialog<void>(
              context: context,
              builder: (context) => const FailedDialog(),
            );
          });
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: textcolor,
          ),
        ),
      ),
    );
  }
}
