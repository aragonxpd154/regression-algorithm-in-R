from vpython import sphere, vector, color, mag
import math

G = 6.67e-11
M = 2e30
rdist = 2e10
dt = 1  # delta time in seconds

star1 = sphere(pos=vector(-rdist, 0, 0), radius=4e9, color=color.yellow, make_trail=True)
star2 = sphere(pos=vector(2 * rdist, 0, 0), radius=9e8, color=color.cyan, make_trail=True)
star1.m = 2 * M
star2.m = M

star1.p = vector(0, 0, 0)
star2.p = vector(0, 0, 0)


while True:
    r = star2.pos - star1.pos
    f = G * ((star1.m * star2.m * r ) / mag(r)**3)
    star1.p = star1.p + f * dt
    star1.pos = star1.pos + star1.p / star1.m * dt
    star2.p = star2.p - f * dt
    star2.pos = star2.pos + star2.p / star2.m * dt
    rate(100)  # adjust this value to control the simulation speed

