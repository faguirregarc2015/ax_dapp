import 'dart:async';
import 'dart:math';

import 'package:ax_dapp/pages/scout/dialogs/redeem/bloc/redeem_dialog_event.dart';
import 'package:ax_dapp/pages/scout/dialogs/redeem/bloc/redeem_dialog_state.dart';
import 'package:ax_dapp/service/controller/scout/lsp_controller.dart';
import 'package:ax_dapp/service/controller/usecases/get_max_token_input_use_case.dart';
import 'package:ax_dapp/service/token_list.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedeemDialogBloc extends Bloc<RedeemDialogEvent, RedeemDialogState> {
  RedeemDialogBloc({
    required this.lspController,
    required this.wallet,
  }) : super(RedeemDialogState.inital()) {
    on<OnRedeemLoad>(_mapLoadDialogEventToState);
    on<OnShortInput>(_mapShortInputEventToState);
    on<OnLongInput>(_mapLongInputEventToState);
    on<OnMaxRedeemTap>(_mapMaxRedeemTapEventToState);
  }

  LSPController lspController;
  GetTotalTokenBalanceUseCase wallet;

  Future<void> _mapLoadDialogEventToState(
    OnRedeemLoad event,
    Emitter<RedeemDialogState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.initial));
    try {
      lspController.updateAptAddress(event.athleteId);
      final longBalance = await wallet.walletController
          .getTokenBalance(getLongAptAddress(event.athleteId));
      final shortBalance = await wallet.walletController
          .getTokenBalance(getShortAptAddress(event.athleteId));
      emit(
        state.copyWith(
          athleteId: event.athleteId,
          longBalance: longBalance,
          shortBalance: shortBalance,
          status: BlocStatus.success,
          tokenAddress: state.tokenAddress,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: BlocStatus.error,
        ),
      );
    }
  }

  Future<void> _mapShortInputEventToState(
    OnShortInput event,
    Emitter<RedeemDialogState> emit,
  ) async {
    final shortInput = event.shortInput;
    try {
      lspController.updateRedeemAmt(shortInput);
      emit(
        state.copyWith(
          status: BlocStatus.success,
          shortInput: shortInput,
          receiveAmount: shortInput * 15000,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: BlocStatus.error,
        ),
      );
    }
  }

  Future<void> _mapLongInputEventToState(
    OnLongInput event,
    Emitter<RedeemDialogState> emit,
  ) async {
    final longInput = event.longInput;
    try {
      lspController.updateRedeemAmt(longInput);
      emit(
        state.copyWith(
          status: BlocStatus.success,
          longInput: longInput,
          receiveAmount: longInput * 15000,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: BlocStatus.error,
        ),
      );
    }
  }

  Future<void> _mapMaxRedeemTapEventToState(
    OnMaxRedeemTap event,
    Emitter<RedeemDialogState> emit,
  ) async {
    try {
      final longBalance = await wallet.walletController
          .getTokenBalance(getLongAptAddress(event.athleteId));
      final shortBalance = await wallet.walletController
          .getTokenBalance(getShortAptAddress(event.athleteId));
      final smallestBalance =
          min(double.parse(longBalance), double.parse(shortBalance));
      lspController.updateRedeemAmt(smallestBalance);
      emit(
        state.copyWith(
          shortInput: smallestBalance,
          longInput: smallestBalance,
          receiveAmount: smallestBalance * 15000,
          status: BlocStatus.success,
          smallestBalance: smallestBalance,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }
}
