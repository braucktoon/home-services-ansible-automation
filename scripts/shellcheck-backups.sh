#!/usr/bin/env bash
# Render Jinja2 backup templates with placeholder values and run shellcheck.
# Jinja2 syntax is replaced so shellcheck sees valid bash.
# SC1091 (can't follow source) is suppressed since the lib is also rendered.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SHELLCHECK="${SHELLCHECK:-shellcheck}"

TEMPLATES=(
    "roles/backup-common/templates/backup-lib.sh.j2"
    "templates/backup-basic-docker.sh.j2"
    "roles/pihole/templates/backup-pihole.sh.j2"
    "roles/media/templates/backup-media.sh.j2"
)

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

# Replace {{ variable }} and {{ variable | filter }} with a safe placeholder,
# and strip {% ... %} control blocks so shellcheck sees clean bash.
render_j2() {
    local src="$1"
    local dst="$2"
    sed \
        -e 's/{{[^}]*}}/placeholder/g' \
        -e 's/{%[^%]*%}//g' \
        -e "s|source /usr/local/lib/backup-lib.sh|source $TMPDIR/backup-lib.sh|g" \
        "$src" > "$dst"
}

# Render the lib first so shellcheck can follow the source directive
render_j2 "$REPO_ROOT/roles/backup-common/templates/backup-lib.sh.j2" "$TMPDIR/backup-lib.sh"

PASS=0
FAIL=0
ERRORS=()

for template in "${TEMPLATES[@]}"; do
    rendered="$TMPDIR/$(basename "$template" .j2).sh"
    render_j2 "$REPO_ROOT/$template" "$rendered"

    printf "shellcheck: %-55s " "$template"
    if "$SHELLCHECK" \
            --shell=bash \
            --severity=warning \
            --external-sources \
            --exclude=SC1091 \
            "$rendered"; then
        echo "OK"
        (( PASS++ )) || true
    else
        echo "FAIL"
        ERRORS+=("$template")
        (( FAIL++ )) || true
    fi
done

echo ""
echo "Results: ${PASS} passed, ${FAIL} failed"

if (( FAIL > 0 )); then
    echo "Failed templates:"
    for e in "${ERRORS[@]}"; do echo "  - $e"; done
    exit 1
fi
