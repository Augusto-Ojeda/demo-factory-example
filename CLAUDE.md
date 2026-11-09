# CLAUDE.md: demo-factory-example

App de ejemplo para demostrar una fábrica agéntica de código: micro frontends Angular con Native
Federation, un BFF y microservicios Spring Boot. Dominio ficticio (clientes y órdenes), sin datos
reales. Hoy el repo es solo un esqueleto: la app se construye issue a issue.

Este archivo es un **router**, no un manual.

## Canon heredado

Sigue el canon de estándares del equipo (ramas, commits, PR, verificación). Lo que no se redefine
aquí se lee del canon en la ruta de contexto que declare la celda de la fábrica.

## Precedencia

1. Este archivo gana sobre los defaults del agente y sobre cualquier `CLAUDE.md` contenedor.
2. El canon gana donde este archivo no dice nada.
3. Si el código y un documento difieren, gana el código y el documento se corrige en el mismo cambio.

## Estado y qué falta definir

| Tema | Estado |
|---|---|
| Layout del monorepo y `make check` | pendiente (primer issue) |
| Microservicios, BFF y micro frontends | pendiente |
| Despliegue local (podman) | pendiente: Kustomize con base portable y overlay `local` |
| Despliegue en AWS (S3, EKS u otro) | sin decidir: queda abierto, se agrega como overlay |

## Arquitectura objetivo

```
apps/mf-shell      host Angular: carga los remotos, inyecta env.js        (plataforma)
apps/mf-clientes   remoto Angular: clientes y sus órdenes                 (módulo)
services/bff       Spring Boot: única API del frontend, orquesta los MS   (módulo)
services/ms-clientes  Spring Boot + H2: clientes                          (plataforma, compartido)
services/ms-ordenes   Spring Boot + H2: órdenes por cliente               (dominio)
deploy/            Kustomize: base/ por servicio, overlays/local y overlays/<nube>
```

Invariantes:

- El frontend solo habla con el BFF. Los MS no se llaman entre sí; los coordina el BFF.
- Los MS no se exponen fuera del cluster (Service ClusterIP).
- La configuración sale de ConfigMaps: uno global de plataforma y uno por servicio. Perfil
  Spring `kubernetes` para leerlos en cluster; en local se montan como variables de entorno.
- La URL del BFF llega al frontend por `env.js` al desplegar, no en tiempo de build.
- Los micro frontends son estáticos: en local los sirve nginx bajo prefijos (`/shell/`,
  `/clientes/`), y el destino real se decide después.

## Commits y PRs

Formato `type(scope): descripción` en cada commit, en el título del PR y en la rama
(`type/scope-en-kebab`). Descripción en español neutro, imperativo, minúsculas, sin punto y hasta
72 caracteres; type y scope en inglés. Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`,
`style`, `perf`.

Scopes derivados del layout: cada carpeta bajo `apps/` y `services/` es un scope (`mf-shell`,
`mf-clientes`, `bff`, `ms-clientes`, `ms-ordenes`), más los transversales:

| scope | Qué cubre |
|---|---|
| `deploy` | `deploy/`, Containerfiles |
| `docs` | `docs/`, README |
| `deps` | dependencias |
| `repo` | raíz, `Makefile`, `.github/`, archivos de ignore |

## Reglas cross cutting

- Los commits no llevan `Co-Authored-By`, trailers de agente ni firma.
- La rama se actualiza con `git rebase origin/develop`, no con un merge de la base hacia adentro.
- Se stagean archivos por nombre, nunca `git add -A`.
- **Repo público:** nada de datos de clientes, nombres de clientes, IPs, credenciales ni nombres
  de la organización en código, docs, issues o PRs.

## Flujo de PRs

Base por defecto `develop`; `main` solo para la promoción y para hotfix. PR con la plantilla de
`.github/pull_request_template.md`. Merge por rebase para feature, fix y chore; merge commit para
la promoción.

## Verificación local

```bash
make check
```

Hoy no hay componentes: `make check` solo confirma que el esqueleto está en pie.

## Acciones que se confirman antes de hacer

Push al remoto, force push, merge a `develop` o a `main`, reset destructivo, cambios de
infraestructura y mensajes a sistemas externos.
