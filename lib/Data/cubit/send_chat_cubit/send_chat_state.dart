abstract class SendChatState {}

class SendChatInitial extends SendChatState {}

class SendChatLoading extends SendChatState {}

class SendChatLoaded extends SendChatState {}

class SendChatError extends SendChatState {}
