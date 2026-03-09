"""
calculator.py

A simple calculator module for the Copilot CLI demo.

Use this file to demonstrate:
  - /test  : Ask Copilot to generate a comprehensive pytest test suite
  - /explain : Ask Copilot to explain any function
  - /fix   : Intentional edge case gaps for Copilot to spot

Run existing tests (after Copilot generates them):
  pytest test_calculator.py -v
"""


def add(a, b):
    """Return the sum of a and b."""
    return a + b


def subtract(a, b):
    """Return a minus b."""
    return a - b


def multiply(a, b):
    """Return the product of a and b."""
    return a * b


def divide(a, b):
    """
    Return a divided by b.

    Raises:
        ValueError: If b is zero.
    """
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b


def power(base, exponent):
    """
    Return base raised to the power of exponent.

    Supports integer and float exponents, including negative values.
    """
    return base ** exponent


def square_root(n):
    """
    Return the square root of n.

    Raises:
        ValueError: If n is negative.
    """
    if n < 0:
        raise ValueError(f"Cannot compute square root of negative number: {n}")
    return n ** 0.5


def factorial(n):
    """
    Return n! (n factorial).

    Args:
        n: A non-negative integer.

    Raises:
        ValueError: If n is negative or not an integer.
    """
    if not isinstance(n, int):
        raise ValueError(f"Factorial requires a non-negative integer, got: {type(n).__name__}")
    if n < 0:
        raise ValueError(f"Factorial is not defined for negative numbers: {n}")
    if n == 0:
        return 1
    result = 1
    for i in range(1, n + 1):
        result *= i
    return result


def percentage(value, total):
    """
    Return what percentage 'value' is of 'total'.

    Example:
        percentage(25, 200) -> 12.5

    Raises:
        ValueError: If total is zero.
    """
    if total == 0:
        raise ValueError("Total cannot be zero when computing percentage")
    return (value / total) * 100


def clamp(value, minimum, maximum):
    """
    Clamp a value so it falls within [minimum, maximum].

    Returns:
        minimum if value < minimum,
        maximum if value > maximum,
        otherwise value.
    """
    if minimum > maximum:
        raise ValueError(f"minimum ({minimum}) must not exceed maximum ({maximum})")
    return max(minimum, min(value, maximum))


if __name__ == "__main__":
    print("Calculator Demo")
    print(f"  add(3, 5)           = {add(3, 5)}")
    print(f"  subtract(10, 4)     = {subtract(10, 4)}")
    print(f"  multiply(6, 7)      = {multiply(6, 7)}")
    print(f"  divide(15, 4)       = {divide(15, 4)}")
    print(f"  power(2, 10)        = {power(2, 10)}")
    print(f"  square_root(144)    = {square_root(144)}")
    print(f"  factorial(6)        = {factorial(6)}")
    print(f"  percentage(50, 200) = {percentage(50, 200)}")
    print(f"  clamp(15, 0, 10)    = {clamp(15, 0, 10)}")
