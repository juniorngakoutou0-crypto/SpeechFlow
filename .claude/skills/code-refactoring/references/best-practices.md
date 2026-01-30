# Best Practices by Technology

## JavaScript/TypeScript

### General
- Use `const` by default, `let` when reassignment needed, avoid `var`
- Prefer arrow functions for callbacks and methods
- Use template literals over string concatenation
- Destructure objects and arrays for cleaner code
- Use optional chaining (`?.`) and nullish coalescing (`??`)
- Prefer async/await over promise chains

### React
- Functional components over class components
- Use hooks (useState, useEffect, useCallback, useMemo) appropriately
- Keep components small and focused (Single Responsibility)
- Extract reusable logic into custom hooks
- Avoid prop drilling - use Context or state management
- Memoize expensive computations with useMemo
- Prevent unnecessary re-renders with React.memo and useCallback
- Colocate state close to where it's used

### Node.js
- Use environment variables for configuration
- Implement proper error handling (try-catch, error middleware)
- Use async/await consistently
- Implement logging (Winston, Pino)
- Use dependency injection for testability
- Validate input data (Joi, Zod, Yup)

## Python

### General
- Follow PEP 8 style guide
- Use type hints for better code clarity
- Use list/dict comprehensions when appropriate
- Context managers (`with`) for resource management
- Use `pathlib` instead of `os.path`
- Prefer `enumerate()` over manual indexing
- Use `f-strings` for string formatting

### Django/Flask
- Keep views thin, logic in services/models
- Use Django ORM efficiently (select_related, prefetch_related)
- Implement proper serialization (Django REST Framework)
- Use middleware for cross-cutting concerns
- Implement proper authentication and authorization
- Database migrations version controlled

### Data Science
- Use vectorized operations (NumPy, Pandas)
- Avoid loops when possible
- Document data transformations
- Version control notebooks and data
- Use type hints with data structures

## Java

### General
- Use interfaces for abstraction
- Follow SOLID principles
- Use dependency injection (Spring)
- Prefer immutability when possible
- Use Optional instead of null checks
- Implement proper exception handling
- Use streams for collection operations

### Spring Boot
- Use constructor injection over field injection
- Implement DTOs for API responses
- Use proper validation annotations
- Implement proper logging
- Use profiles for different environments
- Keep controllers thin, logic in services

## PHP

### General
- Use strict types: `declare(strict_types=1)`
- Type hint all parameters and return types
- Use PSR standards (PSR-1, PSR-12)
- Avoid global state
- Use dependency injection
- Implement proper error handling

### Laravel
- Follow Laravel conventions
- Use Eloquent relationships properly
- Implement service classes for business logic
- Use Form Requests for validation
- Implement Jobs for background tasks
- Use Laravel's built-in features (Cache, Queue, Events)

## Go

### General
- Handle errors explicitly, don't ignore
- Use `defer` for cleanup operations
- Prefer composition over inheritance
- Use interfaces for abstraction
- Keep packages focused and cohesive
- Use context for cancellation and timeouts
- Avoid global state

### Best Patterns
- Return errors, don't panic (except in init)
- Use `errgroup` for concurrent error handling
- Implement proper graceful shutdown
- Use table-driven tests
- Document exported functions and types

## Database

### SQL
- Use parameterized queries (prevent SQL injection)
- Create proper indexes for query performance
- Normalize data (3NF) unless specific reason not to
- Use foreign keys for referential integrity
- Implement proper transactions
- Use connection pooling

### NoSQL
- Design schema for query patterns
- Avoid deeply nested documents (MongoDB)
- Implement proper indexing
- Use aggregation pipelines efficiently
- Consider data duplication for read performance

## Git

### Commits
- Write meaningful commit messages
- Keep commits atomic (one logical change)
- Use conventional commits format
- Don't commit sensitive data
- Don't commit generated files

### Branches
- Use feature branches
- Keep branches short-lived
- Rebase before merge for clean history
- Delete merged branches

## Testing

### Unit Tests
- Test behavior, not implementation
- Use AAA pattern (Arrange, Act, Assert)
- One assertion per test (when possible)
- Mock external dependencies
- Use descriptive test names

### Integration Tests
- Test critical user flows
- Use test databases/environments
- Clean up test data
- Test error scenarios

## Security

### Input Validation
- Validate all user input
- Sanitize data before output
- Use parameterized queries
- Implement rate limiting
- Use HTTPS everywhere

### Authentication & Authorization
- Use established libraries (Passport, JWT)
- Hash passwords (bcrypt, argon2)
- Implement proper session management
- Use role-based access control
- Implement CSRF protection

### Data Protection
- Encrypt sensitive data at rest
- Use environment variables for secrets
- Implement proper logging (no sensitive data)
- Regular dependency updates
- Use security headers

## Performance

### Frontend
- Lazy load components and routes
- Optimize images (WebP, compression)
- Minimize bundle size (code splitting)
- Use CDN for static assets
- Implement caching strategies
- Debounce/throttle expensive operations

### Backend
- Implement caching (Redis, Memcached)
- Use database indexing
- Optimize database queries
- Implement pagination
- Use asynchronous processing for heavy tasks
- Monitor performance (APM tools)

## Code Organization

### Folder Structure
- Group by feature, not by type
- Separate concerns (business logic, data access, presentation)
- Keep related files close together
- Use index files for clean imports
- Implement consistent naming across project

### Dependencies
- Keep dependencies up to date
- Audit for security vulnerabilities
- Minimize dependency count
- Use lock files (package-lock.json, poetry.lock)
- Document why dependencies are needed
