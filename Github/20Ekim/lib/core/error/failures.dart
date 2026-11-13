abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Beklenmeyen bir sunucu hatası oluştu']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Veri yüklenirken hata oluştu']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'İstenen kaynak bulunamadı']);
}
