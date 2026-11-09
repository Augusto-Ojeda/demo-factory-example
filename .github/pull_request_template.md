
## Resumen

<!-- Una a tres frases: qué cambia y por qué. No pegues el diff. -->

## Cambios clave

<!--
Las decisiones o piezas que importan para revisar: la lógica nueva, el tradeoff que
tomaste, el archivo o la función donde está lo no obvio.

No listes todos los archivos modificados ni el diff línea a línea: la plataforma ya
los muestra. Mencionar un archivo sirve solo para guiar al reviewer hacia algo
específico. Si aplica, enlaza el issue (`Closes #NN`).
-->

## Cómo probarlo

<!--
Pasos numerados que el reviewer pueda seguir sin preguntar nada. "Correr la app" no
es un paso: el paso es el comando exacto, la ruta exacta y el resultado que se espera
ver. Reemplaza los de abajo por los reales del repositorio.
-->

1. `<comando de instalación de dependencias>`.
2. `<comando de verificación local>`, en verde.
3. `<comando para levantar el entorno>` y abrir `<ruta o URL concreta>`.
4. `<acción concreta>`: se espera `<resultado observable>`.

## Modo de trabajo

<!--
Los commits no llevan firma de agente. Este bloque es la traza del trabajo asistido:
con cuánta autonomía se produjo el cambio y dónde decidió una persona.
-->

- [ ] Asistido: una persona ejecutó y usó el asistente como apoyo puntual.
- [ ] Delegado: una persona planificó, delegó la ejecución y revisó cada entrega.
- [ ] Autónomo: un agente de larga duración trabajó sobre una especificación cerrada.

Compuertas humanas:

<!--
Una línea por compuerta: quién decidió qué, y en qué momento. Ejemplos:
- Plan revisado antes de empezar.
- Diff leído completo antes de pedir revisión.
- Migración aplicada a mano tras revisión, no por el agente.
Si el cambio toca algo irreversible (producción, datos, accesos), la compuerta va acá.
-->

## Checklist

- [ ] El título sigue `type(scope): descripción` con un `type` y un `scope` del repositorio.
- [ ] La base del PR es la que corresponde al tipo de cambio.
- [ ] La verificación local del repositorio quedó en verde, o el bloqueador está explicado acá.
- [ ] Si el cambio modificó una convención, la documentación del repositorio quedó actualizada en este mismo PR.
- [ ] Sin secretos, credenciales ni datos personales en el diff.

<!--
Acá el repositorio agrega sus propios ítems: las trampas conocidas que ya costaron una
vuelta de revisión. Sirven las que son verificables y específicas ("si tocaste el esquema,
regeneraste los tipos"; "si agregaste una migración, la revisaste antes de commitearla"),
no las genéricas ("código limpio").
-->

## Notas

<!-- Riesgos, decisiones discutibles, cambios incompatibles, follow-ups conscientes. -->
