ExUnit.configure(formatters: [ExUnit.CLIFormatter, ExUnitSonarqube])

Mox.defmock(Sendinblue.HttpClientMockImpl, for: HttpClient)
Application.put_env(:http_client, :http_client_impl, Sendinblue.HttpClientMockImpl)

ExUnit.start()
