# 2D_transformations_demo
Shows 2x2 matrices use for simple 2D transformations (rotation, translation, scaling…)

See the comments in source for  detailed explanations

[On line demo](http://jehadel.github.io/2D_transformations_demo) (seems to have some issues with simultaneous key press detection)

2x2 matrices have a lot of limitations :

- all transformations are origin centered
- they can’t provide basic transformations like translation
- some transformations like scaling, etc. imply unwanted translations

That’s why 3x3 matrices are a better choice ! See [this repository](https://github.com/Jehadel/3x3-2D-transformations_demo)

## 2x2 transformation matrices

If points coordinates are represented by a vector or 2x1 column matrix, the multiplication of this vector by a 2x2 matrices is (I will represent coordinates by a row vector, when using a column vector just transpose the matrices used) :

$$ \begin{bmatrix} x & y \end{bmatrix} . 
    \begin{bmatrix} a & c \\\ 
    b & d\end{bmatrix} = 
    \begin{bmatrix} x.a + y.b &
     x.c + y.d\end{bmatrix} 
$$

Why would we want to express transformation by matrices multiplication ?

* we could expresse all transformation with a single operation (multiplication)

* as matrix multiplication is associative, by multiplying all transformation matrices in the correct order, we could create a unique matrix for a given combined transformations, in some cases (for exemple, apply the same transformation to a huge amount of points) the gain in performance would be noticeable. 

* don’t forget that matrix multiplication is non-commutative : matrices order is important and can’t be changed !

Let‘s see how different 2x2 matrices could be used to express different transformations.

### Identity matrix

$$ \begin{bmatrix} x & y\end{bmatrix} . 
    \begin{bmatrix} 1 & 0 \\\ 
                0 & 1 \end{bmatrix} =
    \begin{bmatrix} x.1 + y.0 & x.0 + y.1 \end{bmatrix} =
    \begin{bmatrix} x & y \end{bmatrix}
$$

Multiplication by the identity matrix (a matrix filled of 1s on the diagonal only) seems useless. But it shows us the logic of using matrix multiplication to apply a transformation. Well chosen parameters in the 2x2 transformation matrix will affect the coordinates of a point, and therefore, the form of a figure (that’s what a transformation is, isn’t it ?)

### Scaling

$$ \begin{bmatrix} x & y\end{bmatrix} . 
    \begin{bmatrix} 10 & 0 \\\ 
                0 & 10 \end{bmatrix} =
    \begin{bmatrix} x.10 + y.0 & x.0 + y.10 \end{bmatrix} =
    \begin{bmatrix} 10x & 10y \end{bmatrix}
$$

If we replace the 1s by 10s in the identity matrix, we see that the coordinates will be expanded by a 10 factor. If we apply this to all the points of a figure, all the distances will be expanded, like in a scaling transformation. The scaling factor can be different for *x* and *y*.

Thus, here is the scaling matrix, with scaling factors S<sub>x</sub> and S<sub>y</sub> :

$$\begin{bmatrix} S_x & 0 \\\ 
                0 & S_y \end{bmatrix}
$$

But this method has a drawback : by directly changing *x* and *y* to change the scale of the figure, we will also change the position of the figure…


### Shearing

If we put a scaling factor outside of the diagonal of the matrix, what happens ?

$$ \begin{bmatrix} x & y\end{bmatrix} . 
    \begin{bmatrix} 1 & S_x \\\ 
                0 & 1 \end{bmatrix} =
    \begin{bmatrix} x.1 + y.S_x & x.0 + y.1 \end{bmatrix} =
    \begin{bmatrix} x + S_x.y & y \end{bmatrix}
$$

We see that as far as *y* gets bigger (or smaller) *x* is proportionnally affected, but *y* remains the same. It produces a deformation along the *x* axis like the figure got teared called *shear*. 

As above, directly modifying *x* also change the *x* position of the figure…

The matrix for *y* shearing is :

$$
 \begin{bmatrix} 1 & S_x \\\ 
                0 & 1 \end{bmatrix}
$$

### Horizontal and vertical flips

Get back to the identity matrix, and change a 1 by a -1 :

$$ \begin{bmatrix} x & y\end{bmatrix} . 
    \begin{bmatrix} -1 & 0 \\\ 
                0 & 1 \end{bmatrix} =
    \begin{bmatrix} x.-1 + y.0 & x.0 + y.1 \end{bmatrix} =
    \begin{bmatrix} -x & y \end{bmatrix}
$$

It results by an horizontal flip, as if the figure were reflected with respect of the *y* axis.

The matrix for a vertical flip :

$$
\begin{bmatrix} 1 & 0 \\\ 
                0 & -1 \end{bmatrix}
$$

The drawback of this method is that the figure is transformed regarding *x* and *y* axes.

### Rotation matrix (clockwise)

The rotation formulas are harder to explain. (Explanation will come with figures soon).

For the moment, just take for granted that the rotation matrix is :

$$
 \begin{bmatrix} \cos \theta & -\sin \theta \\\ 
                \sin \theta & \cos \theta \end{bmatrix}
$$

The drawback of this formula is that rotation is (*x* and *y* axes) origin centered. 

### Rotation matrix (anti-clockwise)

Anti-clockwise rotation can easily be realised with the rotation matrix, you just need to use -θ rather than θ.

But you can also stick to θ and use a very similar matrix :

$$
 \begin{bmatrix} \cos \theta & \sin \theta \\\ 
                -\sin \theta & \cos \theta \end{bmatrix}
$$

Of course the rotation is also axes origin centered.

## Drawbacks

### 2x2 matrices can’t express translation by multiplication

2x2 matrices have a major drawbacks : they can’t express translation.

For exemple : consider a point translation of 10 units along the x axis and 8 units along the y axis, we can express this translation by :

$$ x_t = x + 10 $$

$$ y_t = y + 8 $$

Of course if we want to express this transformation with matrices, 2x1 matrices addition is trivial :

$$ \begin{bmatrix} x & y \end{bmatrix} + 
    \begin{bmatrix} 10 & 8 \end{bmatrix} = 
    \begin{bmatrix} x + 10 & y + 8 \end{bmatrix}
$$

but 2x2 matrices can’t express such transformation by multiplication  :

$$ \begin{bmatrix} x & y \end{bmatrix} . 
    \begin{bmatrix} a & b \\\ 
    b & c\end{bmatrix} = 
    \begin{bmatrix} x.a + y.b &
    x.c + y.d\end{bmatrix} 
$$

Each term is either a multiple of x or a multiple of y. We can’t add a constant.

### Genuine 2x2 transformations are origin or axes centered

We have seen that, by constructions, 2x2 matrices transformation lead to unwanted translation or are axes/origin centered.

Moreover, we have seen that translation can be expressed by addition but not really by multiplication.

Actually, we can build 2x2 matrices that performs rotation centered on any arbitrary point, as if the figures were translated to rotate around this point. I will not do the math, but we can understand that if translation is obtained “by addition” and rotation “by multiplication” the matrix formula will contain an additive term. The building process gets more complex, and as not straightforward as the genuine multiplication of transformation matrices. Especially if we want to chain transformations.

That’s why 3x3 matrices – with a little trick – are a better choice ! See [this repository](https://github.com/Jehadel/3x3-2D-transformations_demo)

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

* Maybe add figures to explanations !

## Issues

* The .js version seems to have issues detecting simultaneous key press.
