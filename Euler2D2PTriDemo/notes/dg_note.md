# Euler Equation

In Euler equation, we will have a vector PDE looks like:

$$
\frac{\partial u}{\partial t} + \frac{\partial f_i(u)}{\partial x_i} = 0
$$

In 2D case, we could write it as:

$$
\frac{\partial u}{\partial t} +  \frac{\partial f_x(u)}{\partial x} + \frac{\partial f_y(u)}{\partial y} = 0
$$

for convenience, we could write it as:

$$
u_t+f_x(u)_x+f_y(u)_y=0
$$

where $f_x(u)$ and $f_y(u)$ are fluxes in $x$ and $y$ directions. Thus the PDE can also be written as:

$$
u_t+\nabla\cdot\vec{f}(u)=0
$$

# Interpolation in Tri-element

Take 2-p order Lagrange polynomial as example, we have:

$$
\tilde{u}(x,y)=\sum_{j=1}^6 \phi_j(x,y)u_j
$$

where $u_j$ is the value of $u$ at the $j$-th node, and $\phi_j(x,y)$ is the basis function at the $j$-th node.

For convenience, we could write it with Einstein notation:

$$
\tilde{u}(x,y)=\phi_j u_j
$$

where $\phi_j$ is a scalar function of $x$ and $y$.

# Galerkin Method

In Galerkin method, we will have:

$$
\int_\Omega \phi_i u_t d\Omega + \int_\Omega \phi_i \nabla\cdot\vec{f}(u) d\Omega = 0\quad i=1,2,\cdots,N_k
$$

where $N_k$ is the number of nodes in the $k$-th element. $N_k=6$ for 2-order DG tri-element.

Let $u(x,y)\approx\tilde{u}(x,y)=\phi_j u_j$, we will have:

$$
\int_\Omega \phi_i \phi_j u_{j,t} d\Omega + \int_\Omega \phi_i \nabla\cdot\vec{f}(\phi_j u_j) d\Omega = 0\quad i=1,2,\cdots,N_k
$$

Let's consider a integral of the form:

$$
\int_\Omega \varphi\nabla\cdot\vec{A}d\Omega=
\int_{\partial\Omega}\varphi\vec{A}\cdot\vec{n}ds-
\int_\Omega\vec{A}\cdot\nabla\varphi d\Omega
$$

Thus the above equation can be written as:

$$
\int_\Omega \phi_i \phi_j u_{j,t} d\Omega =
\int_\Omega\vec{f}(\phi_j u_j)\cdot\nabla\phi_i d\Omega-
\int_{\partial\Omega}\phi_i\vec{f}(\phi_j u_j)\cdot\vec{n}ds
\quad i=1,2,\cdots,N_k
$$

Let's see the lhs. We have:

$$
\int_\Omega \phi_i \phi_j u_{j,t} d\Omega=
\left(\int_\Omega \phi_i \phi_j d\Omega\right)
\frac{\partial u_j}{\partial t}
$$

In time discretization, we have:

$$
\frac{\partial u_j}{\partial t}\approx\frac{u_j^{n+1}-u_j^n}{\Delta t}
$$

Thus we have:

$$
\int_\Omega \phi_i \phi_j u_{j,t} d\Omega=
\left(\int_\Omega \phi_i \phi_j d\Omega\right)
\frac{u_j^{n+1}-u_j^n}{\Delta t}
$$

the part $\int_\Omega \phi_i \phi_j d\Omega$ is the mass matrix, which is a constant matrix for a given domain (element). Let's denote it as $M_{ij}$.

For the rhs, the first term is a volume integral:

$$
\int_\Omega\vec{f}(\phi_j u_j)\cdot\nabla\phi_i d\Omega=
\sum_k^{N_P}\omega_k\vec{f}(\phi_j(x_k,y_k)u_j) \cdot \nabla\phi_i(x_k,y_k)
$$

In this part $\nabla\phi_i$ is needed. This integral in DG method is usually calculated by Gauss quadrature. Thus we need $\phi_j(x,y)$'s value at the Gauss points $(x_k,y_k)$ as well as $\nabla\phi_i(x,y)$'s value at the Gauss points.

The second term is a surface integral:

$$
\int_{\partial\Omega}\phi_i\vec{f}(\phi_j u_j)\cdot\vec{n}ds=
\sum_{\partial\Omega}\phi_i\vec{f}(\phi_j u_j)\cdot\vec{n}ds
$$

Also this integral is calculated by Gauss quadrature. Thus we need $\phi_j(x,y)$'s value at the Gauss points $(x_k,y_k)$ as well as $\vec{f}(\phi_j u_j)$'s value at the Gauss points. However, this part should applied some schemes to calculate the flux at the boundary. For example, we could use the upwind scheme or Roe scheme to get the flux at the boundary.

# Jacobian Matrix

Integral for different element is different. Thus we could apply a transformation from global coordinate $(x,y)$ to local coordinate $(\xi,\eta)$. In this way, we could calculate the integral in local coordinate.

Let's see such transformation in tri-element:

$$
\begin{bmatrix}
x\\ y
\end{bmatrix}=
\begin{bmatrix}
A_1 + A_2\xi + A_3\eta\\
B_1 + B_2\xi + B_3\eta
\end{bmatrix}
$$

where $A_i$ and $B_i$ are constants. Thus we have:

$$
\begin{bmatrix}
\frac{\partial x}{\partial \xi} & \frac{\partial x}{\partial \eta}\\
\frac{\partial y}{\partial \xi} & \frac{\partial y}{\partial \eta}
\end{bmatrix}=
\begin{bmatrix}
A_2 & A_3\\
B_2 & B_3
\end{bmatrix}
$$

Such transformation can also be written as:

$$
\begin{bmatrix}
x\\ y
\end{bmatrix}=
\begin{bmatrix}
A_2 & A_3\\
B_2 & B_3
\end{bmatrix}
\begin{bmatrix}
\xi\\ \eta
\end{bmatrix}+
\begin{bmatrix}
A_1\\ B_1
\end{bmatrix}
$$

which has clear physical meaning. $\begin{bmatrix}A_2 & A_3\\ B_2 & B_3\end{bmatrix}$ is the Jacobian matrix, which represents affine transformation and rotational transformation. $\begin{bmatrix}A_1\\ B_1\end{bmatrix}$ is the translation vector.

A reference tri-element is shown below:

![tri-element](./images/reference_tri_elem.png)

