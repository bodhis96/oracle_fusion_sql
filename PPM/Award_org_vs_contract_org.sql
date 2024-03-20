SELECT
  gmsahb.id,
  okckhab.contract_number AS contract_number,
  hrouAwardOwnOrg.name AS award_owning_organization,
  hrouContractOwnOrg.name AS contract_owning_organization
FROM
  gms_award_headers_b gmahb
  LEFT JOIN okc_k_headers_all_b okckhab PN gmsahb.id = okckhab.id
  AND okckhab.version_type = 'C'
  LEFT JOIN hr_organization_units hrouAwardOwnOrg ON gmsahb.award_owning_org_id = hrouAwardOwnOrg.organization_id
  LEFT JOIN hr_organization_units hrouContractOwnOrg ON okckhab.owning_org_id = hrouContractOwnOrg.organization_id
WHERE
  1 = 1
  AND hrouAwardOwnOrg.name <> hrouContractOwnOrg.name -- add this condiiton only if you wish to check records where the orgs are not matching
;
