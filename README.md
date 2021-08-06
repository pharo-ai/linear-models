# Linear Regression

Linear regression is a machine learning model that attempts to find the the linear relationship between one or more input variables _x1, x2, ..., xn_ and an output variable _y_. It finds a set of parameters _b, w1, w2, ..., wn_ such that the predicted output _h(x) = b + w1 * x1 + ... + wn * xn_ is as close as possible to the real output _y_.

## How to install it?

To install `linear-regression`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'AILinearRegression';
  repository: 'github://pharo-ai/linear-regression/src';
  load.
```

## How to depend on it?

If you want to add a dependency on `linear-regression` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'AILinearRegression'
  with: [ spec repository: 'github://pharo-ai/linear-regression/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## How to use it?

Given 20 input vectors _x = (x1, x2, x3)_ and 20 output values _y_.

```Smalltalk
input := #(
    (-6 0.44 3)
    (4 -0.45 -7)
    (-4 -0.16 4)
    (9 0.17 -8)
    (-6 -0.41 8)
    (9 0.03 6)
    (-2 -0.26 -4)
    (-3 -0.02 -6)
    (6 -0.18 -2)
    (-6 -0.11 9)
    (-10 0.15 -8)
    (-8 -0.13 7)
    (3 -0.29 1)
    (8 -0.21 -1)
    (-3 0.12 7)
    (4 0.03 5)
    (3 -0.27 2)
    (-8 -0.21 -10)
    (-10 -0.41 -8)
    (-5 0.11 0)).

output := #(-10.6 10.5 -13.6 27.7 -24.1 12.3 -2.6 -0.2 12.2 -22.1 -10.5 -24.3 2.1 14.9 -11.8 3.3 1.3 -8.1 -16.1 -8.9).
```

We want to find the linear relationship between the input and the output. In other words, we need to find such parameters _b, w1, w2, w3_ that the line _h(x) = b + w1 * x1 + w2 * x2 + w3 * x3_ fits the data as closely as possible. To do that, we initialize a linear regression model and fit it to the data.

```Smalltalk
model := AILinearRegression new
  learningRate: 0.001;
  maxIterations: 2000;
  yourself.
	
model fitX: input y: output.
```

Now we can look at the trained parameters. The real relationship between x and y is _y = 2*x1 + 10*x2 - x3_, so the parameters should be close to _b=0_, _w1=2_, _w2=10_, _w3=-1_.

```Smalltalk
b := model bias. "-0.0029744215186773065"
w := model weights. "#(1.9999658061022905 9.972821149946537 -0.9998757756318858)"
```

Finally, we can use the model to predict the output for previously unseen input.

```Smalltalk
testInput := #(
    (-3 0.43 1) 
    (-3 -0.11 -7) 
    (-6 0.06 -9) 
    (-7 -0.41 7) 
    (3 0.43 10)).
```
