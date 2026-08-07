# ValuesRefBodyV4

Test stack for the youdeploy-http-api e2e suite. It exercises the
`values_ref_config` `method` and `body` on stackforms `values_ref` calls
(PROD-818).

Every `values_ref` widget points at the `values-ref-echo` service of the e2e
docker-compose stack, which answers with the request it received. An `extract`
transform then reads the widget's options back out of that answer, so the options
a widget resolves to are exactly what the request carried:

| Widget | Proves |
| --- | --- |
| `region` | a `POST` body written as YAML is serialized and sent as JSON |
| `region_method` | the configured verb reaches the remote (options are `[.method]`) |
| `region_raw_body` | a body written as a JSON string is sent verbatim |
| `region_interpolated` | `${env_name}` is interpolated into the payload before the request |
