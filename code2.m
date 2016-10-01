for (i=1:1:30)
    x(i)=-3+i*0.2;
    y(i)=-3+i*0.2;
end

for (i=1:1:30)
    for(j=1:1:30)
        z(j,i)=f(x(i),y(j));
    end
end

figure
meshc(x,y,z)
view(-47,25)

figure
contour(x,y,z);
%Ponemos un título al gráfico de la figura
title('Curvas de nivel')
hold on
u=1.5;v=-2.5;
plot(u,v,'o');
alpha = 0.9;
quiver(u,v,-2*u*alpha,-2*v*alpha)
hold off

figure
contour(x,y,z);
%Ponemos un título al gráfico de la figura
title('Curvas de nivel con secuencia de puntos')
hold on
for(i=1:1:iter)
    plot(D{i,2}(1),D{i,2}(2),'o');
end
hold off

