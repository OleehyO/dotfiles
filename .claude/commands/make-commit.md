Use commit-crafter sub agent to make a standardized commit

## Usage

```
/make-commit [hint]
```

**Parameters:**
- `hint` (optional): A brief description or context to help customize the commit message. The hint will be used to guide the commit message generation while maintaining conventional commit standards.

**Examples:**
- `/make-commit` - Generate commit message based purely on code changes
- `/make-commit "API refactoring"` - Guide the commit to focus on API-related changes
- `/make-commit "fix user login bug"` - Provide context about the specific issue being fixed
- `/make-commit "add dark mode support"` - Indicate the feature being added
