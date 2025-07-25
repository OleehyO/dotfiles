Perform code review on staged changes, ignore data files.

# Code Review Guidelines
## Review Categories

### 🔴 **Critical Issues** (Must Fix)
Issues that could cause bugs, security vulnerabilities, or system failures.

- **Logic Errors**: Incorrect conditional statements, off-by-one errors, infinite loops
- **Security Vulnerabilities**: SQL injection, XSS, hardcoded secrets, unsafe eval usage
- **Resource Leaks**: Unclosed file handles, database connections, memory leaks
- **Race Conditions**: Concurrent access without proper synchronization
- **Error Handling**: Swallowed exceptions, unhandled promise rejections

### 🟡 **Major Issues** (Should Fix)
Issues that impact maintainability, performance, or user experience.

- **Code Duplication**: Copy-pasted code that should be extracted into reusable functions
- **Performance Issues**: Inefficient algorithms, N+1 queries, unnecessary re-renders
- **API Design**: Breaking changes without deprecation warnings, inconsistent REST patterns
- **Testing**: Missing test coverage for critical paths, flaky tests
- **Dependencies**: Outdated packages with known vulnerabilities

### 🟢 **Minor Issues** (Consider Fixing)
Issues related to code style and minor improvements.

- **Naming Conventions**: Inconsistent variable names, unclear abbreviations
- **Code Style**: Indentation, spacing, line length violations
- **Documentation**: Missing JSDoc, outdated comments, typos in documentation
- **File Organization**: Misplaced files, inconsistent directory structure

## Review Checklist

### 1. Functional Correctness
- [ ] Code works as intended and handles edge cases
- [ ] No obvious bugs or logic errors
- [ ] Proper error handling for all failure scenarios
- [ ] Input validation and sanitization
- [ ] Boundary conditions tested

### 2. Security
- [ ] No hardcoded secrets or credentials
- [ ] Input properly sanitized before use
- [ ] Authentication and authorization checks in place
- [ ] No SQL injection or XSS vulnerabilities
- [ ] Secure defaults for configuration

### 3. Performance
- [ ] No obvious performance bottlenecks
- [ ] Efficient data structures and algorithms used
- [ ] Database queries optimized (no N+1)
- [ ] Memory usage reasonable
- [ ] Caching applied where appropriate

### 4. Code Quality
- [ ] Follows established code style guidelines
- [ ] Functions are small and focused (single responsibility)
- [ ] Clear and descriptive variable/function names
- [ ] No code duplication (DRY principle)
- [ ] Proper use of language features and patterns

### 5. Testing
- [ ] Unit tests cover new functionality
- [ ] Integration tests for API endpoints
- [ ] Tests are meaningful and not just for coverage
- [ ] Edge cases and error conditions tested
- [ ] Tests are deterministic and not flaky

### 6. Documentation
- [ ] Code is self-documenting with clear naming
- [ ] Complex algorithms have explanatory comments
- [ ] API documentation is complete and accurate
- [ ] README updates if needed
- [ ] Breaking changes documented

## Common Issues by Language

### JavaScript/TypeScript
- **Async/Await**: Proper error handling, no unhandled promise rejections
- **TypeScript**: Proper type definitions, no `any` types without justification
- **React**: Proper hook dependencies, no stale closures, key props on lists
- **Node.js**: Proper async error handling, no blocking operations

### Python
- **PEP 8**: Adherence to style guide, proper naming conventions
- **Type Hints**: Use modern type annotations
- **Imports**: No circular imports, proper import organization
- **Error Handling**: Specific exception types, proper logging

### Shell/Bash
- **Quoting**: Proper variable quoting to prevent word splitting
- **Error Handling**: `set -euo pipefail` usage, proper exit codes
- **Portability**: Avoid bashisms if targeting POSIX sh
- **Safety**: Validate inputs, avoid eval when possible

## Review Comments Format

### Suggested Comment Template
```
**[LEVEL] Brief Issue Description**

Current issue: [Specific problem with line reference]

Suggestion: [Concrete improvement suggestion]

Reasoning: [Why this change improves the code]

Example:
```language
// Before
[problematic code]

// After  
[improved code]
```

**[LEVEL]** = 🔴 CRITICAL / 🟡 MAJOR / 🟢 MINOR
```

### Examples of Good Comments

#### 🔴 Critical Issue
```
**🔴 CRITICAL SQL Injection Vulnerability**

Current issue: Direct string concatenation in SQL query at `src/auth.js:45`

Suggestion: Use parameterized queries

Reasoning: Prevents SQL injection attacks

Example:
```javascript
// Before
const query = `SELECT * FROM users WHERE email = '${email}'`

// After
const query = 'SELECT * FROM users WHERE email = ?'
db.query(query, [email])
```
```

