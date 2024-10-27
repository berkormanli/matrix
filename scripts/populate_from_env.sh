#!/bin/bash

# Extract environment variables for database
DB_USER="${DB_USER:-your_postgres_user}"
DB_PASSWORD="${DB_PASSWORD:-your_postgres_password}"
DB_NAME="${DB_NAME:-your_postgres_db}"
DB_HOST="${DB_HOST:-postgres}"
DB_PORT="${DB_PORT:-5432}"
CP_MIN="${CP_MIN:-5}"
CP_MAX="${CP_MAX:-10}"

# Extract environment variables for email configuration
SMTP_HOST="${SMTP_HOST:-your.email.server}"
SMTP_PORT="${SMTP_PORT:-587}"
SMTP_USER="${SMTP_USER:-your-email@address.com}"
SMTP_PASS="${SMTP_PASS:-your-email-password}"
REQUIRE_TRANSPORT_SECURITY="${REQUIRE_TRANSPORT_SECURITY:-true}"
NOTIF_FROM="${NOTIF_FROM:-your-from-address@address.com}"
APP_NAME="${APP_NAME:-Attraktor Matrix}"

# Extract environment variables for OIDC configuration
OIDC_IDP_ID="${OIDC_IDP_ID:-keycloak}"
OIDC_IDP_NAME="${OIDC_IDP_NAME:-Attraktor Single Sign-on}"
OIDC_ISSUER="${OIDC_ISSUER:-https://accounts.attraktor.org/realms/attraktor}"
OIDC_CLIENT_ID="${OIDC_CLIENT_ID:-synapse}"
OIDC_CLIENT_SECRET="${OIDC_CLIENT_SECRET:-your-secret}"
OIDC_SCOPES="${OIDC_SCOPES:-["openid", "profile"]}"
OIDC_LOCALPART_TEMPLATE="${OIDC_LOCALPART_TEMPLATE:-{{ user.preferred_username }}}"
OIDC_DISPLAY_NAME_TEMPLATE="${OIDC_DISPLAY_NAME_TEMPLATE:-{{ user.given_name }}}"
OIDC_BACKCHANNEL_LOGOUT="${OIDC_BACKCHANNEL_LOGOUT:-true}"

# Replace placeholders in db.yaml.example and output to db.yaml
sed -e "s|your_postgres_user|$DB_USER|g" \
    -e "s|your_postgres_password|$DB_PASSWORD|g" \
    -e "s|your_postgres_db|$DB_NAME|g" \
    -e "s|postgres|$DB_HOST|g" \
    -e "s|5432|$DB_PORT|g" \
    -e "s|5|$CP_MIN|g" \
    -e "s|10|$CP_MAX|g" \
    ./synapse_data/config/db.yaml.example > ./synapse_data/config/db.yaml

echo "db.yaml has been generated with provided environment variables."

# Replace placeholders in email.yaml.example and output to email.yaml
sed -e "s|your.email.server|$SMTP_HOST|g" \
    -e "s|587|$SMTP_PORT|g" \
    -e "s|your-email@address.com|$SMTP_USER|g" \
    -e "s|your-email-password|$SMTP_PASS|g" \
    -e "s|true|$REQUIRE_TRANSPORT_SECURITY|g" \
    -e "s|your-from-address@address.com|$NOTIF_FROM|g" \
    -e "s|Attraktor Matrix|$APP_NAME|g" \
    ./synapse_data/config/email.yaml.example > ./synapse_data/config/email.yaml

echo "email.yaml has been generated with provided environment variables."

# Replace placeholders in oidc.yaml.example and output to oidc.yaml
sed -e "s|keycloak|$OIDC_IDP_ID|g" \
    -e "s|Attraktor Single Sign-on|$OIDC_IDP_NAME|g" \
    -e "s|https://accounts.attraktor.org/realms/attraktor|$OIDC_ISSUER|g" \
    -e "s|synapse|$OIDC_CLIENT_ID|g" \
    -e "s|your-secret|$OIDC_CLIENT_SECRET|g" \
    -e "s|\[\(\"openid\", \"profile\"\)\]|$OIDC_SCOPES|g" \
    -e "s|{{ user.preferred_username }}|$OIDC_LOCALPART_TEMPLATE|g" \
    -e "s|{{ user.given_name }}|$OIDC_DISPLAY_NAME_TEMPLATE|g" \
    -e "s|true|$OIDC_BACKCHANNEL_LOGOUT|g" \
    ./synapse_data/config/oidc.yaml.example > ./synapse_data/config/oidc.yaml

echo "oidc.yaml has been generated with provided environment variables."