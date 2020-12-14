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

#' Imperative programs: the basic computation is changing stored values
#' Functional programs: the basic computation is application of function to argument
#' 
#' 
#'Haskell
#'
#'
#'functional programming is a subset of a more important overarching programming
#'paradigm: compositional programming.
#'
#'
#'Category theory codifies this compositional style into a design pattern, the
#'category. Moreover, category theory gives us a precise prescription for how to
#'create our own abstractions that follow this design pattern: the category
#'laws. These laws differentiate category theory from other design patterns by
#'providing rigorous criteria for what does and does not qualify as
#'compositional.
#'
#'
#'The associativity law and the two identity laws are known as the category
#'laws.
#'
#'Notice that the definition of a category does not define: what (.) is, what id
#'is, or what f, g, and h might be. Instead, category theory leaves it up to us
#'to discover what they might be.
#'
#'
#'The brilliance behind the category design pattern is that any composition
#'operator that observes these laws will be: easy to use, intuitive, and free
#'from edge cases. This is why we try to formulate abstractions in terms of the
#'category design pattern whenever possible.
#'
#'![http://www.haskellforall.com/2012/08/the-category-design-pattern.html]
#'
#'Function composition is very easy to use, yet so powerful, precisely because
#'it forms a category! This lets us express complex transformations simply by
#'composing a bunch of reusable parts: 
#'
#' Unfortunately, we can't express all of our programs as chains of ordinary functions. I guess we just give up, right? Wrong!
#' 
#'  All category theory says is that composition is the best design pattern, but then leaves it up to you to define what precisely composition is. It's up to you to discover new and interesting ways to compose things besides just composing functions. As long as the composition operator you define obeys the category laws, you're golden.
#' 
#'  
  #' :: operator means: name of the left has
#'type on the right
#'
#'used for declarations, and to disambiguate expressions so compiler knows your
#'prefered return type
#'
#'a type represents a collection of values. For example, the Bool type has two
#'values: True and False, but the Char type has many more. The purpose of types
#'is to avoid bugs: to make sure that no part of the program receives something
#'it was not expecting, and for which it cannot sensibly do anything.
#'
#'a typeclass is a collection of types, each of which is a collection of values
#'
#'Of course, many types do not have a $\implies$ symbol, which means either they
#'are very specific, like Bool, or very generic, like a, which represents any
#'type at all.
#'
#'We can have more than one constraint on a single type variable, or constraints
#'on multiple type variables. They are each called class constraints, and the
#'whole left hand part is sometimes called the context.
#'
#'Just by looking at the type signature (for abscence of type IO), a programmer
#'can conclude that f does not interact with the file system, the network, or
#'the user. This means that the function f is referentially transparent, i.e.,
#'an occurrence of f in the code is equivalent to its result. referentially
#'transparent: an occurrence of f in the code is equivalent to its result.
#'
#'In Scala, writing referentially transparent functions is encouraged as a best
#'practice, but it is not evident, without reading the actual code, whether a
#'given function has side effects or not. In Haskell, referential transparency
#'is enforced by the type system, which not only gives important information to
#'the programmer, but also allows for optimizations in the form of rewrite
#'rules.
#'
#'Currying provides a way for working with functions that take multiple
#'arguments, and using them in frameworks where functions might take only one
#'argument. For example, some analytical techniques can only be applied to
#'functions with a single argument. Practical functions frequently take more
#'arguments than this. Frege showed that it was sufficient to provide solutions
#'for the single argument case, as it was possible to transform a function with
#'multiple arguments into a chain of single-argument functions instead. This
#'transformation is the process now known as currying.[8] All "ordinary"
#'functions that might typically be encountered in mathematical analysis or in
#'computer programming can be curried. However, there are categories in which
#'currying is not possible; the most general categories which allow currying are
#'the closed monoidal categories.
#'
#'Some programming languages almost always use curried functions to achieve
#'multiple arguments; notable examples are ML and Haskell, where in both cases
#'all functions have exactly one argument. This property is inherited from
#'lambda calculus, where multi-argument functions are usually represented in
#'curried form.
#'
#'Currying is related to, but not the same as partial application. In practice,
#'the programming technique of closures can be used to perform partial
#'application and a kind of currying, by hiding arguments in an environment that
#'travels with the curried function.
#'
#'In practice, the programming technique of closures can be used to perform
#'partial application and a kind of currying, by hiding arguments in an
#'environment that travels with the curried function.
#'
#'Currying on [wiki](https://en.wikipedia.org/wiki/Currying)
#'
#'Composition $\circ$ can create new functions from old, without $\lambda$'s or
#'declaring functions explicitly.
#'
#'type aliases
#'
#'# Lambda *expressions*
#'
#'Named expression: sum = 2+2 Anonymous lambda expressions:
#'
#'Grouping: arrow to the right, application left:
#'
#'The arrow operator takes two types a,b and gives the type of a function with
#'arguments a and b.
#'
#'An application $e_1 e_2$ applies function $e_1$ to arg $e_2$
#'
#'Note that for both types and applications, a function has only one argument
#'
#'Parametric polymorphism ($\to$): A polymorphic type that can be instantiated
#'to *any* type. Represented by a type variable, conventionally, a,b,c etc.
#'
#'Type classes restrict a polymorphism. If there exists a type upon which it is
#'impossible to apply your function you need a type class.
#'
#'# Lambda calculus
#'
#'lambda calculus was an attempt to formalise functions as a means of computing.
#'
#'The lambda calculus has turned out to capture two aspects of a function:
#'
#'A mathematical object (set of ordered pairs from domain and range), and
#'
#'An abstract black box machine that takes an input and produces an output.
#'
#'The lambda calculus is fundamental to denotational semantics, the mathematical
#'theory of what computer programs mean.
#'
#'Syntax of lambda functions: constants, variables, applications, and functions.
#'
#'Being free or bound is a property of an occurrence of a variable, not of the
#'variable itself! Here, only the first 'a' is free:  a + (\ a -> 2^a) 3
#'
#'
#'Computing in the lambda calculus is performed using three conversion rules.
#'
#'The conversion rules allow you to replace an expression by another (“equal”)
#'one.
#'
#'Some conversions simplify an expression; these are called reductions.

