# Summary

Vault is an identity-based secrets and encryption management system. A secret is anything that you want to tightly
control access to, such as API encryption keys, passwords, or certificates. Vault provides encryption services that are
gated by authentication and authorization methods.

Key features of Vault include:

* **Secure Secret Storage**: Arbitrary key/value secrets can be stored in Vault. Vault encrypts these secrets prior to
  writing them to persistent storage, so gaining access to the raw storage isn't enough to access your secrets.
  Vault can write to disk, Consul, and more.

* **Dynamic Secrets**: Vault can generate secrets on-demand for some systems, such as AWS or SQL databases. For example,
  when an application needs to access an S3 bucket, it asks Vault for credentials, and Vault will generate an AWS
  keypair with valid permissions on demand. After creating these dynamic secrets, Vault will also automatically revoke
  them after the lease is up.

* **Data Encryption**: Vault can encrypt and decrypt data without storing it. This allows security teams to define
  encryption parameters and developers to store encrypted data in a location such as SQL without having to design their
  own encryption methods.

* **Leasing and Renewal**: All secrets in Vault have a lease associated with them. At the end of the lease, Vault will
  automatically revoke that secret. Clients are able to renew leases via built-in renew APIs.

* **Revocation**: Vault has built-in support for secret revocation. Vault can revoke not only single secrets, but a tree
  of secrets, for example all secrets read by a specific user, or all secrets of a particular type. Revocation assists
  in key rolling as well as locking down systems in the case of an intrusion.

## Helpful notes

[What is vault](https://www.vaultproject.io/docs/what-is-vault)