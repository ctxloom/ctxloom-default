---
tags:
  - rust
  - language
content_hash: sha256:c981df154e04b39fe4cd046cfa2e15853709559b4996a84d666a88ee989d8ecb
---
# Rust Dev

## Tooling
- Tests: `#[cfg(test)]`, cucumber-rs (Gherkin acceptance)
- Logging: tracing

## Test Layout
- Unit: inline `#[cfg(test)]`
- Integration: `tests/*.rs`
- Acceptance: `tests/acceptance/features/*.feature`

## Logging
```rust
// logmsg.rs
pub const USER_CREATED: &str = "user_created";
info!(message = logmsg::USER_CREATED, username = %username);
```

## Error Constants
```rust
pub mod errmsg {
    pub const DIVIDE_BY_ZERO: &str = "cannot divide by zero";
}
#[error("{}", errmsg::DIVIDE_BY_ZERO)]
DivideByZero,
```

## IoC
```rust
impl<R: UserRepository, E: EmailService> UserService<R, E> { ... }
pub type DefaultUserService = UserService<SqlUserRepository, SmtpEmailService>;
```