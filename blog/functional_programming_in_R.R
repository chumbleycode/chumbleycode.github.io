#' ---
#' title: Functional programming (mostly from Hadley Wickham or Thomas Mailund)
#' output:
#'    html_document:
#'      toc: true
#'      highlight: zenburn
#' ---
#' <!-- rmarkdown::render("supervised_play/nice_code.R") -->
#' <!-- [See here.](http://brooksandrew.github.io/simpleblog/articles/render-reports-directly-from-R-scripts/) -->
#+ setup, eval=FALSE

#'# 0 Preface
#'
#'This is mostly not original, but harvested - often verbatum - from various
#'resources referenced throughout the below.
#'
#'R has map/reduce operations  on  multi-dimensional  arrays,  unhelpfully  all
#'called apply.
#'
#'Function generators: We can use higher order functions to generate
#'parameterised functions
#'
#'# 1. Functional
#' 
#' pure = based purely on lambda calculus.
#' Any language built purely on lambda calculus has one verb for expressing computations that can be evaluated: apply. We apply a function to an argument. Applying a function to an argument and potentially doing something with the result is all we can do, no matter what syntactic conveniences we construct to make it seem that we are doing more than that.  
#'only functions, never mutate in place, everything is an expression: no loops
#'or usual control flow. No side effects.
#'
#'[see here](https://www.youtube.com/watch?v=cTN1Qar4HSw)
#'
#'The lazy operation $&&$ is in most languages (even eagerly evaluated
#'languages)
#'
#' Call-by-name in conjunction with sharing (promises) = "lazy evaluation"
#' 
#' This seperates control from data: huge benefit of lazy evaluation. One function generates infinite data, the other controls
#' 
#' 
#'Lazily call by need (versus eagerly call by value).
#'
#'A function that is "strict" in an argument x if it actually does evaluate x (x
#'is needed and laziness ends).
#'
#'Some values never terminate when we evaluate them - e.g. haskell's bot. A
#'function is strict in an argument if supplying bot as that argument causes the
#'function to never terminate.
#'
  #' Laziness is usefull for infinite data.
#'
#'# 2. Pure functions
#'
#'Pure functions are desirable because they are easier to reason about. If a
#'function does not have any side effects, you can treat it as a black box that
#'just maps between values. If it has side effects, you will also need to know
#'how it modifies other parts of the program, and that means you have to
#'understand, at least at some level, what the body of the function is doing. If
#'all you need to know about a function is how it maps from input parameters to
#'results, you can change their implementation at any point without breaking any
#'code that relies on the functions.
#'
#'It is trivial to guarantee that you are not modifying something outside the
#'scope of a function. You need a special function, <<-, to modify variables
#'outside a function’s local scope, so avoid using that. Then all assignments
#'will be to local variables, and you cannot modify variables in other scopes.
#'If you avoid this operator, then the only risk you have of modifying functions
#'outside of your scope is through lazy evaluation. The functions contained
#'unevaluated - no force() used - expressions whose values depended on a
#'variable we were changing before we evaluated the expressions.
#'
#'A solution to avoid problems with functions depending on variables outside
#'their own scope, that is variables that are neither arguments nor local
#'variables, is to simply never change what a variable points to. Programming
#'languages that guarantee that functions are pure enforce this. There simply
#'isn’t any way to modify the value of a variable. You can define constants, but
#'there is no such things as variables. Since R does have variables, you will
#'have to avoid assigning to the same variable more than once if you want to
#'guarantee that your functions are pure in this way. It is very easy to
#'accidentally reuse a variable name in a long function, even if you never
#'intended to change the value of a variable. Keeping your functions short and
#'simple alleviates this somewhat, but there is no way to guarantee that it
#'doesn’t happen. The only control structure that actually forces you to change
#'variables is for loops. You simply cannot write a for loop without having a
#'variable to loop over.
#'
#'
#'The way functional programming languages avoid loops is by using recursion
#'instead. Anything you can write as a loop you can also write using recursive
#'function calls. Thinking of problems as recursive is not just a programming
#'trick for avoiding loops. It is generally a method of breaking problems into
#'simpler subproblems that are easier to solve.
#'
#'
#'# 3. Scope and closure
#'
#' closure to refer to a lambda expression whose open bindings (free variables) have been closed by (or bound in) the lexical environment, resulting in a closed expression, or closure
#'
#' A function returning a nested function with a free variable from the enclosing function
#' The nested function definitions are not themselves closures: they have a free variable which is not yet bound. Only once the enclosing function is evaluated with a value for the parameter is the free variable of the nested function bound, creating a closure, which is then returned from the enclosing function. 
#' 
#' a closure is only distinct from a function with free variables when outside of the scope of the non-local variables, otherwise the defining environment and the execution environment coincide and there is nothing to distinguish these.
#'
#' This is most often achieved by a function return, since the function must be defined within the scope of the non-local variables, in which case typically its own scope will be smaller. 
#' 
#' 

