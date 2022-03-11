part of 'submit_bloc.dart';

class SubmitState extends Equatable {

  const SubmitState._({
    this.status = SubmitStatus.unknown,
    this.error,
  });

  const SubmitState.unknown() : this._();

  const SubmitState.processing()
      : this._(status: SubmitStatus.processing,);

  const SubmitState.succeeded () : this._(
    status: SubmitStatus.succeeded,
  );

  const SubmitState.failed({
    required String error,
  }) : this._(
    status: SubmitStatus.failed,
    error: error,
  );

  final SubmitStatus status;
  final String? error;

  @override
  List<Object?> get props => [status, error,];
}
