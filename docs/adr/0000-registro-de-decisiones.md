# 0000. Llevar un registro de decisiones

- **Estado:** Aceptada
- **Fecha:** 2026-11-09

## Contexto

El repo se construye issue a issue, en buena parte por agentes. Varias decisiones de arquitectura
ya están tomadas (micro frontends con Native Federation, un BFF como única API del frontend,
configuración por ConfigMaps, despliegue con Kustomize) y otras quedan abiertas a propósito, como
el destino del despliegue en la nube. Sin un registro, el porqué de cada decisión vive en
conversaciones y tareas que nadie relee, y la discusión se reabre en cada issue nuevo.

El canon del equipo propone registrar las decisiones que cierran una discusión, en un archivo plano
con contexto, decisión, consecuencias y alternativas, y pide elegir un formato y declararlo.

## Decisión

Se lleva un registro de decisiones en `docs/adr/`, con este formato:

- **Un archivo plano por decisión:** `docs/adr/NNNN-slug.md`, numerado de cuatro dígitos desde
  `0000` y con el slug en kebab-case y sin acentos.
- **Secciones:** Estado, Fecha, Contexto, Decisión, Consecuencias y Alternativas.
- **Estados:** Propuesta, Aceptada, Reemplazada por `NNNN`.
- **Inmutable:** una decisión aceptada no se edita. Si cambia, se escribe una nueva que la
  reemplaza y la anterior pasa a "Reemplazada por `NNNN`", con el enlace.
- **Cuándo:** cuando un cambio cierra una discusión que se va a volver a abrir (elegir entre dos
  librerías, fijar un límite entre capas, decidir que algo no se hace). Un cambio que solo
  implementa lo ya decidido no lleva registro.

## Consecuencias

- Quien llega al repo, persona o agente, encuentra el porqué de cada decisión sin buscarlo en el
  historial de tareas.
- Las decisiones que el canon deja abiertas se toman aquí y quedan escritas.
- **Divergencia con el canon:** el canon nombra el archivo plano `adr-NNNN-slug.md`. Aquí se omite
  el prefijo `adr-` porque la carpeta `docs/adr/` ya dice qué es cada archivo. `CLAUDE.md` lo
  declara.
- Cuando la carpeta crezca, se agrega un índice en `docs/README.md`.

## Alternativas

- **Carpeta numerada con `README.md` interno por decisión:** permite adjuntar diagramas y anexos,
  pero es más pesada de lo que este repo necesita hoy.
- **Prefijo `adr-` como en el canon:** redundante dentro de `docs/adr/`.
- **No llevar registro:** el contexto queda disperso en tareas y PRs, y se pierde.
