# Python Repository Guideline

## Environment & Dependencies
- Use Python 3.11 and manage the toolchain with [`uv`](https://github.com/astral-sh/uv).
- After cloning a project run `uv sync` to install locked dependencies; avoid `pip install` so environments stay reproducible from `pyproject.toml` and `uv.lock`.
- When adding a dependency, declare it in `pyproject.toml`, run `uv sync`, and document the change in your pull request or review notes.
- Execute scripts and CLIs with `uv run <command>` to ensure they execute inside the managed environment (for example, `uv run python path/to/script.py`).

## Running & Testing Projects
- Provide runnable entry points (CLI, module, or app) and document them; invoke them with `uv run ...` so contributors do not rely on a globally installed interpreter.
- Run automated tests through `uv run pytest`; add flags such as `--maxfail=1 -q` for fast feedback loops during development.
- Projects that ship packages or wheels should validate builds with `uv build` before tagging or releasing artifacts.
- New features must include pytest cases under `tests/`, using the `test_*.py` naming convention and mirroring the source module layout for clarity.
- When behavior changes, update fixtures, snapshots, generated assets, and documentation to keep expectations aligned.

## Coding Standards
- Target Python 3.11 features, use four-space indentation, and apply type hints on public interfaces to aid static analysis.
- Prefer Python 3.10+ built-in generics (for example, `list[int]` instead of `typing.List[int]`) and the `|` union syntax instead of `typing.Union`.
- Default to double-quoted strings, keep lines under 120 characters, and prefer explicit imports over star imports.
- Run `uv run ruff check .` and `uv run ruff format .` (or the project-specific directories) before pushing to satisfy linting and formatting requirements.
- Keep modules organized according to the repository architecture documentation; group core logic, integrations, and adapters by responsibility so new contributors can discover code paths quickly.
- Avoid ad-hoc fallback handling: when the code hits an unexpected state, raise instead of quietly recovering or logging a warning. Do not soften contracts by widening types with `| None` in signatures or converting required parameters to optional just to skip validation, and avoid `dict.get(..., default)` when the key must exist.

## Commit Crafting
- Write commit messages in English using the format `✨ [feat]: Short summary`: emoji + space + bracketed tag + colon + sentence-case summary under 72 characters.
- Choose tags that match the intent (`🐛 [fix]`, `📝 [docs]`, `♻️ [refactor]`, `🔧 [chore]`, etc.); reference `.claude/agents/commit-crafter.md` for the full catalog.
- Favor atomic commits that each compile, pass tests, and address a single logical concern. If the diff spans multiple concerns, split it before committing.
- Include optional body text explaining motivation or follow-up steps when the change warrants extra context.
- Rebase or squash fix-up commits locally so the published history remains clean and review-friendly.
