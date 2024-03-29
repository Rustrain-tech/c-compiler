#!/bin/bash
assert() {
  expected="$1"
  input="$2"

  ./9cc "$input" > tmp.s
  gcc -o tmp tmp.s
  ./tmp
  actual="$?"

  if [ "$actual" = "$expected" ]; then
    echo "$input => $actual"
  else
    echo "$input => $expected expected, but got $actual"
    exit 1
  fi
}

assert 0 "0"
assert 42 "42"
assert 21 "5+20-4"
assert 41 " 12 + 34 - 5 "
assert 6 "2 * 3"
assert 3 "9 / 3"
assert 15 "5 * (9 - 6)"
assert 4 "(3 + 5) / 2"
assert 17 "((3 + 4) * 5) / 2"
assert 4 "-4 + 8"

echo OK