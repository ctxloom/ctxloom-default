---
source_sha256: af5a0c065676bea2a978a372683f28d8252136ca7bcbdeb0acc576a6bd384ac1
---
# Rust Dev

**Tooling:** tests via `#[cfg(test)]`, cucumber-rs (Gherkin acceptance); logging via tracing

**Test layout:**
- Unit: inline `#[cfg(test)]`
- Integration: `tests/*.rs`
- Acceptance: `tests/acceptance/features/*.feature`

**Logging:** message constants in `logmsg.rs`
```rust
pub const USER_CREATED: &str = "user_created";
info!(message = logmsg::USER_CREATED, username = %username);
```

**Error constants:** messages in `errmsg` module
```rust
pub mod errmsg {
    pub const DIVIDE_BY_ZERO: &str = "cannot divide by zero";
}
#[error("{}", errmsg::DIVIDE_BY_ZERO)]
DivideByZero,
```

**IoC:** generic service over traits, concrete alias for defaults
```rust
impl<R: UserRepository, E: EmailService> UserService<R, E> { ... }
pub type DefaultUserService = UserService<SqlUserRepository, SmtpEmailService>;
```
