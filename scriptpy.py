from vpython import sphere, vector, color, graph, gcurve, mag, cross
import math

# Constante gravitacional (consGravitacional)
consGravitacional=6.67e-11

# Massa de duas estrelas (massaEstrelas)
massaEstrelas=2e30

# Distância inicial entre as duas estrelas (rdist)
rdist=2e10

# Cria uma esfera com posição, raio, cor e trail (estrela1)
estrela1=sphere(pos=vector(-rdist,0,0),radius=4e9,color=color.yellow, make_trail=True)

# Cria uma esfera com posição, raio, cor e trail (estrela2)
estrela2=sphere(pos=vector(2*rdist,0,0),radius=9e8,color=color.cyan, make_trail=True)

# Atribui a massa para estrela1
estrela1.m=2*massaEstrelas

# Atribui a massa para estrela2
estrela2.m=massaEstrelas

# Calcula a posição de rcom (center of mass)
rcom=(estrela1.pos*estrela1.m+estrela2.pos*estrela2.m)/(estrela1.m+estrela2.m)

# Cria uma esfera para o center of mass (com)
com=sphere(pos=rcom, radius=8e8, make_trail=True)

# Imprime a posição do rcom
print(rcom)

# Calcula a posição relativa entre estrela1 e estrela2
r=estrela2.pos-estrela1.pos

# Calcula a velocidade inicial da estrela1
v1circle=math.sqrt(consGravitacional*estrela2.m*mag(estrela1.pos)/mag(r)**2)
estrela1.v=vector(-.5*v1circle, 0, 0)

# Atribui a quantidade de momento para estrela1
estrela1.p=estrela1.m*estrela1.v*.7

# Atribui a quantidade de momento para estrela2
estrela2.p=-estrela1.p

# Calcula o mu (massa reduzida)
mu=estrela1.m*estrela2.m/(estrela1.m+estrela2.m)

# Calcula o angular momentum (l)
l = mag(cross(estrela1.pos-estrela2.pos, estrela1.p-estrela2.p))

# Imprime o angular momentum (l)
print(l)

# Cria um gráfico com títulos de eixos x e y (tgraph)
tgraph=graph(xtitle="r", ytitle="Potential")

# Cria uma curva de linha verde para a energia potencial gravitacional (fg)
fg=gcurve(color=color.green, label="Gravitational U")

# Cria uma curva gráfica na cor vermelha, com a legenda "Centrifugal U"
fc=gcurve(color=color.red, label="Centrifugal U")

# Cria uma curva gráfica na cor azul, com a legenda "Effective U"
fU=gcurve(color=color.blue, label="Effective U") 

rr=1e9 # Define a variável "rr" como 1 bilhão

drr=1e8 # Define a variável "drr" como 100 milhões

# Enquanto "rr" for menor que o módulo de "r", o loop será executado
while rr<mag(r):
    # Calcula o valor da energia gravitacional
    UG=-consGravitacional*estrela1.m*estrela2.m/rr
    
    # Calcula o valor da energia centrífuga
    Uc=l**2/(2*mu*rr**2)
    
    # Calcula o valor da energia total
    U=UG+Uc
    
    # Plota a energia gravitacional no gráfico
    fg.plot(rr,UG)
    
    # Plota a energia centrífuga no gráfico
    fc.plot(rr,Uc)
    
    # Plota a energia total no gráfico
    fU.plot(rr,U)
    
    # Incrementa "rr" com "drr"
    rr=rr+drr 
