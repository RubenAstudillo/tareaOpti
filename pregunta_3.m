tol = 10000;

fun = @(x,y) 100*(y - x^2)^2 + (1 - x)^2;

fun_grad = {@(x,y) -400*x*(y - x^2) - 2*(1-x), ...
            @(x,y) 200*(y - x^2) };

fun_hess = {@(x,y) -400*y + 1200*x^2 + 2, @(x,y) -400*x; ...
            @(x,y) -400*x, @(x,y) 200 };

fun_inv_hess = ...
  {@(x,y) 200/(200*(-400*y+1200*x^2-2)-160000*x^2), ...
   @(x,y) (400*x)/(200*(-400*y+1200*x^2-2)-160000*x^2); ...
   @(x,y) (400*x)/(200*(-400*y+1200*x^2-2)-160000*x^2), ...
   @(x,y) (-400*y+1200*x^2-2)/(200*(-400*y+1200*x^2-2)-160000*x^2) };

## Suponiendo que queremos minimizar pues asi cerca de (0,0) esta la
## solucion.
x0 = [2.5 3.5];
formatMax = 'x1 = (%.2f, %.2f), alpha = %.2f, iter = %d, valor = %.2f';

# no converge nunca
for alpha = linspace(0.1,1,20)
  [iter, x1] = max_descent(tol, 0.1, fun_grad, x0);
  value = fun(num2cell(x1){:});
  sprintf(formatMax, x1(1), x1(2), alpha, iter, value)
end

# cerca de 0.42 converge
for alpha = linspace(0.4,0.5,10)
  [iter, x1] = newton(tol, alpha, fun_inv_hess, fun_grad, x0);
  value = fun(num2cell(x1){:});
  sprintf(formatMax, x1(1), x1(2), alpha, iter, value)
end

formatLev = 'x1 = (%.2f, %.2f), lambda = %.2f, alpha = %.2f, iter = %d, valor = %.2f';
for lambda = linspace(0.2,0.5,10)
  for alpha = linspace(0.2,0.5,10)
    ## [iter, x1] = levenbert(tol, 0.20, 0.25, fun_hess, fun_grad, x0)
    [iter, x1] = levenbert(tol, alpha, lambda, fun_hess, fun_grad, x0);
    value = fun(num2cell(x1){:});
    sprintf(formatLev, x1(1), x1(2), lambda, alpha, iter, value)
  end
end

## for (i=1:1:100)
##   x(i)=-5+i*0.2;
##   y(i)=-5+i*0.2;
## end

## for (i=1:1:100)
##   for(j=1:1:100)
##     z(j,i) = min( fun(x(i),y(j)), 150);
##   end
## end

## figure
## meshc(x,y,z)
## view(-47,25)
