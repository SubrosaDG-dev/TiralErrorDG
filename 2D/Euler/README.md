# Euler Equation 2D

Euler equation's 2D form looks like:

$$
\frac{\partial U}{\partial t}+
\frac{\partial F_x(U)}{\partial x}+
\frac{\partial F_y(U)}{\partial y} = 0
$$

This equation is detailed as below:

$$
\begin{equation}
    \frac{\partial}{\partial t}
    \begin{bmatrix}
        \rho \\ 
        \rho U\\
        \rho  V\\
        \rho E
    \end{bmatrix}+
    \frac{\partial}{\partial x}
    \begin{bmatrix}
        \rho u\\
        \rho u^2 + p\\
        \rho u v\\
        \rho H u
    \end{bmatrix}+
    \frac{\partial}{\partial y}
    \begin{bmatrix}
        \rho v\\
        \rho u v\\
        \rho v^2 + p\\
        \rho H v
    \end{bmatrix}
    =\vec{0}
\end{equation}
$$

For convenience, we define the flux vector as:

$$
\begin{equation}
    \vec{W}=
    \frac{\partial}{\partial t}
    \begin{bmatrix}
        \rho \\ 
        \rho u\\
        \rho  v\\
        \rho E
    \end{bmatrix}
    \quad
    \vec{F}_x=
    \begin{bmatrix}
        \rho u\\
        \rho u^2 + p\\
        \rho u v\\
        \rho H u
    \end{bmatrix}
    \quad
    \vec{F}_y=
    \begin{bmatrix}
        \rho v\\
        \rho u v\\
        \rho v^2 + p\\
        \rho H v
    \end{bmatrix}
\end{equation}
$$

While the symbols represent the following physical quantities:

- $\rho$: density of the fluid;
- $u,v$: velocity of the fluid on direction $x$ and $y$;
- $p$: pressure of the fluid;
- $E$: enegry per unit volume of the fluidn as $E=e+\frac{1}{2}(u^2+v^2)$, while $e$ represents the internal energy per unit volume of the fluid;
$$
\begin{equation}
    e = c_v T
\end{equation}
$$

where $T$ is the Temperature of the fluid, $c_v$ is the specific heat capacity at constant volume, and $c_v$ is the specific heat capacity at constant pressure. The relationship between $c_p$ and $c_v$ is:

$$
\begin{equation}
    c_p = c_v + R
\end{equation}
$$

where $R$ is the gas constant, for air, $R = 8.314m^2 Pa K^{-1} mol^{-1}$, and $\gamma$ is the ratio of $c_p$ and $c_v$:

$$
\begin{equation}
    \gamma = \frac{c_p}{c_v}
\end{equation}
$$

Since we have $\rho,u,v,p,T$ 5 variables, and 4 equations, we need to add one more equation to close the system. The equation is called the state equation:

$$
\begin{equation}
    p = \rho R T
\end{equation}
$$

Moreover, here gives a variable denoted as $H$, which means the enthalpy of the fluid, and it is defined as:

$$
\begin{equation}
    H = E + \frac{p}{\rho} = \frac{\gamma p}{\rho(\gamma - 1)} + \frac{1}{2}(u^2 + v^2)
\end{equation}
$$