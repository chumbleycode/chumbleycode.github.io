#' ---
#' title: Note from Advanced R (Hadley Wickham and Thomas Mailund)
#' output:
#'    html_document:
#'      toc: true
#'      highlight: zenburn
#' ---
#' <!-- rmarkdown::render("supervised_play/nice_code.R") -->
#' <!-- [See here.](http://brooksandrew.github.io/simpleblog/articles/render-reports-directly-from-R-scripts/) -->
#+ setup, warning=FALSE, message=FALSE
knitr::opts_chunk$set(eval = FALSE)
library(here)
library(tidyverse)
library(rlang)
library(lobstr)
library(sloop)
 
#'# Functions
#'## Vectorized functions
#'Recycling shorter of the two vectors
c(1, 2) * rep(1, 10)
c(1, 2) <= rep(1, 10)

#'# Infix functions/operators


#' match.call() just gets us a representation of the current function call from
#' which we can extract the expression without evaluating it. We then use
#' replicate to evaluate it a number of times in the calling function’s scope.

`%x%` <- function(expr, num) {
  m <- match.call()
  replicate(num, eval.parent(m$expr))
}
rnorm(1) %x% 4

#' example
`+` <- function(x, y){
  
  if(is.numeric(x) & is.numeric(y)){
    z =   .Primitive("+")(x, y)
  } 
  
  if(is.character(x) & is.character(y)) {
    z = stringr::str_c(x,y)
  }
  
  if(is.list(x) & is.list(y)){
    z = list(c(x, y))
  }
  
  return(z)
} 

"a" + "b"
2 + 3
list("a", "b") + list("c")

#'SET OPERATIONS

`%n%` <- function(a, b) intersect(a, b)

`%u%` <- function(a, b){
  union(a, b)
}

`%/%` <- function(a, b){
  setdiff(a, b)
} 

c(1:10) %n% 2:12
c(1:10) %u% 2:12
c(1:10) %/% 2:12 



env_poke2 <- function(env, nm, val) {
  if(is.na(env_get(env, nm,default = NA))) {
    #'only assign if nm does not exist
    env_bind(env, !! nm := val) 
  } else {
    #'double assignment not allowed otherwise
    message("not allowed")
  }
} 



where <- function(name, env = caller_env()) {
  if (identical(env, empty_env())) {
    #'Base case
    stop("Can't find ", name, call. = FALSE)
  } else if (env_has(env, name)) {
    #'Success case
    env
  } else {
    #'Recursive case
    where(name, env_parent(env))
  }
}


#'finds all environments where
where_all <- function(name, env = caller_env()) {
  if (identical(env, empty_env())) {
    #'Base case 
    message("done")
  } else { 
    #'Recursive case
    if(env_has(env, name)) {
      print(env)
      print(env_get(env, name))
      print("******")
    }  
    where_all(name, env_parent(env))
  }
}

sd = 3
where("sd")
where_all("sd")
rm(sd)


#'finds all environments where
where_fnct <- function(name, env = caller_env()) {
  if (identical(env, empty_env())) {
    #'Base case 
    message("done")
    lobstr::cst()
  } else { 
    #'Recursive case
    print(caller_env())
    if(env_has(env, name) && is.function(env_get(env, name))) print(env)
    if(env_has(env, name) && is.function(env_get(env, name))) print(env_get(env, name))
    where_fnct(name, env_parent(env))
    
  }
}
where_fnct("sd")

sd = 3

x =3
e <- env()
e$g <- function() x
e$g %>% fn_env()
e$x = 4
with_env(e, function() y)



f1 <- function(x1) {
  f2 <- function(x2) {
    f3 <- function(x3) {
      lobstr::cst()
      x1 + x2 + x3
    }
    f3(3)
  }
  f2(2)
}
f1(1)




f <- function(x) {
  formals(f) %>% print
  where("f") %>% print
  g(x = 2)
  
}
g <- function(x) {
  h(x = 3)
}
h <- function(x) {
  #'stop()
  cst()
}
f(x = 1)
traceback()


#'lazy evaluation
a <- function(x) b(x)
b <- function(x) c(x)
#'c <- function(x) x
a(f())


#'list all variables in the caller env
my_ls <- function(func) {
  env_names(caller_env())
}


#'finds all environments where
where_fnct <- function(name, env = caller_env()) {
  if (identical(env, empty_env())) {
    #'Base case 
    message("done")
    lobstr::cst()
  } else { 
    #'Recursive case
    print(caller_env())
    if(env_has(env, name) && is.function(env_get(env, name))) print(env)
    if(env_has(env, name) && is.function(env_get(env, name))) print(env_get(env, name))
    my_ls() %>% print
    ls() %>% print
    where_fnct(name, env_parent(env)) 
    
  }
}
where_fnct("sd")



temp <- tempfile()
dir.create(temp)

