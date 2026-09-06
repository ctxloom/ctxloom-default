---
distilled_by: claude-code
---
Rust: tracing for logging; cucumber-rs Gherkin acceptance tests. Layout: unit inline `#[cfg(test)]`, integration `tests/*.rs`, acceptance `tests/acceptance/features/*.feature`. Message constants: logmsg.rs consts used as `info!(message = logmsg::USER_CREATED, field = %v)`; errmsg module consts in thiserror `#[error("{}", errmsg::X)]`. IoC via generics plus a default alias: `pub type DefaultUserService = UserService<SqlUserRepository, SmtpEmailService>`.