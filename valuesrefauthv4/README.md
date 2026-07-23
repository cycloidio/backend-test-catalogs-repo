# ValuesRefAuthV4

Test stack for the youdeploy-http-api e2e suite. It exercises
`values_ref_config` authentication on stackforms `values_ref` calls (PROD-817):
the `region` widget fetches its options from a `values_ref` and carries a
`values_ref_config` block (bearer auth via a `${cred:...}` reference, a static
header and a timeout) so form resolution and config generation are validated
end-to-end with an auth config present.
