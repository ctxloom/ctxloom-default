---
tags:
  - python
  - language
content_hash: sha256:d3a3e8900593ab985b83cb6ab7461092d006ce7531b3a7604c71ab8f75c08207
---
# Python Dev

## Env/Tools
- Python 3 (version in pyproject.toml)
- UV (pkg mgr), pytest, Gherkin (pytest-bdd/behave), ruff, structlog

## Test Structure
- Unit: `test_*.py` (co-located)
- Integration: `tests/integration/test_*.py`
- Acceptance: `tests/acceptance/features/*.feature`

## Layout
```
src/package_name/{log_messages,error_messages,module,test_module}.py
tests/{integration,acceptance}/
.devcontainer/, justfile, pyproject.toml
```

## Exclude Co-located Tests
```toml
[tool.setuptools.packages.find]
where = ["src"]
exclude = ["**/test_*"]
```

## structlog
```python
@dataclass(frozen=True)
class LogMessages:
    USER_CREATED = "user_created"
LOG_MSG = LogMessages()
logger.info(LOG_MSG.USER_CREATED, username=username)
```

## Error Constants
```python
@dataclass(frozen=True)
class ErrorMessages:
    DIVIDE_BY_ZERO = "Cannot divide by zero"
ERROR_MSG = ErrorMessages()
raise ValueError(ERROR_MSG.DIVIDE_BY_ZERO)
```

## IoC
```python
class UserService:
    def __init__(self, repo: UserRepository, logger: structlog.BoundLogger):
        self._repo, self._logger = repo, logger
    @classmethod
    def create(cls, db: DatabaseConnection) -> "UserService":  # pragma: no cover
        return cls(SQLUserRepository(db), structlog.get_logger())
```

## Type Hints
All code fully annotated (signatures, attributes, module vars). Enforce with `mypy --strict` or `pyright`.

## Attribute Access
- No hardcoded string attr access: `getattr(obj, "method")`, `globals()["x"]`, `operator.attrgetter("field")` defeat static analysis/refactoring
- OK if string comes from runtime data; prefer explicit mappings

## getattr/hasattr - Let It Fail
No defensive `getattr`/`hasattr` (or swallowed AttributeError) without a recovery path; let AttributeError propagate to reveal the bug:
```python
value = getattr(obj, "name", None)  # BAD if None isn't handled
obj.process()                        # GOOD - fail loud, fix the type

# OK - genuine recovery path
if hasattr(plugin, "shutdown"):
    plugin.shutdown()  # Optional interface, skip if missing
```

## Dicts vs Structured Types
- Known keys → dataclass/NamedTuple, never bare dict
- Dicts OK for truly dynamic keys; TypedDict if dict syntax required

## Flow Control Anti-Patterns
Never use strings to control internal flow when values are known at dev time:
- String comparisons/dispatch for internal state → Enum + match/case
- `hasattr` branching → Protocol/ABC/isinstance
- Dict dispatch with hardcoded keys → match/case

```python
# BAD
if action == "create": do_create()

# GOOD
class Action(Enum):
    CREATE = auto()

match action:
    case Action.CREATE: do_create()
```

Exception: dynamic dispatch on external messages (API, queue, events) is OK at the boundary; convert to typed values immediately:
```python
def parse_status(raw: str) -> Status:
    match raw:
        case "pending": return Status.PENDING
        case _: raise ValueError(f"Unknown: {raw}")
```