import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:kidsapp/models/PaymentInformation.dart';
import 'package:kidsapp/models/db.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({ this.message, this.success});
}

class StripeService {
  static PaymentInformation _paymentInformation;
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret ='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'; //'sk_test_51KAx1XKT6Q0esfZhjQn9W6yZLEk0SUMjUJaANteQJIyQifi2JNM4zJUnqa4BdncjjNApkmcFoGXyhdEZ30WjVcOp00hVwiRKbt';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(
        StripeOptions(
            publishableKey:"pk_live_51KC9JgIfFqyeXfWaiOD5qbwPwzyUrXveoM10RRphJI1J85QTLQOcVP55rAj7MeZt6fZn543qLgdifSjQ9GBJYxRp00e2BFoez5", //"pk_test_51KAx1XKT6Q0esfZhEBvpCz8daYx2Nzse0SeTGwwY5LkEVHgUiqLeYfVhDTQBKEwqWyj1kv6gbbi45JzRnDyGEMFc00k3cpwrMi",
            merchantId: "Test",
            androidPayMode: 'test'
        )
    );
  }

  static Future<StripeTransactionResponse> payWithNewCard({String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest()
      );
      var paymentIntent = await StripeService.createPaymentIntent(
          amount,
          currency
      );
      var response = await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: paymentIntent['client_secret'],
              paymentMethodId: paymentMethod.id
          )
      );
      if (response.status == 'succeeded') {
       int message=await SendPaymentInformation(1, response.paymentIntentId);
        if(message!=null&&message==200){
          return new StripeTransactionResponse(
              message: 'Transaction successful',
              success: true
          );}
        else{
          print("yyy");
          SendPaymentInformation(1, response.paymentIntentId);
        }
      } else {
        return new StripeTransactionResponse(
            message: 'Transaction failed',
            success: false
        );
      }
    } on PlatformException catch(err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      print(err.toString());
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}' ,
          success: false
      );
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(
        message: message,
        success: false
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount':amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse(StripeService.paymentApiUrl),
          body: body,
          headers: StripeService.headers
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }

  static  SendPaymentInformation(int status, String process_id) async {
    try {
      PaymentInformation paymentInformation = await Dbhandler.instance.SendPaymentInformation(status, process_id);
      return paymentInformation.message;
    } catch (error) {
      SendPaymentInformation(status, process_id);
    }
  }
}