cyls <- split(mtcars, mtcars$cyl)
paths <- file.path(temp, paste0("cyl-", names(cyls), ".csv"))
walk2(cyls, paths, write.csv)

mtcars %>% 
  split(mtcars$cyl) %>% 
  set_names(~file.path(temp, .)) %>%
  iwalk(write.csv)

span <- function(.x, .p) {
  #'returns (the first location) of the longest run length
  res = rle(map_lgl(.x,.p))
  values = res$lengths[res$values] 
  sum(res$lengths[1:(which.max(res$lengths*res$values)-1)]) + 1
}
span(list(1, "a", 2, 2, 2, 2, "b", "b",  "b", "b", "b",  "b", 1, 1, "b", "b",  "b","b", "b",  "b", "b"), ~. == "b")
span(list(1, "a", 2, 2, 2, 2, "b", "b",  "b", "b", "b",  "b", 1, 1, "b", "b",  "b","b"), is.character)


arg_max <- function(.x, .f) {
  
  y = map_dbl(.x, .f)
  .x[y == max(y)]
  
}
arg_max(-5:5, ~.x ^2)
optimise(function(x) x ^ 2, -5:5, maximum = TRUE)


#'get a function environment, then examine which other names are bound in that environment
apropos("sd") %>% map(get)
fn_env(caller_env) %>% env_print()
fn_env(caller_env) %>% env_parents()
env_names(as_env("rlang"))  



h2 <- function(x) {
  a <- x * 2
  current_env()
  function(y) y ^ a
}

e <- h2(x = 3)
env_print(e)$x 



#'function factories

pick <- function(ind) {
  force(ind)
  function(y) y[[ind]]
}

x <- rnorm(10)
pick(1)(x)
x[[1]] #'equiv

map(mtcars, pick(4))
mtcars[4, ] #'equivalent

moment <- function(moment) {
  #'return a function of general dataset x, with parameter "moment"
  force(moment)
  
  function(x) {
    mu = mean(x)
    mean((x - mu) ^ moment)
  }
}

m1 <- moment(1)
m2 <- moment(2)

x <- runif(100)
stopifnot(all.equal(m1(x), 0))
stopifnot(all.equal(m2(x), var(x) * 99 / 100))



tidy_moment <- function(x, moment) {
  #'a tidy version (not a "function factory")
  mu = mean(x)
  mean((x - mu) ^ moment) 
}
x %>% tidy_moment(2)
moment(2)(x)
x %>% moment(2)(.)


i <- 0
new_counter2 <- function() {
  i <<- i + 1
  i
}

new_counter2()

############################################################
#'function factories
############################################################

boxcox2 <- function(lambda) {
  if (lambda == 0) {
    function(x) log(x)
  } else {
    function(x) (x ^ lambda - 1) / lambda
  }
}


stat_boxcox <- function(lambda) {
  stat_function(aes(colour = lambda), fun = boxcox2(lambda), size = 1)
}

library(ggformula)
ggplot(data.frame(x = c(0.01, 1)), aes(x)) + 
  map(c(0.5, 0.25, 0.1, 0), stat_boxcox)  


############################################################
#'new ex
############################################################


powers <- function(exp) {
  force(exp)
  function(x) {
    x ^ exp
  }
}

gaus <- function(mu, sig){
  force(mu)
  force(sig)
  function(x){
    exp(- 1/sig * (x - mu) ^ 2)
  }
}

#'NOTE NAMING MANDATED BY PMAP: x is the arg required by factory powers, .fn is the arg of exec


#'many functions with different parameterizations
#'exec is a function taking a function and an argument
crossing(.fn = pmap(crossing(mu = 1:5, sig = 1:5), gaus),
         x = list(-10:10)) %>%   
  pmap(exec) %>% 
  walk(plot, x = -10:10)

#'or perhaps better? although less general
.fn = pmap(crossing(mu = 1:5, sig = 1:5), gaus)
map(.fn, exec, x = -10:10) %>% 
  walk(plot)

c("mean", "var") %>% map(exec, 1:10)

X = rnorm(1000) %>% matrix(nrow = 10)

############################################################
#'all about ...
############################################################



bb = function(q, r){
  lobstr::cst()
  q * 2 + r
  
}


cc = function(q){
  lobstr::cst()
  q * 2 
  
}


aa = function(x, r, ...){
  lobstr::cst()
  list2env(list(...), rlang::current_env()) 
  list(...) %>% pluck("q")
  list(...)[[1]]
  ..1
  names(list(...))
  
  print(ls())
  
  bb(x, cc(q))   
  
}


############################################################
#'METAPROGRAMMING
############################################################
#'Expressions are also called abstract syntax trees (ASTs)

cv <- function(var) {
  var <- enexpr(var)
  expr(sd(!!var) / mean(!!var))
}

cv(z + p)

