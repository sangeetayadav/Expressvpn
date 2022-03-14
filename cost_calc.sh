#! /bin/bash
set -o errexit

REPO_NAME=${REPO_NAME:-""}
ORGANIZATION=${ORGANIZATION:-""}
COST_PER_USER=${COST_PER_USER:-"133.70"}

USER=${USER:-""}
ACCESS_TOKEN=${ACCESS_TOKEN:-""}

echo "counting number of active committers..."
curl -i -u $USER:$ACCESS_TOKEN -H "Accept: application/vnd.github.v3+json" https://api.github.com/orgs/$ORGANIZATION/settings/billing/advanced-security > billing.json
TOTAL_ACTIVE_COMMITTERS=$(cat billing.json | jq '.repositories[]  | select(.name == "$ORGANIZATION/$REPO_NAME") | .advanced_security_committers')
echo "total number of active committers are $TOTAL_ACTIVE_COMMITTERS"

echo "counting total cost active committers..."
TOTAL_COST=`echo $TOTAL_ACTIVE_COMMITTERS \* $COST_PER_USER |bc`;
echo "total cost for github advanced security licensing are $TOTAL_COST"

echo "summary..."
echo "XXXX"