# Let
x = 3
f = function(x, y) function(x) x + y
# then
f(3)
# is a closure but not distinct

#' This is most often achieved by a function return, since the function must be defined within the scope of the non-local variables, in which case typically its own scope will be smaller. 
#' 
#'Scoping is an important way to keep your programs tidy. It involves limiting
#'the region of the program in which names ‘exist’ and can be used.
#'
#'Names are crucial for organizing and understanding programs. Yet names and
#'name binding get a second class treatment in programming language definition.
#'We have a fairly standardized approach based on context-free grammars to
#'provide tool independent descriptions of the syntax of programming languages.
#'There is no analog for describing the name binding rules of programming
#'languages. It is hard to explain the rules and they are encoded in many
#'different ways in implementations of programming language tools. Scope graphs,
#'a new approach to defining the name binding rules of programming languages. A
#'scope graph represents the name binding facts of a program using the basic
#'concepts of declarations and reference associated with scopes that are
#'connected by edges. Name resolution is defined by searching for paths from
#'references to declarations in a scope graph.
#'
#'Ideally a declarative representation for both syntax (AST) and name-resolution
#'(scope graphs - are language independent).
#'
#'Environment: function mapping names to values. Scope: function mapping an
#'expression to an environment? Because environments have well-determined
#'parents, i.e. a total order, they define a unique search path. Homonyms in
#'greater (further) environments of the scope are masked or shadowed (not
#'reachable in the scope graph). Inner (child) declarations shadow outer
#'(ancestral) declarations. Name resolution for type references (for strongly
#'typed languages?). How to define the name binding rules of a language, what is
#'it's BNF (Backus normal form).
#'
#'Want for name-binding what we have for syntax: a standard representation for
#'name resolution and declarative rules. From use of a symbol - in expression -
#'to it's literal definition. Scope graphs are the AST of name binding. Take the
#'AST of a program and map it to a scope graph. Given a scope graph, do name
#'resolution: finding a path from a reference to a declaration with the same
#'name. A calculus for name resolution, with 4 reachability rules.
#'
#'For more on scope graphs see
#'[here](https://pl.ewi.tudelft.nl/research/projects/scope-graphs/) and
#'[here](https://www.youtube.com/watch?v=0Eg6RDUJGJQ), and
#'[here](https://vjovanov.github.io/dsldi-summer-school/materials/monday/spoofax/ScopeGraphsLausanne.pdf).
#'![taken from the #'preceding link](scope_graph.png).
#'
#'These graphs encode encapsulation of nested scopes by abscent arrows.
#'
#'
#'In scope graph representation: there is no order for declarations *within* a
#'scope (c.f. sequential control flow).
#'
#'
#'Name binding: parser translates code into abstract syntax tree structure, but
#'program is actually a graph because we use symbolic names to refer from one
#'part of a program to another. Deeply nested scopes: in which scope is a
#'variable defined.
#'
#'A quoted expression, not a call, does not carry its own environment along with
#'it.
#'
#'Lexical scoping: building up chains of scopes. Seach from outer (nested,
#'child) to inner scopes (top level). Declarations in inner (local/nested/child)
#'scopes are not-accessible by outer scopes (lexical parents), they are
#'encapsulated. Child scope is a sub-scope of parent-scope, which is a sub-scope
#'of grandparent scope, etc. Query graph (i.e. a reference) to the declaration
#'of interest. Nested/child scopes have more specificity than there ancestors.
#'
#'Another typical phenomenon in name-binding, is modules and imports. Modules
#'encapsulate declarations but they can be revealed to other modules on request
#'(i.e. imports). Import: reveal *all* the declarations for one scope into
#'another scope (all one module into another), c.f. qualified names: specify
#'
#'Local (inner) execution environment. Functions, when called, will always chain
#'their local environment to the environment in which they were defined.
#'functions defined in the global environment will be chained to that
#'environment and functions defined in other environments will be chained to
#'those.
#'
#'All functions have an associated environment they will chain their local
#'environments to. Call objects are delayed/captured function calls, so they
#'behave in much the same way.
#'
#'Anonymous scopes and anonymous functions?
#'
#'R has an explicit representation of environments but only an implicit
#'representation of scopes; scopes are defined by the algorithm R uses to figure
#'out which actual variable a variable name is referring to.
#'
#'Just as operator precedence/priority/order and a default (say left)
#'associativity resolve evaluation ambiguity in expressions, the scope of the
#'expression is a precedence or partial order of environments - e.g. depicted as
#'a DAG - that resolves ambiguity in the evaluation of constants (syntactic
#'literals) in the expression.
#'
#'Scopes for unique evaluation of symbols. Variable names - say x - are unique
#'inside but not unique across environments. It is legal to have the same symbol
#'in multiple environments, pointing to different values.
#'
#'The scope of a variable name, say x, or an expression.
#'
#'Quoted expressions - not a call expression - have no scope for evaluation.
#'
#'Namespace: distinguish functions from variables.
#'
#'The function eval() in R sets the scope for evaluating an expression.
#'
#'Two references/symbols x and y may both have local scope, global scope or a
#'combination.
#'
#'Scopes are not static. They always depend on the environment chain which
#'expressions are evaluated in and what these environments look like at the time
#'the expressions are evaluated.
#'
#'Evaluate an expression in an "environment chain" or "scope graph".
#'
#'Build a scope graph by nested function execution (i.e. higher-order
#'functions): Take the function-valued function h1 <- g(2). If we now call h1,
#'we will create an environment chain that first has its local environment
#'(execuction), then the environment created when h1 was defined (the
#'immortalized execution environment of the call g(2) together with all *it's*
#'local variables), and then the global environment. What Thomas Mailund calls
#'the "environment chain graph" is more generally encoded by the "scope graph"
#'of Eelco Visser.
#'
#'The rules for how variables are mapped to values are always the same. It
#'involves a search in the chain of environments that are active at the time the
#'expression is evaluated. The only difficulty is knowing which environments are
#'in the chain at any given time. Here the rules are not that complex either. We
#'can explicitly create an environment and give it priority in the chain of
#'environments using eval(), we can create a call environment when we pass
#'expressions as arguments to a function—where the environment will be the same
#'environment chain as where we call the function—or we can create a new
#'environment by running code inside a function.
#'
#'A function remembers the environment where it was declared/defined/created
#'(synonyms?) not where it was called (although it uses that to evaluate
#'parameters passed). Functions that remember an environment from a previous
#'function instantiation that is no longer active. Because functions in R recall
#'the environment where they were created, the only thing that is required for a
#'function to be a closure is that we return it from a function call. A function
#'that creates a closure is thus a higher-order function, and where closures are
#'used is with higher-order functions that take functions as input.
#'
#'Quoted expressions do not refer to variables, they just contain free variable
#'names.
#'
#'For static/lexical scoping you can in principle, figure out what variables in
#'an expression are defined where. You first check if the variables are set in
#'the local environment, so either local variables or function parameters. If
#'not, then you look at the enclosing code and check if the variable is in the
#'environment. The enclosing code can be the global environment or a function.
#'If it is a function and the variables are not defined there, you work your way
#'further out in the code where the function is defined. If the mapping from
#'variables to values depended on where a function was called rather than where
#'it was defined, something called dynamic scope, you couldn’t figure out which
#'variables the variable names were referring to just from reading the code
#'where the function is defined.
#'
#'Dynamic scope: find variables based on which functions are on the call stack,
#'not which functions are lexically enclosing the place where we define them.
#'
#'Closures (enclosing scope functions): functions which remember the - otherwise
#'transient, execution - environment of another function invocation. They
#'remember the execution environment they were enclosed in when they were
#'created/declared.
#'
#'
#'# 4. Higher order functions
#'
#'Higher-order functions - like map - can replace looping control structures
#'(the only control structure which violates mutability, by definition).
#'Closures can be particularly useful in combination with map (or apply)
#'functions if we need to pass some information along to the function.
#'
#'## Currying
#'
#'f <- function(x, y) x + y
#'
#'h <- function(x) function(y) f(x, y)
#'
#'These do the same thing, but differ in how parameters are passed. Function f
#'needs both parameters at once, while function h takes one parameter at a time.
#'
#'A function such as h, one that takes a sequence of parameters not in a single
#'function call but through a sequence of function calls, each taking a single
#'parameter and returning a new function, is known as a curried function.
#'
#'More generally, a function for currying 2 parameter functions is
curry2 <- function(f) function(x) function(y) f(x, y)
func <- function(a, b) a * b
rlang::env_print(curry2(func)(1))

