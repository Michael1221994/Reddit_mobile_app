import 'package:imagekit/imagekit.dart';

final imagekit = ImageKit.getInstance();

void setupImageKit() {
  const config = Configuration(
    publicKey: 'public_utRNIWt7o50Fz77Di9zTvpcEd4Q=',
    urlEndpoint: 'https://ik.imagekit.io/rykpi3xx9/',
    authenticationEndpoint: 'http://www.yourserver.com/auth',
  );

  imagekit.setConfig(config);
}
