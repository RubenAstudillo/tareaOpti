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
## solucion. Usaremos el mismo punto de partida en (3,4)
x0 = [2.5 3.5];

[iter, x1] = max_descent(10000, 0.1, fun_grad, x0)
fun(num2cell(x1){:})

[iter, x1] = newton(10000, 0.22, fun_inv_hess, fun_grad, x0)
fun(num2cell(x1){:})

[iter, x1] = levenbert(10000, 0.20, 0.25, fun_hess, fun_grad, x0)
fun(num2cell(x1){:})

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