purrr::map(1:4, curry2(`+`)(2))

#' the return value needs to be called first with parameter x and then with
#' parameter y and then it will return the value f(x, y). The name of the
#' variables do not matter here, they are just names and need not correspond
#' with the names of the variables that f actually takes. Using this function,
#' we can automatically create h from f:
#' 

h <- curry2(`+`)
h(2)(3)

# lazy evaluation
curry3 <- function(f) function(x) function(y) function(z) f(x, y, z)
my_func = function(a,b,c) a+b*c
curry3(my_func)(x = 1)(y = 2)(z = 3)

# eager evaluation
curry3 <- function(f){
  force(f)
  function(x){
    force(x)
    function(y){
      force(y)
      function(z) {
        force(z)
        f(x, y, z)
      }
    }
  }
}

curry3(my_func)
curry3(my_func)(1)
curry3(my_func)(1)(3)
curry3(my_func)(1)(3)

a = curry3(my_func)
b = a(3)
c = b(4)
d = c(4)
d
rlang::env_parents(environment(c))
environment(b) # confirm: the above lists the hierarchy of enclosing environments of the inner-most, local child
environment(a)

#' The most general currying function follows. The trick we use is to create a
#' chain of functions where each function returns the next function that should
#' be called, the continuation.

curry <- function(f) {
  n <- length(formals(f))
  if (n == 1) return(f) # no currying needed
  arguments <- vector("list", length = n) 
  
  last <- function(x) {
    
    arguments[n] <<- x
    do.call(f, arguments) 
    
  }
  
  make_i <- function(i, continuation) { 
    
    force(i) # forced/active/eager evaluation vs. default lazy
    force(continuation)  
    
    function(x) {
      arguments[i] <<- x
      continuation
    }
  }
  
  browser()
  continuation <- last
  
  for (i in seq(n-1, 1)) {
    continuation <- make_i(i, continuation) 
  }
  
  continuation
}

