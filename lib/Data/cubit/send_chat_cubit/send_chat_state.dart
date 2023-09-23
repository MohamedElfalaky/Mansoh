abstract class SendChatState {}

class SendChatInitial extends SendChatState {}

class SendChatLoading extends SendChatState {}

class SendChatLoaded extends SendChatState {
  // SendChatModel? response;
  // SendChatLoaded(this.response);
}

class SendChatError extends SendChatState {}
