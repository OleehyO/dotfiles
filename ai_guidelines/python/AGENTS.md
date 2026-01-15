# Python Project Rules

- This project uses `uv` to manage Python environments. When running Python programs or commands, you should first activate the virtual environment by running `source .venv/bin/activate`, then you can directly invoke `python` or other Python tools. After adding dependencies, you should run `uv sync -U --all-extras` to install them.
- You must write unit tests for the features you implement. Refer to `.gitlab-ci.yml` for the full test command, but you can only test modified parts to save time.
- This project uses `pre-commit` to control code quality, which mainly includes `ruff` and `pyright` checks. After completing development, you should run `pre-commit run --all` to verify overall quality (no need to run `ruff` and `pyright` separately, just run `pre-commit`).
  - Issues found should be properly resolved, and you should not use `# noqa`, `# type: ignore`, or similar methods to skip errors.
  - Use `cast` cautiously and handle all types properly. The only case you are allowed to use `cast` is when you create a MagicMock or similar object, you can cast it into the type of the object you are creating.
- In test files, minimize the use of `hasattr`, `setattr`, and `getattr` methods. Prefer type narrowing (using `isinstance`) or `cast` instead. This improves type safety and makes the code more maintainable.
- When making commits, use conventional commit messages.
- When running git rebase commands (e.g., `git rebase --continue`), always use `-c core.editor=true` to avoid opening an interactive editor. For example: `git -c core.editor=true rebase --continue`. This prevents IDE from opening during automated rebase operations.