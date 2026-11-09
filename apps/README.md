# apps

Micro frontends Angular con Native Federation. Cada subcarpeta es una app independiente y un scope
de commit propio.

| App | Rol |
|---|---|
| `mf-shell` | Host de plataforma: carga los remotos desde un manifiesto e inyecta `env.js` |
| `mf-clientes` | Remoto del módulo de clientes: lista de clientes y sus órdenes |

Hoy no hay apps creadas.

## Cómo las encuentra `make check`

Toda subcarpeta con `package.json` se verifica con esta cadena, en orden:

```bash
npm ci
npm run lint --if-present
npm test
npm run build
```

Si algún paso falla, `make check` falla. Una app nueva solo necesita su `package.json` con los
scripts `test` y `build` para entrar a la verificación.
