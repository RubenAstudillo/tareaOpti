function [iter, x1] = levenbert (maxIter, alpha, lambda, hessian_fun, ...
                                 grad_fun, x0)
  tol = 0.0001;
  iter = 1;
  grad_eval = [ grad_fun{1}(num2cell(x0){:}), ...
                grad_fun{2}(num2cell(x0){:}) ];
  hessian_eval = [ hessian_fun{1,1}(num2cell(x0){:}), ...
                   hessian_fun{1,2}(num2cell(x0){:}); ...
                   hessian_fun{2,1}(num2cell(x0){:}), ...
                   hessian_fun{2,2}(num2cell(x0){:}) ];

  while (norm(grad_eval) >= tol && iter < maxIter)
    ## pregunta dos tienen una funcion que me molesta invertir... esto
    ## puede afectar la estabilidad numerica
    x1 = x0 - alpha * grad_eval * inv(lambda * eye(2) + hessian_eval);

    grad_eval = [ grad_fun{1}(num2cell(x1){:}), ...
                  grad_fun{2}(num2cell(x1){:}) ];
    hessian_eval = [ hessian_fun{1,1}(num2cell(x1){:}), ...
                     hessian_fun{1,2}(num2cell(x1){:}); ...
                     hessian_fun{2,1}(num2cell(x1){:}), ...
                     hessian_fun{2,2}(num2cell(x1){:}) ];
    x0 = x1;
    iter = iter + 1;
  end
end
