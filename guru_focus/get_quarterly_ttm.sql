SELECT *
FROM get_quarterly_ttm(
    'fiscal_period',
    'eps_without_nri',
    'per_share_data',
    'symbol',
    'AAPL',
    '2014-01-01',
    '2024-12-31'
);