# Linear Models

[![Build status](https://github.com/pharo-ai/linear-regression/workflows/CI/badge.svg)](https://github.com/pharo-ai/linear-regression/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/linear-regression/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/linear-regression?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/linear-regression/master/LICENSE)

### Table of Contents  
- [Description](#description)  
- [How to install it](#how-to-install-it)  
- [How to depend on it](#how-to-depend-on-it)
- [Linear regression](#linear-regression)
- [Logistic regression](#logistic-regression)
- [Measuring the accuracy of a model](#measuring-accuracy)

## [Description](#Description)

This is a library that implements two of the most-know linear models: Linear and Logistic regression.

## [How to install it](#How-to-install-it)

To install `linear-models`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'AILinearModels';
  repository: 'github://pharo-ai/linear-models/src';
  load.
```

## [How to depend on it](#How-to-depend-on-it)

If you want to add a dependency on `linear-models` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'AILinearRegression'
  with: [ spec repository: 'github://pharo-ai/linear-regression/src' ].
```

## [Linear regression](#Linear-regression)

Linear regression is a machine learning model that attempts to find the the linear relationship between one or more input variables _x1, x2, ..., xn_ and an output variable _y_. It finds a set of parameters _b, w1, w2, ..., wn_ such that the predicted output _h(x) = b + w1 * x1 + ... + wn * xn_ is as close as possible to the real output _y_.

Given 20 input vectors _x = (x1, x2, x3)_ and 20 output values _y_.

```Smalltalk
input := #( (-6 0.44 3) (4 -0.45 -7) (-4 -0.16 4) (9 0.17 -8) (-6 -0.41 8)
    (9 0.03 6) (-2 -0.26 -4) (-3 -0.02 -6) (6 -0.18 -2) (-6 -0.11 9)
    (-10 0.15 -8) (-8 -0.13 7) (3 -0.29 1) (8 -0.21 -1) (-3 0.12 7)
    (4 0.03 5) (3 -0.27 2) (-8 -0.21 -10) (-10 -0.41 -8) (-5 0.11 0)).

output := #(-10.6 10.5 -13.6 27.7 -24.1 12.3 -2.6 -0.2 12.2 -22.1 -10.5 -24.3 2.1 14.9 -11.8 3.3 1.3 -8.1 -16.1 -8.9).
```

We want to find the linear relationship between the input and the output. In other words, we need to find such parameters _b, w1, w2, w3_ that the line _h(x) = b + w1 * x1 + w2 * x2 + w3 * x3_ fits the data as closely as possible. To do that, we initialize a linear regression model and fit it to the data.

```Smalltalk
linearRegressionModel := AILinearRegression new
  learningRate: 0.001;
  maxIterations: 2000;
  yourself.
	
linearRegressionModel fitX: input y: output.
```

Now we can look at the trained parameters. The real relationship between x and y is _y = 2*x1 + 10*x2 - x3_, so the parameters should be close to _b=0_, _w1=2_, _w2=10_, _w3=-1_.

```Smalltalk
b := linearRegressionModel bias.
"-0.0029744215186773065"
w := linearRegressionModel weights.
"#(1.9999658061022905 9.972821149946537 -0.9998757756318858)"
```

Finally, we can use the model to predict the output for previously unseen input.

```Smalltalk
testInput := #( (-3 0.43 1) (-3 -0.11 -7) 
    (-6 0.06 -9) (-7 -0.41 7) (3 0.43 10)).
    
expectedOutput := #(-2.7 -0.01 -2.4 -25.1 0.3).
```

```Smalltalk
linearRegressionModel predict: testInput.
"#(-2.7144345209804244 -0.10075173689646852 -2.405518008448657 -25.090722165135997 0.28647833494634645)"
```

## [Logistic regression](#Logistic-regression)

Logistic regression is a statistical model that predicts the likehood that an event can happen giving as an output the probability.

For example, if we have a function: 
```
 f(x) = 1   if x ≥ 0
        0   if x < 0
```
that returns `1` for all positive numbers including 0, and `0` for all negative numbers.
We can train a logistic model for making predictions when a new number arrives.

```st
input := #( (-6.64) (-7) (-0.16) (-8) (-2)
    (-90.03) (-7.26) (-3.02) (-54.18) (-9.6)
    (8) (7) (3.29) (8.21) (76.09)
    (45) (3) (10) (9) (5.11)).

output := #(0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1).
```

Now we have to train the logistic regression model.

```Smalltalk
logisticRegressionModel := AILogisticRegression new
  learningRate: 0.001;
  maxIterations: 2000;
  yourself.
	
logisticRegressionModel fitX: input y: output.
```

We can look at the trained parameters. As the funciton returns `1` for all positive numbers and 0, and returns `0` for negative numbers, the bias should be close to 0 and the weight close to 1.

```Smalltalk
b := logisticRegressionModel bias.
"0.005920279313031135"
w := logisticRegressionModel weights.
"#(0.9606463585049467)"
```

We can use the model to predict the output for previously unseen input.

```Smalltalk
testInput := #( (-3) (-0.11) (-4.67) (9) (7) (10)).
    
expectedOutput := #(0 0 0 1 1 1).
```

```Smalltalk
logisticRegressionModel predict: testInput.
"#(0 0 0 1 1 1)"
```

If we want to have the probabilities of the model, not just `1` or `0`, we can call the method `predictProbabilities:`. It will return us the probabilities that the input has an output of 1.

```st
logisticRegressionModel predictProbabilities: testInput
"#(0.05335185163762839 0.4750829523986599 0.011203102336961287 0.9998252077292514 0.998807422178672 0.9999331093095885)"
```

In our example, we have a `0.05335185163762839` probability that the output for `-3`  is `1`. Also we have a `0.9999331093095885` probability that the output for `10` is `1`.

## [Measuring the accuracy of a model](#Measuring-accuracy)

To measure the accuracy of the model we have a library [metrics](https://github.com/pharo-ai/metrics) in pharo-ai. You will find there the Metacello scrip to install that library. After installing it, we can test the accurancy of the logistic of linear regression models.

For example, let's image that our logistic regression model has produced the following output.

```st
prediction := logisticRegressionModel predict: someValuse
"#( 1 3 5 7 4 2)"
```

And we know that we the real values are:
```st
realValues := #(1 3.5 4 7 3.5 1)
```

So, we can test the accuracy of the model using the metrics that we just installed.
For the previous values, we can compute the r2 score (the coefficient of determination).

```st
prediction := #( 1 3 5 7 4 2).
realValues := #(1 3.5 4 7 3.5 1).

metric := AIR2Score new.
metric computeForActual: realValues predicted: prediction.
"0.8993288590604027"
```
So, our model has a r2 score 0.89. A R2 score of 1 indicates that the model is predicting perfectly.

For more information about please refer to our [metrics library](https://github.com/pharo-ai/metrics) where we explain all the available metrics that we have, what those metrics represent and how to use them.
