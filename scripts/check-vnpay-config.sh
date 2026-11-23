#!/usr/bin/env bash
set -u

if [[ "$(uname -s)" != Linux ]]; then
    printf 'Run this check inside Ubuntu/WSL.\n' >&2
    exit 1
fi

if [[ -f .env ]]; then
    set -a
    # The local .env file is trusted input owned by the developer.
    source .env
    set +a
fi

missing=0
for name in VNPAY_TMN_CODE VNPAY_HASH_SECRET VNPAY_IPN_URL VNPAY_RETURN_URL; do
    if [[ -n "${!name:-}" ]]; then
        printf 'OK      %s\n' "$name"
    else
        printf 'MISSING %s\n' "$name"
        missing=1
    fi
done

for name in VNPAY_IPN_URL VNPAY_RETURN_URL; do
    value="${!name:-}"
    if [[ -n "$value" && "$value" != https://* ]]; then
        printf 'INVALID %s must use HTTPS\n' "$name"
        missing=1
    fi
    if [[ "$value" == *your-public-domain.example* ]]; then
        printf 'INVALID %s still contains the example domain\n' "$name"
        missing=1
    fi
done

if (( missing != 0 )); then
    printf '\nVNPAY sandbox setup is incomplete. See docs/vnpay-readiness.md.\n' >&2
    exit 1
fi

printf '\nConfiguration fields are present. Verify public IPN delivery with a sandbox transaction.\n'