#' for example
#' 
#' 
f <- function(x, y, z) x + 2*y + 3*z
f(1, 2, 3)
curry(f)(1)(2)(3)

#'# Continuations Allow you to control control flow. Emulate any known control
#'construct, e.g. you can mimmic exceptions, loops.
#'
#'This idea of having the remainder of a computation as a function you can
#'eventually call can be used in many other problems. Consider the simple task
#'of adding all elements in a list.
#'
#'The continuation (what next) of the expression $(2 \times 3) + 4$ with respect
#'to $2 \times 3$ is $f(x) = x + 5$. In code, function(x) x + 5.
#'
#'Partial binding functions - like purrr:partial() - aren’t used that often in
#'R. It is just as easy to write closures to bind parameters and those are
#'usually easier to read, so use partial bindings with caution.
#'
#'Thunk:
#'
#'A thunk is a subroutine used to inject an additional calculation into another
#'subroutine. Thunks are primarily used to delay evaluation.
#'
#'thunks and trampolines can be combined to avoid recursion. instead of calling
#'recursively, we want each recursive call to create a thunk instead. This will
#'create a thunk that does the next step and returns a thunk for the step after
#'that, but it will not call the next step, so no recursion. We need such thunks
#'both for the recursions and the continuations. The implementation is simple,
#'we just replace the recursions with calls to make_thunk.

x = 5
f <- function(x) {
  x*2
}
f(x * 2)

x = 5
f <- function(x) {
  g <- function(y){
    x*2 + y
  }
  g(1)
}
f(x * 2)

#' 5. filter (keep in purrrr), map and reduce
#'
#' Three general methods that are used in functional programming instead of
#' loops and instead of explicitly writing recursive functions. These are three
#' different patterns for computing on sequences - sequences come in two flavors
#' in R: vectors and lists - replace for loops where you how much you are
#' looping over (not while or repeat loops).
#'
#' The three functions are often used together, where Filter first gets rid of
#' elements that should not be processed, then Map processes the list, and
#' finally Reduce combines all the results.
#'
#' The apply function works on matrices and higher-dimensional arrays instead of
#' sequences.
#'
#' 6. Point-free programming
#'
#' The output (point = intermediate state of data) of one program becomes the
#' input for the next in the pipeline, and you never refer to the intermediate
#' data. The simplest way to construct new functions from basic ones is through
#' function composition. Function composition is associative, we don’t need to
#' worry about the order in which they are composed.
#'
#' Composing functions to define new functions $\f \circ g$ (point free form),
#' rather than defining functions that just explicitly call others $f(g(x))$.
#' 
compose <- function(g, f) function(...) g(f(...))

