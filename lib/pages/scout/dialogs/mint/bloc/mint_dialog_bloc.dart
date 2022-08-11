import 'dart:async';
import 'package:ax_dapp/pages/scout/dialogs/mint/bloc/mint_dialog_event.dart';
import 'package:ax_dapp/pages/scout/dialogs/mint/bloc/mint_dialog_state.dart';
import 'package:ax_dapp/service/controller/scout/lsp_controller.dart';
import 'package:ax_dapp/service/controller/usecases/get_max_token_input_use_case.dart';
import 'package:ax_dapp/util/bloc_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MintDialogBloc extends Bloc<MintDialogEvent, MintDialogState> {
  MintDialogBloc({
    required this.lspController,
    required this.wallet,
  }) : super(MintDialogState.initial()) {
    on<OnLoadDialog>(_mapLoadDialogEventToState);
    on<OnNewMintInput>(_mapNewMintInputEventToState);
    on<OnMaxBuyTap>(_mapMaxBuyTapEventToState);
  }
  LSPController lspController;
  GetTotalTokenBalanceUseCase wallet;

  Future<void> _mapLoadDialogEventToState(
    OnLoadDialog event,
    Emitter<MintDialogState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      lspController.updateAptAddress(event.athleteId);
      final balance = await wallet.getTotalAxBalance();
      emit(
        state.copyWith(
          athleteId: event.athleteId,
          balance: balance,
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

  Future<void> _mapNewMintInputEventToState(
    OnNewMintInput event,
    Emitter<MintDialogState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final mintInput = event.mintInput;
    try {
      lspController.updateCreateAmt(mintInput);
      emit(
        state.copyWith(
          status: BlocStatus.success,
          mintInput: mintInput,
          receiveAmount: mintInput,
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

  Future<void> _mapMaxBuyTapEventToState(
    OnMaxBuyTap event,
    Emitter<MintDialogState> emit,
  ) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final maxInput = await wallet.getTotalAxBalance();
      final maxInputForm = maxInput / 15000;
      emit(
        state.copyWith(
          mintInput: maxInputForm,
          status: BlocStatus.success,
          receiveAmount: maxInputForm,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }
}
