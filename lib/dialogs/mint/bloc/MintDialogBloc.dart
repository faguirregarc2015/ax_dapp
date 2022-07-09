import 'package:ax_dapp/dialogs/mint/models/MintDialogEvent.dart';
import 'package:ax_dapp/dialogs/mint/models/MintDialogState.dart';
import 'package:ax_dapp/service/Controller/Scout/LSPController.dart';
import 'package:ax_dapp/service/Controller/usecases/GetMaxTokenInputUseCase.dart';
import 'package:ax_dapp/util/BlocStatus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MintDialogBloc extends Bloc<MintDialogEvent, MintDialogState> {

  LSPController lspController;
  GetTotalTokenBalanceUseCase wallet;
  
  MintDialogBloc({
    required this.lspController,
    required this.wallet,
  }) : super(MintDialogState.initial()) {
    on<OnLoadDialog>(_mapLoadDialogEventToState);
    on<OnNewMintInput>(_mapNewMintInputEventToState);
    on<OnMaxBuyTap>(_mapMaxBuyTapEventToState);
  }

  void _mapLoadDialogEventToState(OnLoadDialog event, Emitter<MintDialogState> emit) async{ 
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      lspController.updateAptAddress(event.athleteId);
      final balance = await wallet.getTotalAxBalance();
      emit(state.copyWith(
        athleteId: event.athleteId,
        balance: balance,
        status: BlocStatus.success,
        tokenAddress: state.tokenAddress,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BlocStatus.error,
      ));
    }
  }

  void _mapNewMintInputEventToState(OnNewMintInput event, Emitter<MintDialogState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));
    final mintInputAmount = event.mintInput;
    final receiveAmount = mintInputAmount;
    try {
      lspController.updateCreateAmt(mintInputAmount);
      emit(state.copyWith(
        status: BlocStatus.success,
        mintInput: mintInputAmount,
        receiveAmount: receiveAmount,
      ));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  void _mapMaxBuyTapEventToState(OnMaxBuyTap event, Emitter<MintDialogState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));
    try {
      final maxInput = await wallet.getTotalAxBalance();
      final maxInputForm = maxInput / 15000;
      emit(state.copyWith(mintInput: maxInputForm, status: BlocStatus.success));
      add(OnNewMintInput(mintInput: maxInputForm));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }
  
}