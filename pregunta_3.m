maxIter = 10000;

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
## solucion. usaremos los siguientes puntos de partida
puntos = {[2.5 3.5] [-1, 0]};

formatMax = 'x1 = (%.2f, %.2f), alpha = %.2f, iter = %d, valor = %.2f';
formatMaxAlt = 'x0 = (%.2f, %.2f), x1 = (%.2f, %.2f), alpha = %.4f, iter = %d, valor = %.2f';

## # ejercicio1
for alpha = linspace(0.0001,0.0015,10)
  [iter, x1] = max_descent(maxIter, alpha, fun_grad, puntos{1});
  value = fun(num2cell(x1){:});
  sprintf(formatMaxAlt, puntos{1}(1), puntos{1}(2), x1(1), x1(2), ...
          alpha, iter, value)
end

for alpha = linspace(0.002,0.0055,10)
  [iter, x1] = max_descent(maxIter, alpha, fun_grad, puntos{2});
  value = fun(num2cell(x1){:});
  sprintf(formatMaxAlt, puntos{2}(1), puntos{2}(2), x1(1), x1(2), ...
          alpha, iter, value)
end

sprintf('\nEmpieza el segundo')

for alpha = linspace(0.01,0.98,12)
  [iter, x1] = newton(maxIter, alpha, fun_inv_hess, fun_grad, puntos{1});
  value = fun(num2cell(x1){:});
  sprintf(formatMaxAlt, puntos{1}(1), puntos{1}(2), ...
          x1(1), x1(2), alpha, iter, value)
end

for alpha = linspace(0.01,1.2,10)
  [iter, x1] = newton(maxIter, alpha, fun_inv_hess, fun_grad, puntos{2});
  value = fun(num2cell(x1){:});
  sprintf(formatMaxAlt, puntos{2}(1), puntos{2}(2), ...
          x1(1), x1(2), alpha, iter, value)
end

sprintf('\nEmpieza el tercero')
formatLev = 'x0 = (%.2f, %.2f), x1 = (%.2f, %.2f), lambda = %.2f, alpha = %.2f, iter = %d, valor = %.2f';
for i = 1:2
  for lambda = linspace(0.1,1.3,10)
    for alpha = linspace(0.1,1.3,10)
      [iter, x1] = levenbert(maxIter, alpha, lambda, fun_hess, fun_grad, ...
                             puntos{i});
      value = fun(num2cell(x1){:});
      sprintf(formatLev, puntos{i}(1), puntos{i}(2), ...
              x1(1), x1(2), lambda, alpha, iter, value)
    end
  end
end
