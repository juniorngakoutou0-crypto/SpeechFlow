# Code Smells Detection Guide

## Naming Issues

### Vague Names
- Single letter variables (except loop counters: i, j, k)
- Generic names: `data`, `temp`, `value`, `item`, `obj`
- Non-descriptive: `doStuff()`, `process()`, `handle()`

### Inconsistent Naming
- Mixed conventions: `getUserData()` and `get_user_email()`
- Inconsistent prefixes: `isActive` and `activeFlag`
- Plural/singular confusion: `users.getUser()` vs `user.getData()`

## Structural Issues

### Code Duplication
- Identical or very similar code blocks (>3 lines)
- Copy-pasted functions with minor variations
- Repeated logic patterns

### Long Functions
- Functions >50 lines (guideline, not absolute)
- Multiple levels of nesting (>3 levels)
- Multiple responsibilities

### Long Parameter Lists
- Functions with >4 parameters
- Consider parameter objects or builder pattern

### Large Classes
- Classes with >10 methods
- Classes with >500 lines
- Multiple responsibilities (SRP violation)

## Logic Issues

### Deep Nesting
```javascript
// Bad
if (a) {
  if (b) {
    if (c) {
      if (d) {
        // code
      }
    }
  }
}

// Good: Early returns
if (!a) return;
if (!b) return;
if (!c) return;
if (!d) return;
// code
```

### Complex Conditionals
```javascript
// Bad
if ((user.age > 18 && user.country === 'US') || (user.age > 21 && user.country === 'CA'))

// Good
const isUSAdult = user.age > 18 && user.country === 'US';
const isCAAdult = user.age > 21 && user.country === 'CA';
if (isUSAdult || isCAAdult)
```

### Magic Numbers
```javascript
// Bad
if (status === 200) { }

// Good
const HTTP_OK = 200;
if (status === HTTP_OK) { }
```

## Design Issues

### God Objects
- Classes that know/do too much
- Excessive dependencies
- Hard to test

### Feature Envy
- Methods that use more data from other classes than their own
- Suggests method should be moved

### Primitive Obsession
- Using primitives instead of small objects
- Example: Passing separate `street`, `city`, `zip` instead of `Address` object

### Switch/Conditional Chains
- Long switch statements or if-else chains
- Consider polymorphism or strategy pattern

## Coupling Issues

### Tight Coupling
- Classes with excessive dependencies
- Hard-coded dependencies
- Circular dependencies

### Law of Demeter Violations
```javascript
// Bad: Train wreck
user.getAddress().getCity().getName()

// Good
user.getCityName()
```

## Comment Smells

### Commented-Out Code
- Remove dead code, use version control

### Obvious Comments
```javascript
// Bad
i++; // increment i

// Good: Only comment WHY, not WHAT
i++; // Skip header row
```

### Outdated Comments
- Comments contradicting code
- Comments describing old implementation

## Performance Anti-Patterns

### Premature Optimization
- Overly complex code for negligible gains
- Optimize after measuring

### N+1 Queries
- Database query in loop
- Use batch loading or joins

### Memory Leaks
- Event listeners not removed
- Circular references in closures
- Growing caches without limits

## Testing Issues

### Untestable Code
- Static dependencies
- Hidden dependencies
- Side effects in constructors

### Missing Error Handling
- Bare try-catch blocks
- Swallowed exceptions
- No validation

## File Organization Issues

### Misplaced Files
- Business logic in UI components
- Data access in domain models
- Mixed concerns in single file

### Circular Dependencies
- Module A imports B, B imports A
- Indicates architectural problem

### Mega Files
- Files >500 lines
- Multiple unrelated exports
- Should be split by responsibility
