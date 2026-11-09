# tests/make-check

Fixtures de la autoprueba de `make check` (target `selftest` del `Makefile`). Son componentes
falsos que demuestran que la verificación hace lo que promete:

| Fixture | Contiene | Se espera |
|---|---|---|
| `sin-componentes/` | Nada que descubrir | Exit 0 y el aviso "no hay componentes que verificar" |
| `servicio-falla/services/falso/` | Un `mvnw` que imprime una marca y sale con 1 | Exit distinto de 0 y la marca con `-B verify` |
| `app-falla/apps/falsa/` | Una app sin dependencias cuyo `npm test` sale con 1 | Exit distinto de 0 y la marca del test |

Son fijos y versionados a propósito: la autoprueba no crea ni borra archivos. La app falsa no
tiene dependencias, así que `npm ci` no deja `node_modules/` (y si lo dejara, `.gitignore` ya lo
ignora).

No son componentes reales: `make check` solo los mira desde `selftest`, nunca desde
`apps/` ni `services/`.
