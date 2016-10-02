function [iter, x1] = max_descent (maxIter, alpha, grad_fun, x0)
  ## grad_fun{1} sera la derivada en x, grad_fun{2} en y
  ## x0 un vector [x y] que lo transformo a (x,y) con num2cell
  tol = 0.0001;
  iter = 1;
  grad_eval = [ grad_fun{1}(num2cell(x0){:}), ...
                grad_fun{2}(num2cell(x0){:}) ];

  while (norm(grad_eval) >= tol && iter < maxIter)
    ## siempre minimizamos
    x1 = x0 - alpha * grad_eval;

    ## Calcula con respecto a la nueva posicion. los (...) continua nueva
    ## linea
    grad_eval = [ grad_fun{1}(num2cell(x1){:}), ...
                  grad_fun{2}(num2cell(x1){:}) ];
    x0 = x1;
    iter = iter + 1;
  end

end
