# retrofitでretry実装


[【Android/Kotlin】OkHttpでHTTPリクエスト失敗時にリトライする方法](https://zenn.dev/kotaro666/articles/okhttp_retry_request)


複数のInterceptorを使えそう
[OkHttp Interceptors with Retrofit | by Ikhiloya Imokhai | The Startup | Medium](https://medium.com/swlh/okhttp-interceptors-with-retrofit-2dcc322cc3f3)

Failsafeが使えそう
[Failsafe - OkHttp](https://failsafe.dev/okhttp/)
[android - Retrofit: How do I retry the request again from okhttp interceptor? - Stack Overflow](https://stackoverflow.com/questions/69063298/retrofit-how-do-i-retry-the-request-again-from-okhttp-interceptor)

これでDelayed Retryを実装してみる
CallAdapterFactoryについて調べる
Interceptのsleepが問題ないか調べる


これがオリジナルに近いかな。
https://gist.github.com/imminent/ac7f2a222e22f4009af4