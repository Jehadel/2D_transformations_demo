# 2D_transformations_demo
Shows 2x2 matrices use for simple 2D transformations (rotation, translation, scaling…)

See the comments in source for  detailed explanations

[On line demo](http://jehadel.github.io/2D_transformations_demo) (seems to have some issues with simultaneous key press detection)

2x2 matrices have a lot of limitations :

- all transformations are origin centered
- they can’t provide basic transformations like translation
- some transformations like scaling, etc. imply unwanted translations

That’s why 3x3 matrices are a better choice ! See [this repository](https://github.com/Jehadel/3x3-2D-transformations_demo)

## How to

To run the demo :

```bash
make run
```

Build .js executable for the web :

```bash
make js
```

## To do

Write explanations on 2x2 matrices 2D transformations directly in the README ! 

## Issues

The .js version seems to have issues detecting simultaneous key press.
