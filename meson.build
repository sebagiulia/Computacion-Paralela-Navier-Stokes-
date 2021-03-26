project('tiny_ising', 'c',
        default_options: [ 'c_std=c11', 'warning_level=2' ]
)

cc = meson.get_compiler('c')

headless = executable('headless',
    [ 'headless.c', 'solver.c', 'wtime.c' ]
)

gl_dep = cc.find_library('GL', required: false)
glu_dep = cc.find_library('GLU', required: false)
glut_dep = cc.find_library('glut', required: false)

demo = executable('demo',
    [ 'demo.c', 'solver.c', 'wtime.c' ],
    dependencies: [ gl_dep, glu_dep, glut_dep ]
)
