import 'package:ax_dapp/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountDialog extends StatelessWidget {
  const AccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final walletAddress =
        context.select((WalletBloc bloc) => bloc.state.walletAddress);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    var wid = 400.0;
    const edge = 40.0;
    const edge2 = 60.0;
    if (_width < 405) wid = _width;
    var hgt = 240.0;
    if (_height < 235) hgt = _height;

    var formattedWalletAddress = '';
    if (walletAddress.isNotEmpty) {
      final walletAddressPrefix = walletAddress.substring(0, 7);
      final walletAddressSuffix = walletAddress.substring(
        walletAddress.length - 5,
        walletAddress.length,
      );
      formattedWalletAddress = '$walletAddressPrefix...$walletAddressSuffix';
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: hgt,
        width: wid,
        decoration: boxDecoration(Colors.grey[900]!, 30, 0, Colors.black),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // title
              SizedBox(
                width: wid - edge,
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Account', style: textStyle(Colors.white, 20, false)),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 26,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              // inner box
              Container(
                width: wid - edge,
                height: 145,
                decoration: boxDecoration(
                  Colors.transparent,
                  14,
                  .5,
                  Colors.grey[400]!,
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: wid - edge2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Connected With Metamask',
                                  style: textStyle(
                                    Colors.grey[600]!,
                                    13,
                                    false,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.account_balance_wallet,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      formattedWalletAddress,
                                      style: textStyle(Colors.white, 20, false),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // TODO(anyone): https://athletex.atlassian.net/browse/AX-734
                                // There's only MetaMask currently supported,
                                // so there's no point in having a change
                                // wallet button yet.

                                // Container(
                                //   width: 75,
                                //   height: 25,
                                //   decoration: boxDecoration(
                                //      Colors.transparent,
                                //       100, 0, Colors.blue[800]!),
                                //   child: TextButton(
                                //     onPressed: () {
                                //       controller.changeAddress();
                                //     },
                                //     child: Text(
                                //       "Change",
                                //       style: textStyle(
                                //           Colors.blue[300]!, 10, true),
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  width: 75,
                                  height: 25,
                                  decoration: boxDecoration(
                                    Colors.transparent,
                                    100,
                                    0,
                                    Colors.red[900]!,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      context.read<WalletBloc>().add(
                                            const DisconnectWalletRequested(),
                                          );
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Disconnect',
                                      style: textStyle(
                                        Colors.red[900]!,
                                        10,
                                        true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: walletAddress,
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.filter_none,
                                color: Colors.grey,
                              ),
                              Text(
                                'Copy Address',
                                style: textStyle(Colors.grey[400]!, 15, false),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            final urlString =
                                'https://polygonscan.com/address/$walletAddress';
                            launchUrl(Uri.parse(urlString));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.open_in_new,
                                color: Colors.grey,
                              ),
                              Text(
                                'Show on Polygonscan',
                                style: textStyle(Colors.grey[400]!, 15, false),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle textStyle(Color color, double size, bool isBold) {
  if (isBold) {
    return TextStyle(
      color: color,
      fontFamily: 'OpenSans',
      fontSize: size,
      fontWeight: FontWeight.w500,
    );
  } else {
    return TextStyle(
      color: color,
      fontFamily: 'OpenSans',
      fontSize: size,
    );
  }
}

BoxDecoration boxDecoration(
  Color col,
  double rad,
  double borWid,
  Color borCol,
) {
  return BoxDecoration(
    color: col,
    borderRadius: BorderRadius.circular(rad),
    border: Border.all(color: borCol, width: borWid),
  );
}
