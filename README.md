# Linear Models

[![Build status](https://github.com/pharo-ai/linear-models/workflows/CI/badge.svg)](https://github.com/pharo-ai/linear-models/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/linear-models/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/linear-models?branch=master)
[![Pharo version](https://img.shields.io/badge/Pharo-9-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-10-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-11-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-12-%23aac9ff.svg)](https://pharo.org/download)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/linear-regression/master/LICENSE)

## Description

For more information please refer to the pharo-ai wiki: https://github.com/pharo-ai/wiki

This is a library that implements two of the most-know linear models: Linear and Logistic regression. 

## How to install it

To install `linear-models`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'AILinearModels';
  repository: 'github://pharo-ai/linear-models/src';
  load.
```

## How to depend on it

If you want to add a dependency on `linear-models` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'AILinearModels'
  with: [ spec repository: 'github://pharo-ai/linear-models/src' ].
```
