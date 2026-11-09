# services

Servicios Spring Boot (Java 21). Cada subcarpeta es un servicio independiente con su Maven Wrapper
y un scope de commit propio.

| Servicio | Rol |
|---|---|
| `bff` | Única API del frontend; orquesta los microservicios |
| `ms-clientes` | Clientes (plataforma, compartido) |
| `ms-ordenes` | Órdenes por cliente (dominio) |

Los microservicios no se llaman entre sí: los coordina el BFF. Hoy no hay servicios creados.

## Cómo los encuentra `make check`

Toda subcarpeta con `mvnw` se verifica con:

```bash
./mvnw -B verify
```

Si falla, `make check` falla. El `mvnw` tiene que tener permiso de ejecución.
