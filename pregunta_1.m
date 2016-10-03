# idealmente correr con octave --no-gui pregunta_1.m
x0  = [1.5, 2.5];
maxIter = 10000

primer_ej             = @(x,y) -10 + x^2 + y^2;
grad_primer_ej        = { @(x,y) 2*x, @(x,y) 2*y };
inv_hessian_primer_ej = { @(x,y) 0.5, @(x,y) 0; @(x,y) 0, @(x,y) 0.5 };
printSpec = 'alpha = %.2f, iteraciones = %5d, final = (%.2f, %.2f)';

sprintf('Maximo descenso ejemplo1: x0 = (%.2f, %.2f)', x0(1), x0(2))
for alpha = [0.1 0.2 0.3 0.5 0.7 0.75 0.8 0.85 0.9 0.95 0.98 1 1.2]
  [ iter, x1 ] = max_descent(maxIter, alpha, grad_primer_ej, x0);
  sprintf(printSpec, alpha, iter, x1(1), x1(2))
end
sprintf('ultimo caso hay divergencia. Convergencia si alpha < 1 \n')


## En newton con alpha < 2 converge y alpha=2 diverge
sprintf('newton ejemplo1: x0 = (%.2f, %.2f)', x0(1), x0(2))
for alpha = [1 1.2 1.4 1.6 1.8 1.90 1.95 1.99 2 2.1]
  [ iter, x1 ] = newton(maxIter, alpha, inv_hessian_primer_ej, ...
                        grad_primer_ej, x0);
  sprintf(printSpec, alpha, iter, x1(1), x1(2))
end
sprintf('ultimo caso hay divergencia. Convergencia si alpha < 2 \n')

# ejemplo 2
segundo_ej             = @(x,y) -10 + 3*x^2 + y^2;
grad_segundo_ej        = { @(x,y) 6*x, @(x,y) 2*y };
inv_hessian_segundo_ej = { @(x,y) (1/6), @(x,y) 0; @(x,y) 0, @(x,y) 0.5 };
printSpecAlt = 'alpha = %.5f, iteraciones = %5d, final = (%.2f, %.2f)';

sprintf('maximo descenso ejemplo2: x0 = (%.2f, %.2f)', x0(1), x0(2))
for alpha = [0.2 0.25 0.3 0.32 0.33 (1/3) 0.35]
  [ iter, x1 ] = max_descent(maxIter, alpha, grad_segundo_ej, x0);
  sprintf(printSpecAlt, alpha, iter, x1(1), x1(2))
end
sprintf('ultimo caso hay divergencia. Convergencia si alpha < (1/3) \n')

sprintf('newton ejemplo2: x0 = (%.2f, %.2f)', x0(1), x0(2))
for alpha = [1.4 1.6 1.8 1.9 1.95 1.98 1.99 2 2.1]
  [ iter, x1 ] = newton(maxIter, alpha, inv_hessian_segundo_ej, ...
                        grad_segundo_ej, x0);
  sprintf(printSpec, alpha, iter, x1(1), x1(2))
end
sprintf('ultimo caso hay divergencia. Convergencia si alpha < 2 \n')
