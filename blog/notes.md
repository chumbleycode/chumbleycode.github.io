* Expertise in a number of the following technologies R, Python, SQL, Spark, Hadoop, Tensorflow, AWS, GitLab, GitHub, Shiny, Qlik, Tableau, Java
* Understanding and having being involved in projects that implied the use of classical statistical and machine learning models such as predictive analytics, multivariate regression (including Mix Models), Time Series, Clustering methods, Optimization algorithms, RF, Boosting, SVM, Neural Networks, NLP, Causal Models, Bayesian Networks, etc.

* Proficient in Python and the scientific computing stack (SciPy, Numpy, Scikit- learn, pandas)

* Proficient in one of the deep learning frameworks (PyTorch, Tensorflow)

* portable, reproducible analysis

* cloud computing

* stratification/segmentation methods [here](https://www.qualtrics.com/uk/experience-management/brand/market-segmentation/)

*  Proficiency with making data easily accessible to collaborators (e.g. Shiny, Dash) 

* workflow management systems (e.g. Snakemake, Nextflow, Cromwell/WDL, Knime) [see here](http://blog.booleanbiotech.com/nextflow-snakemake-reflow.html) [and here](http://www.opiniomics.org/the-three-technologies-bioinformaticians-need-to-be-using-right-now/)

* hadoop (mature "ecosystem", two components: 1) MapReduce - an indexing was to do work on cluster (perhaps increasingly old), 2) HDFS - how to store the data as a file system) and spark (new) are the competing frameworks for dealing with big data (spark can process HDFS). They compete as a processing engine. Spark better for streaming. Hadoop-MapReduce was not built for realtime processing. https://www.youtube.com/watch?v=xDpvyu0w0C8

* The dplyr methods convert your R code into SQL code before passing it to Spark. sparklyr also has two "native" interfaces that will be discussed in the next two chapters. Native means that they call Java or Scala code to access Spark libraries directly, without any conversion to SQL. sparklyr supports the Spark DataFrame Application Programming Interface (API), with functions that have an sdf_ prefix. It also supports access to Spark's machine learning library, MLlib, with "feature transformation" functions that begin ft_, and "machine learning" functions that begin ml_.

* Rank features by their average impurity reduction, over a forest. (When a tree splits the noise (overfits) the impurity goes down very little.) Then take a few of the best features, and retrain the classifier and show it works. Conclusion: you successfully . Random forest works for high dim, because you never compute distances (not curse of dimensionality). Only Gaussian processes and random forests give you an uncertainty estimate for you regression coefficients.

* Bagging reduces variance (when training error is much less than test error) without affecting bias. So use on unbiased algorithms. Boosting reduces a bias problem: can you combine weak learners (which can't reduce training error to zero, for classification they only need do better than chance) to make a strong learner (which can): adaboost. Boosting is gradient descent on function space. Adaboost reduces bias, and really doesn't increase variance much

* For hypothesis classes with variable complexity: improve prediction by cross-validating - a parameter controlling - bias-variace, e.g. the penalty for tree complexity (number of leaves/cells in the partition). This is called Cost Complexity Pruning, aka Weakest Link Pruning. Similar hyperparameter for nearest neighbour algorithms. 

* A tree gives a real vector space of inputs an equivalence relation, similarity or "proximity relation" (two points equiv iff they are in the same partition  cell). What do random partitions look like? L_i mu_i which L_i is the indicator over the cell or leaf i, and mu_i is the mean. "prediction function" is sum i L_i mu_i.

* Get a "distance matrix" between any two data points, namely: 1 - proximity (average equivalence relation/partition over the forest). See statquest random forests part 2. I don't know if this is a distance metric? It ranges on [0,1]. 

* partition <-> equivalence relation A subset of A^2 <-> tree <-> transitive, reflexive and symmetric (matrix or graph) of data points. So we have an order on equivalence relations. For a given tree, this forms a binary "distance measure", i.e. belong to the same clique/leaf or not. Average the indicator/matrix representation of tree-specific equivalence relations, (over a forest of trees) to give an integer-valued proximity matrix (see statquest, part 2 on random forests). Actually, they are random equivalence relations, with randomness due to resampling and splitting on random dimensions. A nested sequence of partition trees (decision trees conveniently describe nested partition, like syntax trees describe nested operations). Decision trees give an ORDER to a set of subsets of datapoints (comparable or incomparable subsets of input space). The set of nested subtrees are a set of partitions, ordered by coarseness/refinenment. For any dataset, a tree complexity parameter alpha (added to the objective L = RSS + alpha x T) gives a (unique?) path through that set of partitions. Recursively, greedily union the two set or "prune" the two distinction which minimize penalized loss. Use cross validation to pick alpha and therefore one partition on this path? Does the finest partition seperate outputs by class? Should it? Coarse partition trees greatly overgeneralize about the output class (erroroneously label many units). Quantify the generalization error due to overgeneralization and undergeneralization (bias and variance). Ridge regression arises due to complexity penalized objective. Hierarchical Bayes too. How to generally describe "complexity" of a function, of a joint distribution? This is easy within the specified class of piecewise constant functions (say indicator functions for binary classification) complexity: it is just a partial order? Two different trees/partitions may have the same terminal complexity (number of leaves). These functions are not of nested complexity: each discrete complexity indexes a class of partitions.

* Research idea: test whether a random field predictor set is significant. Examine the distribution on blocksizes, which is known if partions are sampled uniformly at random, i.e. there is no 

What is the distribution of node sizes, the maximal node size? 

* A tree is a function assigning inputs to terminal cells. Another function then maps the input to a value, e.g. a piecewise constant function. 

* piecewise, cell-wise functions/hypotheses (a function defined by multiple sub-functions, each sub-function applying to a certain interval of the main function's domain, a sub-domain). Complexity is the number of terminals (sub-domains) plus the complexity within each sub-domain, plus the size of the subdomains?
 
* Use out-of-bag sample to estimate generalization - prediction error - of a random forest. The preportion of out-of-bag samples that were incorrectly classified, the out-of-bag prediction error.

* Tree interpretation: A tree encodes a partition of sample space or sample, a function on sample space or sample, a joint random variable p(fullpath(X), Y), i.e. p(X=fullpath)p(y|X=fullpath), a scalar random variable E(Y|X) or mode(Y|X) so that randomness in X implies a random path which implies a real value or discrete label. Viewed as a joint random variable (fullpath(X), Y) we can define the fullpath-conditional entropy  H(Y|fullpath(X)). Fullpaths are isomororphic with nodes. Trees have qualitative structure, aspects of the function, Random variable are described qualitatively. 

* Impute one variable based on marginal for that variable (mode, mean, median), based on another correlated variable, a set of predictors, or use a random forest to impute (i.e. initialize, then for each missing value calculate weighted average of the non-missing value with weights equal to the fraction of times the missing case was similar - same leaf node - to each non-missing case).