eval(cv(x + y + z), env(x = 1:10, y = 3:12, z = 4:13))

lobstr::ast(f(x, "y", 1))

lobstr::ast(f(g(h()), 1+2+3, (x + y)*z )) 

lobstr::ast(f(g(h(i(1, 2, 3)))))

ast(f(1, g(2, h(3, i()))))

ast(f(g(1, 2), h(3, i(4, 5))))


#'if statement with multiple else if statements
code=  expr( if(junny) { a = 1} else if (mark) {b = 10} else if(caty) {cc = 20})
ast(!!code)


############################################################
#'subtypes of expressions
############################################################
x <- expr(read.table("important.csv", row.names = FALSE))
ast(!!x)
is.call(x)
length(x)
x[-3] #'remove the second arg
x[-1] #'remove the function! R assumes that the first argument is now a function! 

#'3 big types of 
#'call object
y =  expr(mean(x))
is_call(y)
is_syntactic_literal(y)
is_symbol(y)

#'contant scalar syntactic literal
y = expr("x")
is_call(y)
is_syntactic_literal(y)
is_symbol(y)

#'symbol "unquoted"
y = expr(x)
is_call(y)
is_syntactic_literal(y)
is_symbol(y)


x <- expr(read.table("important.csv", row.names = FALSE))
ast(!!x)
x %>% is_expression()
x %>% is_call #'in particular a call object, i.e. captured function call
x %>% map_lgl(is_expression) #'all elements of call object expression are themselves expressions
x %>% map_lgl(is_symbol)
x %>% map_lgl(is_syntactic_literal)
x %>% map_lgl(is_call)



rlang::call_standardise(x) #'explicit argument names
?rlang::call_standardise
#'
#'x = expr(q <- readRDS("rds/2008.7.8_pca.rds")) #'capture
#'x %>% is_call()
#'eval(x) #'evaluate call object



#'You can construct a call object from its components using rlang::call2(). The
#'first argument is the name of the function to call (either as a string, a
#'symbol, or another call). The remaining arguments will be passed along to the
#'call:
x = 1:10  
call2("mean", x = expr(x), na.rm = TRUE)
expr(mean(x, na.rm = TRUE))


get("mean")
call2("mean", x)
call2("mean", x) %>% eval


lobstr::ast(f((1)))
lobstr::ast(`(`(1 + 1))

############################################################
#'Recursion on AST
############################################################

expr_type <- function(x) {
  if (rlang::is_syntactic_literal(x)) {
    "constant"
  } else if (is.symbol(x)) {
    "symbol"
  } else if (is.call(x)) {
    "call"
  } else if (is.pairlist(x)) {
    "pairlist"
  } else {
    typeof(x)
  }
}

expr_type(expr("a"))
#> [1] "constant"
expr_type(expr(x))
#> [1] "symbol"
expr_type(expr(f(1, 2)))
#> [1] "call"

switch_expr <- function(x, ...) {
  switch(expr_type(x),
         ...,
         stop("Don't know how to handle type ", typeof(x), call. = FALSE)
  )
}

#'*** a basic template for any function that walks the AST using switch ***
recurse_call <- function(x) {
  switch_expr(x,
              #'Base cases
              symbol = ,
              constant = ,
              
              #'Recursive cases
              call = ,
              pairlist =
  )
}

#'For example: find logical abbreviations T, F

expr_type(expr(TRUE))
#> [1] "constant"

expr_type(expr(T))
#> [1] "symbol"


#'therefore base cases

logical_abbr_rec <- function(x) {
  switch_expr(x,
              constant = FALSE,
              symbol = as_string(x) %in% c("F", "T")
  )
}

logical_abbr_rec(expr(TRUE))
#> [1] FALSE
logical_abbr_rec(expr(T))
#> [1] TRUE

#'For ease of use, this wrapper means don't need to write expr every time
logical_abbr <- function(x) {
  logical_abbr_rec(enexpr(x))
}

logical_abbr(T)
logical_abbr(TRUE)



logical_abbr_rec <- function(x) {
  print(expr_type(x))
  print(x)
  print(eval(x))
  print(length(x))
  print("****************")
  switch_expr(x,
              #'Base cases
              constant = FALSE,
              symbol = as_string(x) %in% c("F", "T"),
              
              #'Recursive cases
              call = ,
              pairlist = purrr::some(x, logical_abbr_rec)
  )
}


call_expression = expr(f(llll, var(log(y)), w, mean(q, na.rm = T), z ))
call_expression %>% is_call()
ast(!!call_expression)


f = function(a,b,c,d,e){10 + llll}
w = 222
q = 1:10
llll = 3
z = 2455
y = 10
call_expression %>% map(eval)

call_expression %>% is_call()
call_expression %>% map(is_call)
call_expression[[2]] %>% is_call()

call_expression %>% some(is_call)


