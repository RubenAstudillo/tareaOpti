clear all
clc

%datos que deben ser agregados por el usuario

Max=0;
g=@(x1,x2) -10+(x1)^2+(x2)^2;     %funcion en varias variables
grad={@(x1,x2) 2*x1+0*x2,@(x1,x2) 2*x2+0*x1}; %gradiente de la funcion
x0=[1.5;-2.5];  %punto inicial
Tol=0.0001;     %tolerancia del algoritmo
MaxIter=100;    %numero de iteraciones maximas

Fgrad=[grad{1}(x0(1,1),x0(2,1))
       grad{2}(x0(1,1),x0(2,1))];  %se evalua el gradiente en el punto inicial

% Condicion de max o min
if Max==1
    Fgrad=Fgrad;
else
    Fgrad=-Fgrad;
end
iter=1;

while norm(Fgrad)>=Tol && iter<=MaxIter
    alpha=0.3;
    D(iter,:)={iter,x0,Fgrad}   %almacenamiento de datos
    x1=x0+alpha*Fgrad;
    Fgrad=[grad{1}(x1(1,1),x1(2,1))
           grad{2}(x1(1,1),x1(2,1))];
   if Max==1
    Fgrad=Fgrad;
   else
    Fgrad=-Fgrad;
   end
    iter=iter+1;
    D(iter,:)={iter,x1,Fgrad}
    x0=x1;
end   
       
    