#' In general, an occurrence of a variable is bound if there is some enclosing lambda expression that binds it; if there is no lambda binding, then the occurrence if free.
#' 
#' Ad hoc polymorphism ($\implies$): A polymorphic type realized to any type in a given type class, e.g. $(+) :: Num \ a \implies a \to a \to a$.
#' 
#'  $(+) ::  a \to a \to a$ is not ok because we want to restrict addition to numbers
#' 
#' 
#' Partial application: the *binary* operation $*$ partially applied to *one* (the right) operand. 
#' 
#' Rewrite a multi-ary function into a sequence of unary functions.
#' 
#' map (*2) [1..10]
#' 
#' Haskell's type inference (versus R's type coercion)
#' 
#' Type classes are a way to overload functions or operators by putting constraints on polymorphism.
#' 
#' 
#' Monads allow sequencing of function calls via the type system (result of one is input for another). Monad allows chaining. It is a computational pattern.
#' 
#'  Maybe monad.
#'  IO monad. 
#'  
#'  # Haskell from the ground up
#'  
#'## Ch. 1
#'
#' An expression is any valid Haskell program. To produce an answer, Haskell evaluates the expression, yielding a special sort of expression, a value
#' 
#' define our own name to stand for the expression
#' 
#' An expression always has same type as the value it will evaluate to
#' 
#' 50 :: Num a $\implies$ a
#' 
#' “if a is one of the types of number, then 50 can have type a”. 
#' 
#' The type of the expression cube 200, cube 200 :: Num a $\implies$ a
#' 
#' Haskell has a nicer way of expressing choices than if-then-else expressions – pattern matching. For example, recall our factorial function:
#' 
#' 
#' factorial :: (Eq a,Num a )⇒a→a
#' 
#' factorial 1 = 1
#' 
#' factorial n = n * factorial (n - 1)
#' 
#' 
#' The cases of guarded equations are considered one after another, just like when using pattern matching.
#' We can read the | symbol as “when”.
#' 
#' Haskell defines two operators for lists: cons ":" and "++". Cons can also deconstruct a list
#' 
#' In fact, we can ask Haskell to make such a function from an operator such as <= or + just by enclosing it in parentheses.
#' 
#' The. or function composition operator has type 
#' (b → c) → (a → b) → a → c.
#' 
#' Since the function composition operator is associative, that is f . (g . h) is equal to (f . g) . h, we do not need the parentheses,
#' 
#' f . g = \x -> f (g x)
#' 
#' We can, in fact, write it like this too:
#' 
#' (f . g) x = f (g x)
#' 
#' See how we define an operator just like a function, since in reality it is one
#' 
#' Techniques like map and composition are forms of program reuse, which is fundamental to writing manageable large programs.
#' 
#' Writeafunctionapplywhich,givenanotherfunction,anumberoftimestoapplyit,andaninitial argument for the function, will return the cumulative effect of repeatedly applying the function. For instance, apply f 6 4 should return f (f (f (f (f (f 4)))))). What is the type of your function?
#' 
#' $\to$ is a right-associative operator in the language of types.
#' 
#' 
#' Application is left-associative
#' f x y = (f x) y
#' 
#' or more verbosely
#' $(f(x))(y)$
#' 
#' 
#' Let,
#' 
#' f :: a -> b -> c
#' 
#' then (recall right associativity)
#' 
#' f x :: b -> c
#' 
#' Haskell includes a nicer way to write partially-applied functions based on operators. These are called operatorsections.
#' 
#' 
#' oriented programming, imperative programming, and functional programming
#' 
#'  Functional programming is, by simplified definition programming that takes immutability and mathematical computation with data into priority, rather than traditionally modifying parts of objects stored within class constructors. 
#'  
#'  # New kinds of data
#'  
#'  Ex. A Type for Mathematical Expressions
#'  a recursively-defined type, which can be processed naturally by recursive functions. Mathematical expressions can be modeled in the same way (as the ast). No parentheses necessary.
#'  
#'  Building our own types leads to clearer programs with more predictable behaviour, and helps us to think about a problem – often the functions are easy to write once we have decided on appropriate types.
#'  
#'  
#'  # Interactions (side effect inputs and outputs that are not explicit function return values)
#'  
#'  An I/O actions is a function $(I, World) \to (O, World)$

#' Pure expressions (without side-effects) to impure actions.