#### 🟡 Major Issue
```
**🟡 MAJOR Performance Issue**

Current issue: N+1 query problem in `getUserPosts()` function at `src/api/users.js:123`

Suggestion: Use eager loading or JOIN query

Reasoning: Reduces database round trips from N+1 to 1

Example:
```javascript
// Before
const users = await getUsers()
const userPosts = users.map(user => getPosts(user.id))

// After
const usersWithPosts = await getUsers({ include: 'posts' })
```
```

#### 🟢 Minor Issue
```
**🟢 MINOR Naming Convention**

Current issue: Variable `tmp` doesn't describe its purpose at `src/utils.js:78`

Suggestion: Rename to `temporaryFilePath`

Reasoning: Improves code readability and self-documentation
```

## Review Process

### 1. Automated Checks First
Run these before human review:
- Linting (ESLint, Pylint, Shellcheck)
- Type checking (TypeScript, mypy)
- Unit tests
- Security scanning (npm audit, bandit)
- Formatting checks (Prettier, black)

### 2. Systematic Review Approach
1. **High-level overview**: Understand the change purpose
2. **Architecture**: Check if the approach fits the system design
3. **Implementation**: Review the actual code changes
4. **Tests**: Verify test coverage and quality
5. **Documentation**: Check for necessary updates
6. **Edge cases**: Consider unusual scenarios

### 3. Review Response Guidelines
- **Author**: Acknowledge all feedback, ask for clarification if needed
- **Reviewer**: Be constructive, explain the "why" behind suggestions
- **Resolution**: Mark comments as resolved when addressed
- **Follow-up**: Create tickets for larger refactoring tasks

## Special Cases

### Configuration Changes
- [ ] Changes don't expose sensitive data
- [ ] Default values are safe and reasonable
- [ ] Documentation updated for new options
- [ ] Backward compatibility considered

### Database Migrations
- [ ] Migration is reversible
- [ ] Performance impact assessed for large tables
- [ ] Indexes added appropriately
- [ ] Data integrity maintained

### API Changes
- [ ] Versioning strategy followed
- [ ] Breaking changes properly deprecated
- [ ] Documentation updated
- [ ] Client libraries updated if needed

## Tools Integration

### GitHub Integration
Add to `.github/pull_request_template.md`:
```markdown
## Code Review Checklist

### 🔴 Critical Issues
- [ ] No security vulnerabilities
- [ ] No obvious bugs or logic errors
- [ ] Proper error handling implemented

### 🟡 Major Issues  
- [ ] Performance implications considered
- [ ] Test coverage adequate
- [ ] No code duplication

### 🟢 Minor Issues
- [ ] Code follows style guidelines
- [ ] Naming conventions followed
- [ ] Documentation updated

## Review Notes
<!-- For reviewer comments -->
```

### VS Code Extensions
Recommended extensions for reviewers:
- GitLens (git blame and history)
- Error Lens (inline diagnostics)
- Code Spell Checker (typos)
- SonarLint (static analysis)

### Pre-commit Hooks
Add to `.pre-commit-config.yaml`:
```yaml
repos:
  - repo: local
    hooks:
      - id: code-review-prep
        name: Prepare for code review
        entry: scripts/pre-review-check.sh
        language: script
        files: '\.(js|py|sh)$'
```

## Review Culture

### For Authors
- **Self-review first**: Check your own PR before requesting review
- **Small PRs**: Keep changes focused and reviewable
- **Context**: Provide clear PR description and links to tickets
- **Responsiveness**: Address feedback promptly

### For Reviewers
- **Constructive feedback**: Focus on the code, not the person
- **Explain reasoning**: Help others understand the "why"
- **Acknowledge good practices**: Positive reinforcement
- **Timely reviews**: Don't let PRs sit for days

### Common Phrases
- "Consider..." for suggestions
- "What happens if..." for edge cases
- "Could we..." for alternative approaches
- "Nit: ..." for minor style issues

## Metrics and Tracking

### Review Health Indicators
- Average review turnaround time (< 24 hours)
- Number of review iterations per PR
- Percentage of PRs with critical issues caught
- Developer satisfaction with review process

### Review Templates

#### Quick Review Template
```
**Overall**: [Brief summary]

**🔴 Critical**: [List any critical issues]
**🟡 Major**: [List major issues]  
**🟢 Minor**: [List minor issues]

**Approval**: [Yes/No - with conditions if applicable]
```

#### Detailed Review Template
```
## Summary
[Brief description of changes and their impact]

## 🔴 Critical Issues
- [ ] Issue 1: [Description]
- [ ] Issue 2: [Description]

## 🟡 Major Issues  
- [ ] Issue 1: [Description]
- [ ] Issue 2: [Description]

## 🟢 Minor Issues
- [ ] Issue 1: [Description]
- [ ] Issue 2: [Description]

## Questions
- [ ] Question 1: [Description]
- [ ] Question 2: [Description]

## Suggestions
- [ ] Suggestion 1: [Description]
- [ ] Suggestion 2: [Description]
```