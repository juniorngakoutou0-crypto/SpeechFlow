# Naming Conventions by Language

## JavaScript/TypeScript

- **Variables/Functions**: camelCase (`getUserData`, `isValid`)
- **Classes/Components**: PascalCase (`UserProfile`, `DataService`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_RETRY_COUNT`, `API_BASE_URL`)
- **Private members**: prefix with `_` or use `#` (`_internalState`, `#privateMethod`)
- **Boolean variables**: Use is/has/can prefix (`isActive`, `hasPermission`, `canEdit`)
- **Event handlers**: Use handle/on prefix (`handleClick`, `onSubmit`)
- **React Components**: PascalCase files matching component name
- **Hooks**: Use 'use' prefix (`useAuth`, `useFetch`)

## Python

- **Variables/Functions**: snake_case (`get_user_data`, `is_valid`)
- **Classes**: PascalCase (`UserProfile`, `DataService`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_RETRY_COUNT`, `API_BASE_URL`)
- **Private members**: prefix with `_` (`_internal_state`)
- **Protected members**: single `_` prefix
- **Strongly private**: double `__` prefix
- **Boolean variables**: Use is/has/can prefix (`is_active`, `has_permission`)

## Java/C#

- **Variables/Methods**: camelCase (`getUserData`, `isValid`)
- **Classes/Interfaces**: PascalCase (`UserProfile`, `IDataService`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_RETRY_COUNT`)
- **Packages/Namespaces**: lowercase (`com.company.module`)
- **Boolean variables**: Use is/has/can prefix (`isActive`, `hasPermission`)
- **Interfaces**: Prefix with `I` in C# (`IRepository`)

## PHP

- **Variables/Functions**: camelCase or snake_case (framework-dependent)
- **Classes**: PascalCase (`UserController`, `ProductModel`)
- **Constants**: UPPER_SNAKE_CASE (`DB_HOST`, `MAX_ITEMS`)
- **Laravel**: snake_case for routes, table names, column names
- **Boolean variables**: Use is/has/can prefix

## Go

- **Variables/Functions**: camelCase or PascalCase (determines visibility)
- **Exported**: PascalCase (`UserService`, `GetData`)
- **Unexported**: camelCase (`internalHelper`, `validateInput`)
- **Constants**: PascalCase or UPPER_SNAKE_CASE
- **Interfaces**: Noun or adjective (`Reader`, `Closable`)

## Ruby

- **Variables/Methods**: snake_case (`get_user_data`, `is_valid?`)
- **Classes/Modules**: PascalCase (`UserProfile`, `DataService`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_RETRY_COUNT`)
- **Predicate methods**: End with `?` (`valid?`, `empty?`)
- **Dangerous methods**: End with `!` (`save!`, `destroy!`)
- **Instance variables**: Prefix with `@` (`@username`)
- **Class variables**: Prefix with `@@` (`@@count`)

## Rust

- **Variables/Functions**: snake_case (`get_user_data`, `is_valid`)
- **Types/Traits**: PascalCase (`UserProfile`, `DataService`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_RETRY_COUNT`)
- **Lifetimes**: Single lowercase letter with apostrophe (`'a`, `'static`)
- **Boolean functions**: Use is/has/can prefix

## General Principles

1. **Clarity over brevity**: `getUserById` > `getUsr`
2. **Avoid abbreviations**: Unless universally understood (HTTP, API, URL)
3. **Be consistent**: Same patterns throughout codebase
4. **Avoid magic numbers**: Use named constants
5. **Meaningful names**: Names should explain purpose without comments
6. **Avoid redundancy**: `UserClass` vs `User`, `getUserData()` in User class vs `getData()`
