import 'package:googleapis_auth/auth_io.dart';

class GoogleAuthService {
  // Define the scopes required
  final List<String> _scopes = [
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/firebase.database',
    'https://www.googleapis.com/auth/firebase.messaging',
  ];

  // Service account credentials in JSON format
  // final Map<String, String> _serviceAccountJson = {
  //   "type": "service_account",
  //   "project_id": "daraz-6e72d",
  //   "private_key_id": "a42459c655cbc5f93c3e012119a472ace598e645",
  //   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDK04bVoXZkNBxz\npEPuwsKGw212noTUAg2kDj7tPPf+QbIu81DdnAENDcBRiaeE6m2QJKtrhUD4eJSW\nXKoto8hDneOW66UiwXokFqZrS07n+7JdZwBlFlLbGVw0LUKPvLwA1vQ6DNxqIB7H\n5eJr+As93jx0myCq/nnxNsiMFLtzL0rHcojvUc8PAIoSMw9Bx23VOgTd2kSLbBhD\niybnEaGvkMwevovp7n/Ud+//KBsGmR4RPi+Xnz2YNNDWBL+kth20PaSHTPnoay5U\n9ZRlTCcVwaUY6KsTVXGnCL0weQOsxAQvYLrP+rFMIjr5Rsn53q5vH+SWgJZUFThm\nzjSJTg9zAgMBAAECggEAHkk7pwa3IPtPDE2I/0wBtBHWdJHzD51G4CpoZxBlj4fL\nzYrzlkPHPGXDQ+mkJArFVXLETgfVzcRjm5g2qR39t2sKIu0I+YmebWkcbIUQQT+q\nQJwyyOVuddzxkbD4cXIjOJTgXxKwjwBA2GSRTMH7G7/lkxve4umg183wYEpwOyCe\nM4PMr6tFLu3mqFoz/BqFd3Njnv7/OaHS8E06fUbCbTWWdMUmd8hPqsncXsySAcTC\nVyGmLXzpnNlG7JuJ6Fda4ttDQJEL6PHXiJHiQU907stxpHHRPKPmrnxP4ToO/0lc\nsZsQwOg0x6kJXXLpgeZjl8wYETMEVeWMhZZL7k30AQKBgQD/HVrHFNA01KywgvVj\nuUyRogYnuSBsLQkObArwybGcHOOgfw4N2CmniE3N6Hd9UJpDTGVL3MEUX5ndSDyf\nUiZFK9hMGquxOK0yq0tmdloxnjsdsfICCbmECVZDK0XElQfRddP7Vd02SzmebXO9\nP0c3b3Xbl5FrpJLjX3S6bgYpAQKBgQDLh7gBzVKmQZJUjm7/p7OV/N9W7vo+sIBS\nkBSEUcRGIt522Z4Yi38QnfPY7bLzCQ8fhRHiPDnL1jiYrXmvhkXi1ZA+op22twVj\nCRxsh1wb6k4QiO7ffYUHqTvbw/WORPtz/pDRyiOcLX1huekn6fGSkPbKpjleP7R+\n6DKrHUWkcwKBgFu2KdQ330Ge0xYBfkYDb0tLe/r7ynQZHJBatvQpDfiZShuAkYTY\nmODpV08Wqx4Zw9s9s4y6J48zbxTlyyVbWvay9Gcnj2F+hoUYn1qOYY5E2+uo9N9W\nr6KP2Lr862/oQ49BVJueGpBSKryRjHIUNX3wS+ZNbrHL0CJ9RnFe7EgBAoGBALET\nrKFMvVrO8/xDTAl8I8AcGUhudSSztYGfv2n8JfMLhVgMMAOU4oFXm3+iFy5iNFkt\nEokt8u8Iu4cCbzuqbAVV38DPBL6ib7phg+xcvGPBMBgsuv+RGnu23tBupqcYF1ot\nIlyULPVFkq/C6zsBzF7DZySbCJCahnRfmy3LMvtHAoGBAM+gozk5qYJg9pD2TB/n\npszJTBvaPfV1fdVZTCDbEqokvLVoUDjQazvcMS/stPdufRl95bb/L2hvjF54enpU\nWmGHh2NoerFPJQSV2yc+J+XvOg/qxYRlUM+d9D+a3xSgnPsl/tgrHsEc7sWY92vs\nOI3QFHT070LLmyjbSx6tLZgV\n-----END PRIVATE KEY-----\n",
  //   "client_email": "firebase-adminsdk-qern6@daraz-6e72d.iam.gserviceaccount.com",
  //   "client_id": "111944587090095874976",
  //   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  //   "token_uri": "https://oauth2.googleapis.com/token",
  //   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  //   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-qern6%40daraz-6e72d.iam.gserviceaccount.com",
  //   "universe_domain": "googleapis.com"
  // };

  // Function to get server key token
  Future<String> getServerKeyToken() async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(_serviceAccountJson),
      _scopes,
    );

    // Get the access token from the client
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
