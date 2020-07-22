In computer science, an operation, function or expression is said to have a side effect if it modifies some state variable value(s) outside its local environment, that is to say has an observable effect besides returning a value (the main effect) to the invoker of the operation. State data updated "outside" of the operation may be maintained "inside" a stateful object or a wider stateful system within which the operation is performed. Example side effects include modifying a non-local variable, modifying a static local variable, modifying a mutable argument passed by reference, performing I/O or calling other side-effect functions

In the presence of side effects, a program's behaviour may depend on history; that is, the order of evaluation matters. Understanding and debugging a function with side effects requires knowledge about the context and its possible histories.

The degree to which side effects are used depends on the programming paradigm. Imperative programming is commonly used to produce side effects, to update a system's state. By contrast, Declarative programming is commonly used to report on the state of system, without side effects. 

In functional programming, side effects are rarely used. The lack of side effects makes it easier to do formal verifications of a program. Functional languages such as Standard ML, Scheme and Scala do not restrict side effects, but it is customary for programmers to avoid them.[4] The functional language Haskell expresses side effects such as I/O and other stateful computations using monadic actions.

# referential transparency
Absence of side effects is a necessary, but not sufficient, condition for referential transparency. Referential transparency means that an expression (such as a function call) can be replaced with its value. This requires that the expression is pure, that is to say the expression must be deterministic (always give the same value for the same input) and side-effect free. 
