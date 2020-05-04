* Expertise in a number of the following technologies R, Python, SQL, Spark, Hadoop, Tensorflow, AWS, GitLab, GitHub, Shiny, Qlik, Tableau, Java
* Understanding and having being involved in projects that implied the use of classical statistical and machine learning models such as predictive analytics, multivariate regression (including Mix Models), Time Series, Clustering methods, Optimization algorithms, RF, Boosting, SVM, Neural Networks, NLP, Causal Models, Bayesian Networks, etc.

* portable, reproducible analysis

* cloud computing

* stratification/segmentation methods [here](https://www.qualtrics.com/uk/experience-management/brand/market-segmentation/)

*  Proficiency with making data easily accessible to collaborators (e.g. Shiny, Dash) 

* workflow management systems (e.g. Snakemake, Nextflow, Cromwell/WDL, Knime) [see here](http://blog.booleanbiotech.com/nextflow-snakemake-reflow.html) [and here](http://www.opiniomics.org/the-three-technologies-bioinformaticians-need-to-be-using-right-now/)

* hadoop (mature "ecosystem", two components: 1) MapReduce - an indexing was to do work on cluster (perhaps increasingly old), 2) HDFS - how to store the data as a file system) and spark (new) are the competing frameworks for dealing with big data (spark can process HDFS). They compete as a processing engine. Spark better for streaming. Hadoop-MapReduce was not built for realtime processing. https://www.youtube.com/watch?v=xDpvyu0w0C8

* The dplyr methods convert your R code into SQL code before passing it to Spark. sparklyr also has two "native" interfaces that will be discussed in the next two chapters. Native means that they call Java or Scala code to access Spark libraries directly, without any conversion to SQL. sparklyr supports the Spark DataFrame Application Programming Interface (API), with functions that have an sdf_ prefix. It also supports access to Spark's machine learning library, MLlib, with "feature transformation" functions that begin ft_, and "machine learning" functions that begin ml_.

* Rank features by their average impurity reduction, over a forest. (When a tree splits the noise (overfits) the impurity goes down very little.) Then take a few of the best features, and retrain the classifier and show it works. Conclusion: you successfully . Random forest works for high dim, because you never compute distances (not curse of dimensionality). Only Gaussian processes and random forests give you an uncertainty estimate for you regression coefficients.

* Bagging reduces variance (when training error is much less than test error) without affecting bias. So use on unbiased algorithms. Boosting reduces a bias problem: can you combine weak learners (which can't reduce training error to zero, for classification they only need do better than chance) to make a strong learner (which can): adaboost. Boosting is gradient descent on function space. Adaboost reduces bias, and really doesn't increase variance much

* Using cross validation to find the hyperparameter controlling the penalty for tree complexity (number of leaves), i.e. Cost Complexity Pruning, aka Weakest Link Pruning. Interpretation: A tree encodes a partition of sample space or sample, a function on sample space or sample, a joint random variable p(fullpath(X), Y), i.e. p(X=fullpath)p(y|X=fullpath), a scalar random variable E(Y|X) so that randomness in X implies a random path which implies a real expected value (or mode for classification). Viewed as a joint random variable (fullpath(X), Y) we can define the fullpath-conditional entropy  H(Y|fullpath(X)). Fullpaths are isomororphic with nodes. Trees have qualitative structure, aspects of the function, Random variable are described qualitatively. 
