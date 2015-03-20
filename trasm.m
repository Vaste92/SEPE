%Sistemi Elettrici per l'Energia

%Risoluzione della matrice di trasmissione ed alcuni plot

clear all;

%parametri caratteristici della linea
l=1.2e-3;
c=12e-9;
r=0.1e-3;
%grandezze di esercizio
Vn=380e3;
I=1e3;
w=100*pi;
z=r+1i*w*l;
y=1i*w*c;
k=sqrt(z*y);
zc=sqrt(z/y);
x=0:50:6000; %non aumentare il numero di valutazioni: impalla il PC se hai meno di 8GB di RAM.
n=length(x);
M(2,2)=0;
Wa(:,1)=[Vn; I];
Wp(2,1,n)=0;
for i=1:n
    M=[cosh(k*x(1,i)), zc*sinh(k*x(1,i)); sinh(k*x(1,i))/zc, cosh(k*x(1,i))];
    Wp(:,1,i)=M*Wa;
end;
Ep(1,1:n)=Wp(1,1,:);
Ip(1,1:n)=Wp(2,1,:);
figure(1);
%plot3(x,real(Ep),imag(Ep));
%quiver3(x,1:50:6050,1:50:6050,x,real(Ep),imag(Ep));
quiver3(x,zeros(1,n),zeros(1,n),x,real(Ep),imag(Ep));
figure(2);
plot(x,abs(Ep)); %si noti l'effetto delle onde regressive
figure(3);
plot(x,imag(Ep));
figure(4);
plot(Ep);

%plot 3D includendo il tempo
t=linspace(0,2e-2,n);
amp=abs(Ep).*sqrt(2);
phase=angle(Ep);
N(n,n)=0;
for i=1:i
    T=amp(1,i).*sin(w.*t+phase(1,i));
    N(i,1:n)=T(1,:);
end;
figure(5);
surf(x,t,N);
