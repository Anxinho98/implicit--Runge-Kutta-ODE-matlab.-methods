# Implicit Runge-Kutta Method (RKI)

This repository contains a MATLAB implementation of two Implicit Runge-Kutta methods, one of which is diagonally implicit. Both are designed to compute numerical approximations to the solutions of ordinary differential equations (ODEs), for both scalar and system cases.

## Method Description

The implemented methods are suitable for Butcher tableaux that are not lower triangular, which requires solving implicit systems at each step. These systems are solved using a fixed maximum number of iterations and numerical solvers such as `fsolve`.

Both variants:
- Support solving vector-valued ODEs.
- Compute the approximation error at each step by comparing with the exact solution if available.
- Generate plots of both the exact and numerical solutions.

## Usefulness

Ordinary differential equations arise in many disciplines such as physics, engineering, biology, and social sciences. These methods provide robust tools for solving problems where numerical stability is essential, especially in stiff problems or when precise error control is required.
