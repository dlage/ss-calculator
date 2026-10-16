# SS Calculator

SS Calculator runs on Ruby 3.4.11, Rails 8.1 and PostgreSQL. JavaScript and CSS use esbuild through jsbundling-rails and cssbundling-rails. Bootstrap 4 and Turbolinks are retained to preserve the existing templates and navigation behavior.

## Development and tests

Install Ruby 3.4.11, Node 22 or newer, PostgreSQL and native gem dependencies (`libpq-dev`, `libicu-dev`, `libyaml-dev`, a C/C++ toolchain). `ops/install-ruby.sh` builds the checksum-verified Ruby release under `/opt/ruby/3.4.11` on Ubuntu; run it as root after installing its documented dependencies.

Create a local PostgreSQL role matching your operating-system username, with permission to create disposable test databases. Then run:

```sh
bundle install
npm ci
npm run build
npm run build:css
bundle exec rails db:prepare
bin/check
```

`DATABASE_URL` selects the development or production database. Tests use `TEST_DATABASE_URL` or the local `ss_calculator_test` database, independently of `DATABASE_URL`. Rails tests recreate fixture data; always use a disposable test database. `TEST_WORKERS` defaults to 2.

`bin/check` builds assets, prepares the test schema, checks autoloading and runs model/integration tests covering contribution calculations, table rendering, user/admin authentication and the admin import screen.

For local Docker development, run `docker compose run --rm web bundle exec rails db:prepare` and `docker compose up`. Docker is optional; apps01 runs Apache/Passenger directly inside its Ubuntu LXC.

## Ubuntu deployment preparation

The `codex/ubuntu-upgrade` branch prepares deployment to apps01 (CT 620, 92.222.193.105). `config/deploy/apps01.rb` is a separate Capistrano stage; the existing staging stage retains its original target. The app account is `ss-calculator`, and its release layout is `/srv/www/ss-calculator-staging/{releases,shared,current}`. Apache must select `/opt/ruby/3.4.11/bin/ruby` explicitly. Install current Passenger packages from its signed Ubuntu 26.04 APT repository, then run `ops/prepare-passenger.sh` as root. This builds the app account’s native extension before Apache starts it with a read-only home directory.

Before a real deployment, push and review this branch, provision a fresh per-app bundle on apps01, configure the deployment key/agent, and set the shared environment and credentials, including `APP_HOST=ss-calc-staging.lage.pw` for the staging hostname. The repository's legacy encrypted credentials file must be paired with its actual master key or replaced deliberately. Rails 8 no longer reads the legacy `secrets.yml` API: preserve the old application's effective `secret_key_base` through `SECRET_KEY_BASE` at cutover if existing sessions must remain valid. Never commit credentials or keys.

The preparation environment uses a local `ss_calculator_rehearsal` database copied from the source and a separate disposable test database. Set `APP_REHEARSAL=1` to disable external mail delivery and use the test job adapter. The container firewall also blocks outgoing SMTP and remote database/Redis connections during rehearsal. Remove that restriction only when the intended real service dependencies are configured.

The user-account model previously enabled Devise confirmation, locking and tracking without the corresponding database columns. The upgrade includes an additive migration to supply those columns. The source database had no User rows at inspection. Apply and verify this migration on the clone before cutover; keep its schema change in the production migration checklist.

SassC and its FFI dependency load only during asset builds and in development/tests. Production precompilation requires `RAILS_GROUPS=assets bundle exec rails assets:precompile`; the Capistrano command environment sets this automatically. Keep `RAILS_GROUPS` out of Apache’s runtime environment so its memory protection can remain enabled.

Rails retains the original `config.load_defaults 6.0` behavior during this compatibility upgrade. Adopt newer framework defaults separately after testing their behavior changes.

## Cutover

Preparation does not change public DNS or the old application's release. Before cutover:

1. Review test results and exercise the calculator and authenticated admin/import workflows on apps01.
2. Preserve the effective signing/encryption secrets, take a fresh database backup and final mutable-file sync, and verify the intended database endpoint.
3. Apply the tested additive account migration to the intended database. Do not use the stale rehearsal copy as the new live database without a final synchronized migration.
4. Configure TLS renewal through the actual ingress. The preparation copy of the existing certificate is not an independent renewal setup.
5. Freeze old writes, switch ingress/DNS and verify traffic, login, calculations and admin changes. Keep a rollback route that accounts for any new writes.

See the infrastructure repository's `docs/infrastructure/usaserver4-app-migration-plan.md` for the broader migration and rollback procedure.

## Published reference data

The sourced 2024–2026 tables are in `db/data/tax_references.csv`. After restoring a database or preparing a fresh one, run `bundle exec rails tax_references:import_published`. This fills missing years without overwriting existing values. See [source amounts and future-year policy](db/data/README.md).
