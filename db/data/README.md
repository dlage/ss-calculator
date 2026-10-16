# Published contribution reference years

Verified on 16 October 2026. This dataset fills 2024–2026 for the existing Portuguese domestic-service conventional hourly contribution regime. It does not describe the separate actual-salary regime or pensioner rates.

| Year | Monthly IAS | Hourly contribution base | Employer | Worker | Minimum declared hours |
| --- | ---: | ---: | ---: | ---: | ---: |
| 2024 | €509.26 | €2.94 | 18.9% | 9.4% | 30 |
| 2025 | €522.50 | €3.01 | 18.9% | 9.4% | 30 |
| 2026 | €537.13 | €3.10 | 18.9% | 9.4% | 30 |

The Segurança Social guide specifies the hourly formula `IAS × 12 / (52 × 40)`, a base rounded to cents, and the rates and minimum hours. Its current edition explicitly lists €3.10 for 2026. Apply that formula to the published IAS amounts for the other two years. The app calculates contribution rows from these inputs using its existing calculation and display behavior.

Official sources:

- [Segurança Social practical guide for domestic service](https://www.seg-social.pt/ptss/pssd/documento/cmc1xnoen00dakl2y9vd3tedj), pages 8–10: conventional hourly base, rates, minimum hours and 2026 example.
- [Segurança Social 2025 guide, version 5.41](https://sisscontent.seg-social.pt/documents/10152/14967/1003_inscricao_admissao_cessacao_sd/157365d5-d6de-416b-9ec3-902dd482304d), pages 6–8: €3.01, the same rates, minimum hours and 30-hour contribution example.
- [2024 IAS — Portaria 421/2023](https://diariodarepublica.pt/dr/detalhe/portaria/421-2023-229857697).
- [2025 IAS — Portaria 6-B/2025/1](https://diariodarepublica.pt/dr/detalhe/portaria/6-b-2025-902111932).
- [2026 IAS — Portaria 480-A/2025/1](https://diariodarepublica.pt/dr/detalhe/portaria/480-a-2025-993056222).
- [DGAEP IAS history](https://www.dgaep.gov.pt/index.cfm?OBJID=3E74CF19-DA87-4B8F-81E2-51E0649AAA9F), cross-check of all three monthly amounts.

No official 2027 IAS amount was found as of the verification date. No estimated or placeholder 2027 record is included. Before adding another year, verify the published IAS order and the applicable contribution rules, calculate the rounded hourly base and record the new sources here.

Run `bundle exec rails tax_references:import_published` in the intended environment after taking a database backup. The import is transactional and repeatable: it inserts missing years, skips identical existing years and aborts on differing existing values without overwriting them. The CSV can also be used with the admin import screen after reviewing existing years.
