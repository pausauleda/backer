Crea sucesivas copias incrementales de los directorios indicados. Para los ficheros que no han sido modificados se crean hardlinks, por lo que sólo ocupa espacio en disco el contenido nuevo.

Dado que los hardlinks sólo se borran al borrar el último enlace, podemos borrar copias anteriores o intermedias sin problemas de integridad en las copias posteriores.