fact = 
  function(n){
    if(n == 1 | n == 0){ 
      #'base case
      lobstr:::cst()
      return(n)
    }
    #'recursive case
    return(n * fact(n-1))
  }
fact(10)


ast(body(!!fact))

#' #'base and OO objects
#' ##'base objects 

#' OO objects have a "class" attribute (may be implicit, in case of base
#' objects). Only OO objects have a class attribute, every object has a base
#' type. Base types do not form at OOP system.
typeof(mtcars)

#'#'S3

#' safer to use sloop::s3_class(), over class which returns the implicit class
#' that the S3 and S4 systems will use to pick method
s3_class(mtcars)

#' base R functions that contain . in their name but are not S3 methods.

ls(rlang::base_env()) %>% 
  str_subset("\\.") %>%
  keep(compose(is_function, get)) %>% 
  keep(negate(is_s3_method)) %>% 
  pluck(100) 

#' S3 doesn’t provide a formal definition of a class, so it has no built-in way
#' to ensure that all objects of a given class have the same structure (i.e. the
#' same base type and the same attributes with the same types). Instead, you
#' must enforce a consistent structure by using a constructor.  
#' [S3 advanced R](https://adv-r.hadley.nz/s3.html)

#'  all methods defined for a generic or associated with a class.
s3_methods_generic("mean")

(ff <- factor(substring("statistics", 1:10, 1:10), levels = letters))
s3_methods_class(s3_class(ff))

#' Get methods defined for each generic

all_generics_methods = 
  apropos("") %>% 
  unique() %>% 
  keep(compose(is_function, get)) %>% 
  keep(is_s3_generic) %>% 
  set_names() %>% 
  map(s3_methods_generic)  

#' which generics have most methods

all_generics_methods %>% 
  enframe() %>%
  mutate(n = map_int(value, nrow)) %>%
  arrange(-n)


x = 1:10
y = x + rnorm(length(x))

typeof(lm(x   ~ y))
sloop::s3_class(lm(x ~y))
sloop::s3_methods_class("lm") 

#' The S3 class of the return value of lm() is "lm". Call all callable methods that
#' belong to the s3 class "lm".
sloop::s3_class(lm(y ~ x))

#' Get all methods that can be dispatched by some generic for a given S3 object

get_all_methods_belonging_to_an_s3_object <- function(s3_object) {
  
  sloop::s3_methods_class(sloop::s3_class(s3_object)) %>% 
    pluck("generic") %>% 
    set_names() %>%  
    map(possibly(exec, otherwise = NULL), s3_object)
}

#' Search all these packages 
search()
calling_all_methods = get_all_methods_belonging_to_an_s3_object(lm(y ~ x))

#' Get more methods for lm
library(broom)
calling_all_methods = get_all_methods_belonging_to_an_s3_object(lm(y ~ x))

#'and what the methods actually do

calling_all_methods %>% 
  names %>% 
  map(help)  

#' other S3 classes which share a generic with "lm" S3 object, i.e. which can be
#' dispatched by the same generics as "lm".

calling_all_methods %>%
  names() %>%  
  set_names() %>% 
  map(sloop::s3_methods_generic) %>%
  map(pluck, "class") %>% 
  head(2)

#' What are the formal arguments to the generic `[`? This is a trick question.
#' Each method implementing `[` for a different S3 class has a different set of
#' formals.

sloop::s3_methods_generic("[") %>%
  unite(methods, generic, class, sep =".") %>% 
  pluck("methods") %>% 
  set_names() %>% 
  map(s3_get_method) %>% 
  map(formals) %>% 
  head(2)

#' Create a new generic and method
player <- function(i, r, s) {
  value <- list(id = i, rate = r, score = s)
  attr(value, 'class') <- 'player'
  value
}
e2 <- player(125, 12.75, 100)
print.player <- function(obj) {
  cat('ID = ', obj$id, '\n')
  cat('Rate = ', obj$rate, '\n')
  cat('Score = ', obj$score, '\n')
}
print(e2)
score <- function(obj) {
  UseMethod('score')
}
score.default <- function(obj) {
  cat('Default Function!')
}
score.player <- function(obj) {
  cat('Your Score = ', obj$score, '\n')
}
score(e2)


#'#'R6

#' To make it clear when we’re talking about fields and methods as opposed to
#' variables and functions, I’ll prefix their names with $. For example, the
#' Accumulate class has field $sum and method $add().

library(R6)
Accumulator <- R6Class("Accumulator", list(
  sum = 0,
  add = function(x = 1) {
    self$sum <- self$sum + x
    invisible(self)
  })
)
Accumulator
x <- Accumulator$new()
x
x$add(5)
x$sum
x$add(5)
x$sum

#' Method chaining is possible because we return `self` (invisibly). c.f. the pipe.

x$add(10)$add(10)$sum
