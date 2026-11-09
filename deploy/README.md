# deploy

Manifiestos de despliegue con Kustomize. Hoy la carpeta está vacía: los manifiestos llegan cuando
existan los servicios.

## Estructura prevista

```
deploy/
├─ base/                 Kubernetes puro, sin recursos de nube
│  ├─ plataforma/        mf-shell, ms-clientes
│  ├─ modulo-clientes/   mf-clientes, bff
│  └─ dominio/           ms-ordenes
└─ overlays/
   ├─ local/             podman: 1 réplica, puertos publicados
   └─ <nube>/            por decidir (S3, EKS u otro)
```

- Un Deployment y un Service ClusterIP por servicio.
- Un ConfigMap global de plataforma y uno por servicio. Los secretos nunca van en ConfigMaps ni en
  el repo.
- El destino en la nube es una decisión abierta: se agrega como overlay sin tocar la base.

`make check` no verifica esta carpeta.
