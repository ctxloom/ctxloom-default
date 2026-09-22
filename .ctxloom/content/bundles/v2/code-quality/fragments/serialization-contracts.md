---
tags:
  - code
  - quality
  - serialization
  - interop
description: You are writing serialization or deserialization code — defining a wire
  format, a JSON/YAML/TOML struct contract, an API response, a config schema, or
  a parser for input someone else produced. Also applies when you are changing
  the shape of something already serialized, including adding or removing a
  field's presence conditions.
---

# Serialization Contracts

Be permissive in what you accept. Be absolutely bog standard in what you emit.

The asymmetry is the whole rule. An input parser has one job: succeed on
anything a reasonable producer might send. An output serializer has a different
one: emit the most boring, most predictable, most uniform shape the format
allows, every time, so that nobody downstream has to write a special case.

## Output: every key, every time

**Never omit a key from output because its value is empty.** Not
`omitempty`, not `skip_serializing_if`, not `exclude_none`, not a conditional
`if value:` around a write.

An output row's shape must not depend on its contents. A key that appears only
when populated pushes a conditional onto every consumer, and it destroys a real
distinction: a reader cannot tell "this record has no tags" from "this surface
does not report tags" from "this version predates the field". Presence-as-signal
is a channel you did not mean to open, and once a consumer starts reading it you
cannot close it.

The cost of the discipline is a few bytes. The cost of the alternative is paid
by every consumer, forever, in code that cannot be written correctly because the
information needed to write it is absent.

**Empty is not null and null is not absent.** Getting the key present is only
half of it — the empty value must be the format's ordinary empty value of the
right TYPE:

| Field type | Empty output | Never |
| --- | --- | --- |
| list / array | `[]` | `null`, absent |
| map / object | `{}` | `null`, absent |
| string | `""` | `null`, absent |
| number | the real value | absent |
| boolean | `true` / `false` | absent |
| genuinely-unknown scalar | `null` | absent |

`null` is only correct where "not computed", "not applicable", or "unknown" is
a real state distinct from a value — and even then the key stays present, so
the reader gets a value it can branch on rather than an absence it must infer.

This matters most for collections, because a null there fails the operations a
consumer will actually reach for. `.tags | join(",")` and `.tags | length` both
error on `null` and both succeed on `[]`. A `for` loop over `null` throws in
most languages and silently does nothing in the rest, which is worse.

**Beware the nil/empty distinction in languages that have one.** In Go a nil
slice and an empty slice are both `len() == 0` but marshal to `null` and `[]`
respectively; the same trap exists for nil maps, Rust's `Option<Vec<_>>`, and
Python's `None`-vs-`[]`. Removing `omitempty` is therefore only half the fix —
the value itself must be non-nil by the time it reaches the encoder.

Fix it at the point where the value is DERIVED, not at the encoder, and
certainly not in each construction site:

- The derivation point is the one place every value passes through, so it is
  the only place the guarantee actually holds.
- A custom marshaller looks like the tidy fix and is a trap in any language
  with embedding or method promotion: in Go, a `MarshalJSON` on a struct is
  inherited by every struct that embeds it, and will serialize only the
  embedded type's own fields — silently dropping the outer type's. A wrapper
  that adds one field to a record is exactly the shape that breaks, and it
  breaks quietly, in the output, at runtime.

## Input: accept what a reasonable producer sends

Symmetrically, on the way IN, do not demand the discipline you impose on
yourself:

- An absent key, `null`, and the empty value all decode to the same empty
  value. A consumer of YOUR output will never see the first two, but you are
  not the only producer you will ever read from — including your own older
  versions.
- Accept the format's ordinary spelling variations where they carry no meaning:
  surrounding whitespace, both `1`/`true` where a format allows it, either
  string or number for an ID that has one canonical form.
- Ignore unknown fields by default rather than erroring. A strict-decode mode
  is a legitimate opt-in for config validation, where a typo'd key is a
  user-visible mistake worth reporting; it is the wrong default for a wire
  format you will need to evolve.
- Be permissive about SHAPE, never about MEANING. Accepting a missing field as
  empty is leniency. Guessing what an unparseable value probably meant, or
  silently coercing a type mismatch, is data corruption with a friendly face —
  fail loudly there.

## Version this like the contract it is

Field presence is part of the contract, so changing it is a contract change:

- Adding a key that is always emitted is safe for readers that ignore unknown
  fields, which is why that leniency is the default above.
- Making a key conditional is a BREAKING change even though nothing was
  removed. So is changing an empty value's spelling from `[]` to `null`.
- Round-trip is the test that catches this: encode, decode, encode again, and
  compare. Assert on the DECODED shape and on the presence of keys, not on a
  golden byte string, which pins incidental formatting and fails for the wrong
  reasons.
- When you must inspect output in a test, assert that the key exists separately
  from what it holds — `null` and absent are different failures with different
  causes, and a test that conflates them will not tell you which one you have.
