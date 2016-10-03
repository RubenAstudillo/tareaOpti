## Dices que newton converge bien para muchos alfas.  Que punto de partida y alfas usaste?
## Use 0,0
## Use 2,2
## Y use 50,50
## Creo
## Y alfa entre 0.1 y 1.4
## Mm mm tendré que cachar que onda con esos parámetros
## Con el 1.4 es muy extremadamente oscilante
## Pero converge
## Sii
## Por eso te decia
## Y el metodo de max descenso igual converge
## Y para máximo descenso también converge pero lento ( mas o menos mismos parámetro )
## Pero leeento y para valores qlos de alfa
## Nope
## Alfa le puse 0.001
## Cob alfa 0.1 la wea diverge
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
x0 = [2.5 3.5];
puntos = {[2.5 3.5] [0,0] [5 6] [-1 -4]};

formatMax = 'x1 = (%.2f, %.2f), alpha = %.2f, iter = %d, valor = %.2f';
formatMaxAlt = 'x0 = (%.2f, %.2f), x1 = (%.2f, %.2f), alpha = %.4f, iter = %d, valor = %.2f';

# no converge nunca
for i = 1:4
  for alpha = linspace(0.0001,0.01,100)
    [iter, x1] = max_descent(maxIter, alpha, fun_grad, puntos{i});
    value = fun(num2cell(x1){:});
    sprintf(formatMaxAlt, puntos{i}(1), puntos{i}(2), x1(1), x1(2), ...
            alpha, iter, value)
  end
end

sprintf('\nEmpieza el segundo')

# cerca de 0.42 converge
for i = 1:4
  for alpha = linspace(0.1,0.95,20)
    [iter, x1] = newton(maxIter, alpha, fun_inv_hess, fun_grad, puntos{i});
    value = fun(num2cell(x1){:});
    sprintf(formatMaxAlt, puntos{i}(1), puntos{i}(2), ...
            x1(1), x1(2), alpha, iter, value)
  end
end

sprintf('\nEmpieza el tercero')
formatLev = 'x0 = (%.2f, %.2f), x1 = (%.2f, %.2f), lambda = %.2f, alpha = %.2f, iter = %d, valor = %.2f';
for i = 1:4
  for lambda = linspace(0.2,0.5,10)
    for alpha = linspace(0.2,0.5,10)
      [iter, x1] = levenbert(maxIter, alpha, lambda, fun_hess, fun_grad, ...
                             puntos{i});
      value = fun(num2cell(x1){:});
      sprintf(formatLev, puntos{i}(1), puntos{i}(2), ...
              x1(1), x1(2), lambda, alpha, iter, value)
    end
  end
end
