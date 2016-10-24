syms y(x)

dsolve((x^2)*diff(y) + 14 +10*x*y + (x^2)*(y^2) ==0, y(1) ==1 )
