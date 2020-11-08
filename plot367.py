import numpy as np
import matplotlib.pyplot as plt

def levelset(xs, ys, x, y, f, grad_f):
    gridx, gridy = np.meshgrid(xs, ys)
    c = f(x, y)
    grad = grad_f(x, y)
    tangent = -grad[0]/grad[1] * (xs - x) + y
    plt.contour(xs, ys, f(gridx, gridy), [c-5, c, c+5])
    plt.quiver(x, y, grad[0], grad[1])
    plt.plot(xs, tangent, '--', linewidth=2)
    plt.ylim([np.min(ys), np.max(ys)])
    
def linearapprox(xs, ys, x, y, f, grad_f):
    fig = plt.figure()
    ax = fig.gca(projection='3d')
    ax.view_init(30, -50)
    gridx, gridy = np.meshgrid(xs, ys)
    gridz = f(gridx, gridy)
    grad = grad_f(x, y)
    tangent = lambda xn, yn: f(x, y) + (xn - x) * grad[0] + (yn - y) * grad[1]
    ax.plot_surface(gridx, gridy, f(gridx, gridy), zorder=1, alpha=0.4)
    ax.contour(xs, ys, gridz, offset=np.min(gridz), zorder=-1)
    ax.plot_surface(gridx, gridy, tangent(gridx, gridy), zorder=2, alpha=0.5)
    ax.plot3D(x, y, f(x, y), zorder=2, marker='o', c='r')

def quadraticapprox(xs, ys, x, y, f, grad_f, hessian_f):
    def f_hat(xn, yn):
        grad = grad_f(x, y)
        hessian = hessian_f(x, y)
        xs = np.array([[xn], [yn]])
        x0 = np.array([[x], [y]])
        return (f(x, y) + np.dot(grad.T, (xs - x0)) + 1/2 * (xs-x0).T.dot(hessian).dot(xs - x0))
    fig = plt.figure()
    ax = fig.gca(projection='3d')
    ax.view_init(30, -50)
    gridx, gridy = np.meshgrid(xs, ys)
    gridz = f(gridx, gridy)
    ax.plot_surface(gridx, gridy, f(gridx, gridy), zorder=1, alpha=0.4)
    ax.contour(xs, ys, gridz, offset=np.min(gridz), zorder=-1)
    ax.plot_surface(gridx, gridy, np.vectorize(f_hat)(gridx, gridy), zorder=2, alpha=0.5)
    ax.plot3D(x, y, f(x, y), zorder=2, marker='o', c='r')
