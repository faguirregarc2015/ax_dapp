import 'package:ax_dapp/dialogs/promo/connected_wallet_promo_dialog.dart';
import 'package:ax_dapp/pages/connect_wallet/mobile_login_page.dart';
import 'package:ax_dapp/service/tracking/tracking_cubit.dart';
import 'package:ax_dapp/util/helper.dart';
import 'package:ax_dapp/wallet/bloc/wallet_bloc.dart';
import 'package:ax_dapp/wallet/widgets/dialogs/connect_metamask_dialog.dart';
import 'package:ax_dapp/wallet/widgets/dialogs/wrong_network_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletDialog extends StatelessWidget {
  const WalletDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WalletBloc, WalletState>(
          listener: (_, state) {
            if (state.isWalletUnavailable) {
              Navigator.pop(context);
              showDialog<void>(
                context: context,
                builder: (_) => const ConnectMetaMaskDialog(),
              );
            }
            if (state.isWalletUnsupported) {
              Navigator.pop(context);
              showDialog<void>(
                context: context,
                builder: (_) => const WrongNetworkDialog(),
              );
            }
            if (state.isWalletConnected) {
              Navigator.pop(context);
              showDialog<void>(
                context: context,
                builder: (context) => const ConnectedWalletPromoDialog(),
              );
              final walletAddress =
                  context.read<WalletBloc>().state.formattedWalletAddress;
              context.read<TrackingCubit>().onConnectWalletSuccessful(
                    publicAddress: walletAddress,
                    axUnits: '"${toDecimal(state.axData.balance!, 6)} AX"',
                  );
            }
          },
        ),
      ],
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            constraints: const BoxConstraints(minHeight: 235, maxHeight: 250),
            height: constraints.maxHeight * 0.26,
            width: constraints.maxWidth * 0.27,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 0),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Choose Wallet',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      width: constraints.maxWidth < 450
                          ? constraints.maxWidth * 0.62
                          : constraints.maxWidth * 0.22,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.grey[400]!, width: 2),
                      ),
                      child: TextButton(
                        onPressed: () {
                          context
                              .read<WalletBloc>()
                              .add(const ConnectWalletRequested());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/fox.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Text(
                              'Metamask',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 16,
                              ),
                            ),
                            //empty container
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: !kIsWeb,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    width: constraints.maxWidth < 450
                        ? constraints.maxWidth * 0.62
                        : constraints.maxWidth * 0.22,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey[400]!, width: 2),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => const MobileLoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Add/Create wallet',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
