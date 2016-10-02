primer_ej = @(x,y) -10 + x^2 + y^2;
grad_primer_ej = { @(x,y) 2*x, @(x,y) 2*y };
inv_hessian_primer_ej = { @(x,y) 0.5, @(x,y) 0; @(x,y) 0, @(x,y) 0.5 };

## En maximo descenso, notamos que para alpha=1 diverge, para alpha < 1
## converge eventualmente
%% [ iter, x1 ] = max_descent(10000, 0.9, grad_primer_ej, [1.5, 2.5])
%% [ iter, x1 ] = max_descent(10000, 1, grad_primer_ej, [1.5, 2.5])

## En newton con alpha < 2 converge y alpha=2 diverge
%%[ iter, x1 ] = newton(10000, 1.99, inv_hessian_primer_ej, ...
                      %%grad_primer_ej, [1.5, 2.5])
%%[ iter, x1 ] = newton(10000, 2, inv_hessian_primer_ej, ...
                      %%grad_primer_ej, [1.5, 2.5])

segundo_ej = @(x,y) -10 + 3*x^2 + y^2;
grad_segundo_ej = { @(x,y) 6*x, @(x,y) 2*y };
inv_hessian_segundo_ej = { @(x,y) (1/6), @(x,y) 0; @(x,y) 0, @(x,y) 0.5 };

## En maximo descenso, notamos que para alpha=0.34 diverge, para alpha < 0.34
## converge eventualmente. Si superamos este valor diverge pero no en
## cantidad de operaciones si no numericamente, resultando en NaN
## [ iter, x1 ] = max_descent(10000, 0.33, grad_segundo_ej, [1.5, 2.5])
## [ iter, x1 ] = max_descent(10000, 0.34, grad_segundo_ej, [1.5, 2.5])

## En newton con alpha < 2 converge y alpha=2 diverge
## [ iter, x1 ] = newton(10000, 1.99, inv_hessian_segundo_ej, ...
##                       grad_segundo_ej, [1.5, 2.5])
## [ iter, x1 ] = newton(10000, 2, inv_hessian_segundo_ej, ...
##                       grad_segundo_ej, [1.5, 2.5])
