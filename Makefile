# Verificación única del repo: `make check`.
#
# Descubre componentes por convención y corre la cadena de cada uno:
#   services/<x>/ con mvnw        -> ./mvnw -B verify
#   apps/<x>/ con package.json    -> npm ci, npm run lint --if-present, npm test, npm run build
# Sin componentes termina en verde y lo informa. Si un componente falla, falla.
# Antes corre una autoprueba (`selftest`) contra los fixtures de tests/make-check/ que demuestra
# que la verificación falla cuando un componente falla.

SHELL := /bin/sh

SERVICES_DIR ?= services
APPS_DIR ?= apps
SELFTEST_DIR ?= tests/make-check

.PHONY: check selftest verify-components

check:
	@$(MAKE) -s --no-print-directory selftest
	@$(MAKE) -s --no-print-directory verify-components

verify-components:
	@found=0; \
	for d in $(SERVICES_DIR)/*/; do \
	  [ -f "$${d}mvnw" ] || continue; \
	  found=1; \
	  echo "==> servicio $$d: ./mvnw -B verify"; \
	  (cd "$$d" && ./mvnw -B verify) || { echo "make check: falló el servicio $$d"; exit 1; }; \
	done; \
	for d in $(APPS_DIR)/*/; do \
	  [ -f "$${d}package.json" ] || continue; \
	  found=1; \
	  echo "==> app $$d: npm ci, lint, test, build"; \
	  (cd "$$d" && npm ci && npm run lint --if-present && npm test && npm run build) \
	    || { echo "make check: falló la app $$d"; exit 1; }; \
	done; \
	if [ "$$found" -eq 0 ]; then echo "make check: no hay componentes que verificar"; fi

selftest:
	@sub="$(MAKE) -s --no-print-directory verify-components"; \
	fx="$(SELFTEST_DIR)"; \
	echo "==> autoprueba de make check (fixtures en $$fx)"; \
	out=$$($$sub SERVICES_DIR="$$fx/sin-componentes" APPS_DIR="$$fx/sin-componentes" 2>&1) \
	  || { echo "$$out"; echo "autoprueba: sin componentes debió terminar en 0"; exit 1; }; \
	echo "$$out" | grep -q "no hay componentes que verificar" \
	  || { echo "$$out"; echo "autoprueba: falta el aviso de que no hay componentes"; exit 1; }; \
	echo "    ok: sin componentes termina en 0 y lo informa"; \
	if out=$$($$sub SERVICES_DIR="$$fx/servicio-falla/services" APPS_DIR="$$fx/sin-componentes" 2>&1); then \
	  echo "$$out"; echo "autoprueba: un servicio que falla debió hacer fallar la verificación"; exit 1; fi; \
	echo "$$out" | grep -q "MARCA-MVNW -B verify" \
	  || { echo "$$out"; echo "autoprueba: la falla no vino de ./mvnw -B verify"; exit 1; }; \
	echo "    ok: un servicio que falla hace fallar la verificación"; \
	if out=$$(npm_config_audit=false npm_config_fund=false npm_config_update_notifier=false \
	  $$sub SERVICES_DIR="$$fx/sin-componentes" APPS_DIR="$$fx/app-falla/apps" 2>&1); then \
	  echo "$$out"; echo "autoprueba: una app que falla debió hacer fallar la verificación"; exit 1; fi; \
	echo "$$out" | grep -q "MARCA-NPM-TEST" \
	  || { echo "$$out"; echo "autoprueba: la falla no vino de npm test"; exit 1; }; \
	echo "    ok: una app que falla hace fallar la verificación"