#' pure functions: take all their inputs as explicit arguments and produce all
#' their outputs as explicit values/results. Thus R is impure because everything
#' is an object defined elsewhere, even control flow.
#'
#' overloading is when you give multiple definitions for a function with the
#' same name (but different input types).
#'
#'
#' The category laws. These laws differentiate category theory from other design
#' patterns by providing rigorous criteria for what does and does not qualify as
#' compositional.
#'
#' introducing the category as a compositional design pattern from a
#' programmer's point of view a category is just a compositional design pattern.
#' The associativity law and the two identity laws are known as the category
#' laws.
#'
#' composition operator $\cdot$, id objects, and other objects.
#'
#' Function composition is very easy to use, yet so powerful, precisely because
#' it forms a category!
#'
#' The next most common category we encounter on a daily basis is the category
#' of monadic functions, which generalize ordinary functions:
#'
#' Monadic functions just generalize ordinary functions and the Kleisli category
#' demonstrates that monadic functions are composable, too. They just use a
#' different composition operator: (<=<), and a different identity: return.
#' monad laws are just the category laws in disguise.
#'
#' I'm really glad to see a resurgence in functional programming (since
#' functions form a category),
#'
#' A functor transforms one category into another category. In the previous
#' section we transformed the category of Haskell functions into the category of
#' monadic functions and that transformation is our functor.
#'
#'
#' Then a functor uses a function that we will call map to convert every
#' component in the source category into a component in the destination
#' category. We expect this map function to satisfy two rules:
#'
#' Rule #1: map must transform the composition operator in the source category
#' to the composition operator in the destination category:
#'
#' map (f ._A g) = map f ._B map g
#'
#' This is the "composition law". Preserves composition.
#'
#' Rule #2: map must transform the identity in the source category to the
#' identity in the destination category:
#'
#' map idA = idB
#'
#' This is the "identity law". Preserves identity.
#'
#' In other words, functors serve as adapters between categories that promote
#' code written for the source category to be automatically compatible with the
#' destination category. Functors arise every time we write compatibility layers
#' and adapters between different pieces of software. Together these two rules
#' are the "functor laws" (technically, the covariant functor laws).
#'
#'
#' A lot of new Haskell programmers mistakenly believe that functors only
#' encompass "container-ish" things and I hope the previous examples dispel that
#' notion.
#'
#'
#' However, the Functor class still behaves the same way as the functors I've
#' already discussed. The only restriction is that the Functor class only
#' encompass the narrow case where the source and target categories are both
#' categories of ordinary functions:
#'
#' Functors recapitulate the themes of compatibility between categories and
#' component reuse. For example, we might have several ordinary functions lying
#' around in our toolbox:
#'
#'
#' map :: (a -> b) -> ([a] -> [b])
#'
#' map f :: [a] -> [b]
#'
#' map g :: [b] -> [c]
#'
#' h = map f . map g :: [a] -> [c]
#'
#' We know that we can combine two passes over a list into a single pass:
#'
#' h = map (f . g) :: [a] -> [c]
#'
#'
#' .. and doing nothing to each element does nothing to the list:
#'
#' map id = id
#'
#' Once again, we've just stated the functor laws:
#'
#' map (f . g) = map f . map g  -- Composition law
#'
#' map id = id                  -- Identity law
#'
#'
#' The process of interpreting code by substituting equals-for-equals is known
#' as equational reasoning.
#'
#' Haskell has a very straightforward way to interpret all code: substitution
#'
#' Unlike imperative languages, there are no extra language statements such as
#' for or break that we need to understand in order to interpret our code. Our
#' printing "loop" that repeated three times was just a bunch of ordinary
#' Haskell code. This is a common theme in Haskell: "language features" are
#' usually ordinary libraries.
#'
#' Functional programming is a style of programming in which function calls,
#' rather than a series of instructions for the computer to execute, are the
#' primary constructs of your program
